%  Tomohiko Mizutani (June 15, 2024)

function [abdMapCube] = getAbdMap(A, W)

    nRow = 307;
    nCol = 307;

    H = compH(A, W);
    r = size(H, 1);

    abdMapCube = [];

    for i = 1:r

        hVec = H(i, :);
        hVec = hVec / max(hVec);

        abdMapCube(:, :, i) = reshape(hVec, nRow, nCol);

    end

end

%%%%%%%%
function [X] = compH(A, W)

    d = size(W, 2);
    n = size(A, 2);

    A = getL1Normal(A);
    W = getL1Normal(W);

    P = W' * W;

    X = [];

    for j = 1:n

        qVec = -1 * W' * A(:, j);

        Aineq = [];
        bineq = [];

        Aeq = ones(1, d);
        beq = 1;

        lb = zeros(d, 1);
        ub = inf * ones(d, 1);

        options = optimset('Display', 'off');
        [x, ~, ~, ~] = quadprog(P, qVec, Aineq, bineq, Aeq, beq, lb, ub, [], options);

        X(:, j) = x;

    end

end

%%%%%%%%
function [A] = getL1Normal(A)

    n = size(A, 2);

    isVec = (1 ./ sum(abs(A)))';
    A = A * spdiags(isVec, 0, n, n);

end
