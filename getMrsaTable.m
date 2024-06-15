%  Tomohiko Mizutani (June 15, 2024)

function [mrsaTable, idxOrder] = getMrsaTable(West, Wtrue)

    [d, r] = size(West);

    mrsaTable = zeros(r, r);

    for j = 1:r

        westVec = West(:, j);
        westVec_bar = westVec - mean(westVec) * ones(d, 1);

        for i = 1:r

            wtrueVec = Wtrue(:, i);
            wtrueVec_bar = wtrueVec - mean(wtrueVec) * ones(d, 1);

            nume = westVec_bar' * wtrueVec_bar;
            deno = norm(westVec_bar, 2) * norm(wtrueVec_bar, 2);

            mrsaTable(j, i) = (100 / pi) * acos(min(nume / deno, 1));

        end

    end

    solMat = solveAssignmentProb(mrsaTable);
    [idxOrder, ~] = find(solMat);

    mrsaTable = mrsaTable(idxOrder, :);

end

%%%%%%%%
function [solMat] = solveAssignmentProb(rTable)

    zeroTol = 1.0e-5;

    n = size(rTable, 1);
    cVec = reshape(rTable', n ^ 2, 1);

    upperA = repmat(eye(n, n), 1, n);
    lowerA = kron(eye(n, n), ones(1, n));

    Aeq = [upperA; lowerA];
    beq = ones(2 * n, 1);
    lb = zeros(n ^ 2, 1);

    options = optimset('Display', 'off', 'Algorithm', 'dual-simplex');
    [solVec, ~, ~, ~] = linprog(cVec, [], [], Aeq, beq, lb, [], options);

    solMat = reshape(solVec, n, n)';

    for i = 1:n

        for j = 1:n

            val = solMat(i, j);

            if val > 1 - zeroTol && val < 1 + zeroTol

                solMat(i, j) = 1;

            else

                solMat(i, j) = 0;

            end

        end

    end

end
