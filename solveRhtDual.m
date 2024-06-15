%  Tomohiko Mizutani (June 15, 2024)

function [xMat, yMat, v, optValP] = solveRhtDual(A, r, para)

    [d, n] = size(A);
    numVars = n ^ 2 + d * n + 2 * n + 1;

    %% Objective function
    f = -1 * sparse([reshape(A, d * n, 1); sparse(n, 1); r; ones(n, 1); sparse(n ^ 2, 1)]);

    %% 1st constraint

    % A1
    A1 = sparse([kron(speye(n), A)]);

    % b
    I = speye(n);
    b = reshape(I, 1, n ^ 2);

    % A4
    I = speye(n);

    clear L;

    for i = 1:n

        L{i} = I(i, :);

    end

    A4 = sparse(blkdiag(L{:}));

    % A5
    I = speye(n);

    A5 = [];

    for i = 1:n

        J = sparse(n, n);
        J(:, i) = ones(n, 1);

        A5 = sparse([A5; kron(speye(n) - J, I(i, :))]);

    end

    C1 = [A1', sparse(n ^ 2, n), b', A4', A5'];
    rhv1 = sparse(n ^ 2, 1);

    %% 2nd constraint

    % A2
    A2 = [speye(d * n), -speye(d * n)];

    % A3
    A3 = sparse([kron(speye(n), ones(1, d)), kron(speye(n), ones(1, d))]);

    C2 = [A2', A3', sparse(2 * d * n, n ^ 2 + n + 1)];
    rhv2 = sparse(2 * d * n, 1);

    %% 3rd constraint
    C3 = [sparse(1, d * n), -ones(1, n), sparse(1, n ^ 2 + n + 1)];
    rhv3 = 1;

    %%%
    Aeq = [];
    beq = [];

    Aineq = [C1; C2; C3];
    bineq = [rhv1; rhv2; rhv3];

    lb = sparse(-inf * ones(numVars, 1));
    ub = sparse([inf * ones(d * n, 1); sparse(n, 1); inf; sparse(n ^ 2 + n, 1)]);

    opt = cplexoptimset('cplex');
    opt.display = 'off';
    %opt.Algorithm = 'interior-point';

    [sol, fVal, ~, ~, lambda] = cplexlp(f, Aineq, bineq, Aeq, beq, lb, ub, [], opt);

    % Get the optimal value
    optValP = -fVal;

    % Get the optimal solution of dual problem
    dSol = sol;

    % Get the optimal solution of primal problem
    pSol_part1 = lambda.ineqlin([1:n ^ 2 + 2 * d * n], 1);
    pSol_part2 ...
        = lambda.upper([d * n + n + 1 + n + 1:d * n + n + 1 + n + n ^ 2], 1);
    pSol_part3 ...
        = lambda.upper([d * n + 1:d * n + n], 1);
    pSol_part4 ...
        = lambda.upper([d * n + n + 1 + 1:d * n + n + 1 + n], 1);
    pSol_part5 = lambda.ineqlin(n ^ 2 + 2 * d * n + 1, 1);

    pSol = [pSol_part1; pSol_part2; pSol_part3; pSol_part4; pSol_part5];

    x = pSol([1:n ^ 2], 1);
    xMat = reshape(x, [n, n]);

    y = dSol([1:d * n], 1);
    yMat = reshape(y, [d, n]);

    v = dSol(d * n + n + 1, 1);

end
