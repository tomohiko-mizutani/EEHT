%  Tomohiko Mizutani (June 15, 2024)

function I = spa(A, r)

    R = sum(A .^ 2);

    initR = R;
    I = [];

    for i = 1:r

        [maxVal, idx] = max(R);
        idx = checkTie(R, initR, maxVal, idx);

        I = [I, idx];

        uVec = A(:, idx);

        for j = 1:i - 1

            val = U(:, j)' * uVec;
            uVec = uVec - val * U(:, j);

        end

        uVec = uVec / norm(uVec, 2);
        U(:, i) = uVec;

        R = R - (uVec' * A) .^ 2;

    end

end

%%%%%%%%
function [idx] = checkTie(R, initR, maxVal, idx)

    idxLst = find((maxVal - R) / maxVal <= 1e-6);

    if length(idxLst) > 1

        [~, subIdx] = max(initR(idxLst));
        idx = idxLst(subIdx);

    end

end
