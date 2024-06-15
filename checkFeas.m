%  Tomohiko Mizutani (June 15, 2024)

function [aeSet] = checkFeas(A, C, pVec, cL, optValP, para)

    zeroTol = para.zeroTol;

    d = size(A, 1);

    numXVars = size(C, 2);
    numYVars = d;

    % Objective function
    f = [zeros(numXVars, 1); ones(numYVars, 1)];

    % Inequality constraint
    Aineq = [C, -eye(d); -C, -eye(d)];

    % Equality constraint
    Aeq = [];
    beq = [];

    % Lower and upper bound on variables
    lb = [zeros(numXVars, 1); -inf * ones(numYVars, 1)];
    ub = [pVec; inf * ones(numYVars, 1)];

    aeSet = [];
    numData = size(cL, 2);

    for i = 1:numData

        idx = cL(i);
        aVec = A(:, idx);
        bineq = [aVec; -aVec];

        opt = cplexoptimset('cplex');
        opt.display = 'off';

        [~, fVal, ~, ~, ~] = cplexlp(f, Aineq, bineq, Aeq, beq, lb, ub, [], opt);

        if fVal - optValP > zeroTol

            aeSet = [aeSet, idx];

        end

    end

end
