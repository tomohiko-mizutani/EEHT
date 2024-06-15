%  Tomohiko Mizutani (June 15, 2024)

function [] = run_eeht()

    %
    % ### DESCRIPTION ###
    % This is a code for performing EEHT on a noisy separable matrix A.
    %
    % ### INPUT ###
    % A = W * H + N : noisy separable matrix of size d * n with factorization rank r
    %
    % d                 : Number of rows
    % n                 : Number of columns
    % r                 : Factorization rank
    % delta             : Noise intensity, i.e, delta = ||N||_1
    % dataType          : Choose 'normal' or 'ill-conditioned'
    % cVal              : Parameter for generating alpha such that alpha^(r-1) = 10^(-cVal)
    % seed              : Seed of random numbers
    %
    % For the details of input matrices, see the paper "Tomohiko Mizutani,
    % Refinement of Hottopixx Method for Nonnegative Matrix Factorization Under Noisy Separability,
    % SIAM Journal on Matrix Analysis and Applications, 43(3):1029-1057, 2022."
    %
    % ### OUTPUT ###
    % Recovery rates by EEHT-A, -B, -C
    %

    d = 30;
    n = 100;
    r = 5;
    delta = 0.05;

    dataType = 'normal';
    %dataType = 'ill-conditioned';
    %cVal = 3;

    seed = 276;

    para = setPara;

    lambda = para.lambda;
    mu = para.mu;

    if lambda * r + mu > n

        fprintf('Please modify the values of lambda and mu so that lambda * r + mu <= n. \n');

    else

        switch dataType
            case 'normal'
                [A, Ktrue] = genNormalData(d, n, r, delta, seed);
            case 'ill-conditioned'
                [A, Ktrue] = genIllcondData(d, n, r, delta, cVal, seed);
        end

        [K1, K2, K3, ~] = eeht(A, r, para);

        rr1 = compRecoveryRate(Ktrue, K1);
        rr2 = compRecoveryRate(Ktrue, K2);
        rr3 = compRecoveryRate(Ktrue, K3);

        fprintf('-----------------------\n');
        fprintf('[Recovery Rates] \n');
        fprintf('EEHT-A: %1.3f \n', rr1);
        fprintf('EEHT-B: %1.3f \n', rr2);
        fprintf('EEHT-C: %1.3f \n', rr3);

    end

end

%%%%%%%%
function rr = compRecoveryRate(Ktrue, K)

    corrNum = size(intersect(Ktrue, K), 2);
    rr = corrNum / size(Ktrue, 2);

end
