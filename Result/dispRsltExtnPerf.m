function [] = dispRsltExtnPerf(datasetOpt)


    switch datasetOpt
        case 1
            load('rsltExtnPerf_dataset1.mat', 'algo');
        case 2
            load('rsltExtnPerf_dataset2.mat', 'algo');
    end

    minDelta = 0;
    maxDelta = 1;
    p = 20;

    deltaLst = linspace(minDelta, maxDelta, p);

    figure()

    plotEEHT_A = plot(deltaLst, algo(1).aveMrsaLst, ...
        'd-', ...
        'Color', '#77AC30', ...
        'MarkerSize', 12, ...
        'LineWidth', 2);
    hold on

    plotEEHT_B = plot(deltaLst, algo(2).aveMrsaLst, ...
        's-', ...
        'Color', '#0072BD', ...
        'MarkerSize', 12, ...
        'LineWidth', 2);
    hold on

    plotEEHT_C = plot(deltaLst, algo(3).aveMrsaLst, ...
        'o-', ...
        'Color', '#D95319', ...
        'MarkerSize', 12, ...
        'LineWidth', 2);
    hold off

    switch datasetOpt
        case 1
            title('Dataset 1 generated from Jasper Ridge HSI');
        case 2
            title('Dataset 2 generated from Samson HSI');
    end

    xlim([-0.005 1.005]);
    ylim([-0.05 55]);

    xlabel('$\nu$', 'Interpreter', 'latex');
    ylabel('Average MRSA');

    legend([plotEEHT_A, plotEEHT_B, plotEEHT_C], ...
        'EEHT-A', 'EEHT-B', 'EEHT-C', 'Location', 'northeast');

    set(gca, 'FontSize', 20, 'FontName', 'Arial');

end
