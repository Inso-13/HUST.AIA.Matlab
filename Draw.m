function Draw(hFigure, monitorW, monitorH, servers, seats)
    %myFun - Description
    %
    % Syntax: UpdateSettings(serverNum,seatNum)
    %
    % Long description
    figureW = monitorW * 0.4;
    figureH = monitorH * 0.4;
    serverNum = length(servers);
    seatNum = length(seats);

    uicontrol(hFigure, 'style', 'text', 'Position', [10, 10, figureW - 20, figureH - 20], 'String', 'M/M/N 仿真系统', 'backgroundColor', '[0.9,0.9,0.9]', 'fontWeight', 'bold', 'fontSize', 20);
    uicontrol(hFigure, 'style', 'text', 'Position', [figureW / 5, 5, figureW / 5, 20], 'String', '入口', 'backgroundColor', '[1,1,1]', 'fontSize', 8);
    uicontrol(hFigure, 'style', 'text', 'Position', [figureW / 5 * 3, 5, figureW / 5, 20], 'String', '出口', 'backgroundColor', '[1,1,1]', 'fontSize', 8);

    for serverIndex = 1:serverNum
        thisServer = servers(serverIndex);
        uicontrol(hFigure, 'style', 'text', 'Position', [thisServer.x,thisServer.y,thisServer.w,thisServer.h], 'String', thisServer.name, 'backgroundColor', '[1,1,1]', 'fontSize', 10);
    end

    for seatIndex = 1:seatNum
        thisSeat = seats(seatIndex);
        uicontrol(hFigure, 'style', 'text', 'Position', [thisSeat.x,thisSeat.y,thisSeat.w,thisSeat.h], 'String', thisSeat.name, 'backgroundColor', '[1,1,1]', 'fontSize', 10);
    end
end
