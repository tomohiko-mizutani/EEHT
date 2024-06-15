%  Tomohiko Mizutani (June 15, 2024)

function [L, flag] = phaseTwo(A, L, yMat, v, para)

    flag_disp = para.flag_disp;

    if flag_disp == 1
        fprintf('[Phase Two]\n');
    end

    n = size(A, 2);

    cL = setdiff([1:n], L);
    aeSet = checkRedCost(A, yMat, v, cL, para);

    if flag_disp == 1
        fprintf('|aeSet| = %d \n\n', size(aeSet, 2));
    end

    flag = 0;

    if isempty(aeSet) == 1

        flag = 1;

    else

        L = [L, aeSet];

    end

end
