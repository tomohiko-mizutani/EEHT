%  Tomohiko Mizutani (June 15, 2024)

function [L, yMat, v, optValP, K, ptLst, nSolLP] = phaseOne(A, r, L, para)

    flag_disp = para.flag_disp;

    if flag_disp == 1
        fprintf('[Phase One]\n');
    end

    n = size(A, 2);

    iter = 1;

    while (1)

        if flag_disp == 1

            fprintf('# Iter = %d #\n', iter);
            fprintf('|L| = %d \n', size(L, 2));

        end

        [xMat, yMat, v, optValP] = solveRhtDual(A(:, L), r, para);

        dVec = diag(xMat);

        idxLst = [1:n];
        I = idxLst(dVec > 0);

        pVec = dVec(I, 1);
        B = A(:, L);
        C = B(:, I);

        cL = setdiff([1:n], L);
        aeSet = checkFeas(A, C, pVec, cL, optValP, para);

        if flag_disp == 1
            fprintf('|aeSet| = %d \n\n', size(aeSet, 2));
        end

        if isempty(aeSet) == 1

            ptLst = zeros(n, 1);
            ptLst(L, 1) = dVec;

            [~, idxLst] = sort(dVec, 'descend');
            J = idxLst([1:r])';

            K = sort(L(J));

            nSolLP = iter;

            break;

        else

            L = [L, aeSet];
            iter = iter + 1;

        end

    end

end
