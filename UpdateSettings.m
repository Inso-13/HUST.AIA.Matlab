function [servers, seats] = UpdateSettings(hFigure, monitorW, monitorH, serverNum, seatNum)
    %myFun - Description
    %
    % Syntax: UpdateSettings(serverNum,seatNum)
    %
    % Long description
    figureW = monitorW * 0.4;
    figureH = monitorH * 0.4;

    serverMarginWFactor = serverNum * 3 + 1;
    serverMarginW = (figureW - 20) / serverMarginWFactor;
    serverSizeW = serverMarginW * 2;
    serverSizeH = (figureH - 20) / 8;
    servers(1, serverNum) = Server();

    for serverIndex = 1:serverNum
        thisServer = servers(serverIndex);
        thisServer.setPos((serverIndex - 1) * serverSizeW + serverIndex * serverMarginW + 10,(figureH - 20) / 4 * 3,serverSizeW,serverSizeH);
        thisServer.setIndex(serverIndex);
    end

    seatMarginWFactor = (floor((seatNum + 1) / 2)) * 3 + 1;
    seatMarginW = (figureW - 20) / seatMarginWFactor;
    seatSizeW = seatMarginW * 2;
    seatSizeH = (figureH - 20) / 10;
    seats(1,seatNum) = Seat();

    for seatIndex = 1:floor((seatNum + 1) / 2)
        thisSeat = seats(seatIndex);
        thisSeat.setPos((seatIndex - 1) * seatSizeW + seatIndex * seatMarginW + 10, (figureH - 20) / 5 + 1.5 * seatSizeH, seatSizeW, seatSizeH);
        thisSeat.setIndex(seatIndex);
    end

    for seatIndexP = floor((seatNum + 1) / 2) + 1:seatNum
        thisSeat = seats(seatIndexP);
        thisSeat.setIndex(seatIndexP);
        seatIndex = seatIndexP - floor((seatNum + 1) / 2);
        thisSeat.setPos((seatIndex - 1) * seatSizeW + seatIndex * seatMarginW + 10, (figureH - 20) / 5, seatSizeW, seatSizeH);
    end

    Draw(hFigure, monitorW, monitorH, servers, seats);
end
