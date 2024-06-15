%  Tomohiko Mizutani (June 15, 2024)

function para = setPara()

    % Write the path to cplexlp.m
    cplexPath = '/Applications/CPLEX_Studio1210/cplex/matlab/x86-64_osx';

    lambda = 3;
    mu = 15;

    %% Parameter values used for running expExtnPerf.m
    %lambda = 10;
    %mu = 100;

    %% Parameter values used for running expUnmixUrban.m
    %lambda = 50;
    %mu = 300;

    flag_disp = 1;

    zeroTol = 1.0e-6;
    seed_initSet = 3887;

    %%%%%%%%%
    para.lambda = lambda;
    para.mu = mu;
    para.zeroTol = zeroTol;
    para.seed_initSet = seed_initSet;
    para.flag_disp = flag_disp;

    addpath(cplexPath);

end
