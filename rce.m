%  Tomohiko Mizutani (June 15, 2024)

function [K, ptLst, optVal, maxColSize, tnSolLP] = rce(A, r, para)

    flag_disp = para.flag_disp;

    %% Find an initial index set

    L = findInitSet(A, r, para);

    if flag_disp == 1
        dispInfo(A, L, para);
    end

    tnSolLP = 0;
    iter = 1;

    while (1)

        if flag_disp == 1
            fprintf('\n##### Outer Iter = %d ##### \n\n', iter);
        end

        [L, yMat, v, optValP, K, ptLst, nSolLP] = phaseOne(A, r, L, para);
        tnSolLP = tnSolLP + nSolLP;

        [L, flag] = phaseTwo(A, L, yMat, v, para);

        if flag == 1

            optVal = optValP;
            maxColSize = size(L, 2);

            break;

        else
            iter = iter + 1;
        end

    end

end

%%%%%%%%
function [] = dispInfo(A, L, para)

    lambda = para.lambda;
    mu = para.mu;

    [d, n] = size(A);
    sizeL = size(L, 2);

    fprintf('Size of A : (%d, %d) \n', d, n);
    fprintf('|L|    = %d \n', sizeL);
    fprintf('lambda = %d \n', lambda);
    fprintf('mu     = %d \n', mu);

end
