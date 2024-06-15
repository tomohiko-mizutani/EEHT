%  Tomohiko Mizutani (June 15, 2024)

function [] = dispRsltUnmixUrban(preprocOpt)

    switch preprocOpt
        case 1
            load('rsltUnmixUrban_preproc1.mat', 'abdMap');
        case 2
            load('rsltUnmixUrban_preproc2.mat', 'abdMap');
        case 3
            load('rsltUnmixUrban_preproc3.mat', 'abdMap');
        case 4
            load('rsltUnmixUrban_preproc4.mat', 'abdMap');
        case 5
            load('rsltUnmixUrban_preproc5.mat', 'abdMap');
    end

    r = 6;

    figure()
    colormap(gray);

    for i = 1:r

        subplot(2, r / 2, i);
        image(abdMap(:, :, i), 'CDataMapping', 'scaled');
        axis off;
    end

    switch preprocOpt

        case 1
            sgtitle('EEHT-C with $(\phi, \omega) = (0.4, 0.1)$', ...
                'FontSize', 20, 'Interpreter', 'latex');
        case 2
            sgtitle('EEHT-C with $(\phi, \omega) = (0.45, 0.15)$', ...
                'FontSize', 20, 'Interpreter', 'latex');
        case 3
            sgtitle('EEHT-C with $(\phi, \omega) = (0.5, 0.3)$', ...
                'FontSize', 20, 'Interpreter', 'latex');
        case 4
            sgtitle('EEHT-C with $(\phi, \omega) = (0.55, 0.45)$', ...
                'FontSize', 20, 'Interpreter', 'latex');
        case 5
            sgtitle('EEHT-C with $(\phi, \omega) = (0.6, 0.6)$', ...
                'FontSize', 20, 'Interpreter', 'latex');
    end

end
