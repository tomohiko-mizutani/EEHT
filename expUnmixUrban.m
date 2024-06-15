%  Tomohiko Mizutani (June 15, 2024)

function [] = expUnmixUrban(preprocOpt)

    %
    % ### DESCRIPTION ###
    % This is a code for applying EEHT-C with preprocessing for Urban HSI.
    % The experiments are described in Section VI-C of the paper,
    % "Tomohiko Mizutani, Implementing Hottopixx Methods for Endmember Extraction in Hyperspectral Images, arXiv, 2024".
    %
    % ### INPUT ARGUMENT ###
    % preprocOpt = 1: (phi, omega) = (0.4, 0.1)
    % preprocOpt = 2: (phi, omega) = (0.45, 0.15)
    % preprocOpt = 3: (phi, omega) = (0.5, 0.3)
    % preprocOpt = 4: (phi, omega) = (0.55, 0.45)
    % preprocOpt = 5: (phi, omega) = (0.6, 0.6)
    %

    load('urban.mat', 'A');

    para = setPara;

    switch preprocOpt
        case 1
            load('urban.mat', 'outIdxLst_40_10');
            outIdxLst = outIdxLst_40_10;
        case 2
            load('urban.mat', 'outIdxLst_45_15');
            outIdxLst = outIdxLst_45_15;
        case 3
            load('urban.mat', 'outIdxLst_50_30');
            outIdxLst = outIdxLst_50_30;
        case 4
            load('urban.mat', 'outIdxLst_55_45');
            outIdxLst = outIdxLst_55_45;
        case 5
            load('urban.mat', 'outIdxLst_60_60');
            outIdxLst = outIdxLst_60_60;
    end

    B = A;
    B(:, outIdxLst) = [];

    r = 6;
    n = size(B, 2);
    lambda = para.lambda;
    mu = para.mu;

    if lambda * r + mu > n

        fprintf('Please modify the values of lambda and mu so that lambda * r + mu <= n. \n');

    else

        fprintf('[Unmixing of Urban HSI with preprocessing %d] \n', preprocOpt);
        [~, ~, K, ~] = eeht(B, r, para);

        %% EEHT-C
        W = B(:, K);
        abdMap = getAbdMap(A, W);

        fileName = strcat('rsltUnmixUrban_preproc', num2str(preprocOpt));
        save(fileName, 'abdMap', 'K');

    end

end
