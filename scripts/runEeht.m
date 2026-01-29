clear;

d = 100;
n = 500;
factorRank = 10;
nu = 0.1;
seed = 276;

opts.displayFlag = 0; 

[A, gtIndices] = genNormalData(d, n, factorRank, nu, seed);

startTime = tic;
[outIndices, ~, opts] = eeht(A, factorRank, opts);
elapsedTime = toc(startTime);

plotOpts(opts);
plotEehtResults(A, gtIndices, outIndices, elapsedTime);