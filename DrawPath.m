function upFlag = DrawPath(hFigure, srcRect, desRect)
    %myFun - Description
    %
    % Syntax: output = myFun(input)
    %
    % Long description
    if desRect.y > srcRect.y
        upFlag = 1;
    elseif desRect.y < srcRect.y
        upFlag = -1;
    else
        upFlag = 0;
    end

    if desRect.x > srcRect.x
        rightFlag = 1;
    elseif desRect.x < srcRect.x
        rightFlag = -1;
    else
        rightFlag = 0;
    end

    point1x = srcRect.x + srcRect.w / 2;
    point1y = srcRect.y + srcRect.h / 2 + upFlag * srcRect.h / 2;

    point2x = point1x;
    point2y = desRect.y + desRect.h / 2 - upFlag * (desRect.h / 2 + 3);

    point3x = desRect.x + desRect.w / 2;

    if upFlag == 1
        uicontrol(hFigure, 'style', 'text', 'Position', [point1x - 1, point1y, 3, max(1, point2y - point1y)], 'backgroundColor', '[1,0,0]');
    elseif upFlag == -1
        uicontrol(hFigure, 'style', 'text', 'Position', [point1x - 1, point2y, 3, max(1, point1y - point2y)], 'backgroundColor', '[1,0,0]');
    end

    if rightFlag == 1
        uicontrol(hFigure, 'style', 'text', 'Position', [point2x, point2y - 1, max(1, point3x - point2x), 3], 'backgroundColor', '[1,0,0]');
    elseif rightFlag == -1
        uicontrol(hFigure, 'style', 'text', 'Position', [point3x, point2y - 1, max(1, point2x - point3x), 3], 'backgroundColor', '[1,0,0]');
    end

    pause(0.1);

    if upFlag == 1
        uicontrol(hFigure, 'style', 'text', 'Position', [point1x - 1, point1y, 3, max(1, point2y - point1y)], 'backgroundColor', '[0.9,0.9,0.9]');
    elseif upFlag == -1
        uicontrol(hFigure, 'style', 'text', 'Position', [point1x - 1, point2y, 3, max(1, point1y - point2y)], 'backgroundColor', '[0.9,0.9,0.9]');
    end

    if rightFlag == 1
        uicontrol(hFigure, 'style', 'text', 'Position', [point2x, point2y - 1, max(1, point3x - point2x), 3], 'backgroundColor', '[0.9,0.9,0.9]');
    elseif rightFlag == -1
        uicontrol(hFigure, 'style', 'text', 'Position', [point3x, point2y - 1, max(1, point2x - point3x), 3], 'backgroundColor', '[0.9,0.9,0.9]');
    end
end
