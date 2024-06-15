%  Tomohiko Mizutani (June 15, 2024)

function [] = expExtnPerf(datasetOpt)

    %
    % ### DESCRIPTION ###
    % This is a code for evaluating the endmember extraction performance of EEHT on datasets 1 and 2.
    % The experiments are described in Section VI-B of the paper,
    % "Tomohiko Mizutani, Implementing Hottopixx Methods for Endmember Extraction in Hyperspectral Images, arXiv, 2024".
    %
    % ### INPUT ARGUMENT ###
    % datasetOpt = 1: EEHT is applied for dataset 1
    % datasetOpt = 2: EEHT is applied for dataset 2
    %

    switch datasetOpt
        case 1
            load('dataset1.mat', 'W', 'H', 'N', 'r');
        case 2
            load('dataset2.mat', 'W', 'H', 'N', 'r');
    end

    fprintf('[Dataset %d] \n', datasetOpt);

    Wtrue = W;
    Htrue = H;

    para = setPara;

    lambda = para.lambda;
    mu = para.mu;
    n = size(H, 2);

    if lambda * r + mu > n

        fprintf('Please modify the values of lambda and mu so that lambda * r + mu <= n. \n');

    else

        algo = struct('name', [], 'idxLst', [], 'aveMrsaLst', []);

        minDelta = 0;
        maxDelta = 1;
        p = 20;

        deltaLst = linspace(minDelta, maxDelta, p);

        for i = 1:p

            fprintf('%d / %d \n', i, p);

            normN = norm(N, 1);
            delta = deltaLst(i);

            A = Wtrue * Htrue + (delta / normN) * N;

            [K1, K2, K3, ~] = eeht(A, r, para);

            algo(1).name = 'EEHT-A';
            algo(1).idxLst(i, :) = K1;
            [tab, ~] = getMrsaTable(A(:, K1), Wtrue);
            algo(1).aveMrsaLst(i) = mean(diag(tab));

            algo(2).name = 'EEHT-B';
            algo(2).idxLst(i, :) = K2;
            [tab, ~] = getMrsaTable(A(:, K2), Wtrue);
            algo(2).aveMrsaLst(i) = mean(diag(tab));

            algo(3).name = 'EEHT-C';
            algo(3).idxLst(i, :) = K3;
            [tab, ~] = getMrsaTable(A(:, K3), Wtrue);
            algo(3).aveMrsaLst(i) = mean(diag(tab));

        end

        fileName = strcat('rsltExtnPerf_dataset', num2str(datasetOpt));
        save(fileName, 'algo');

    end

end
