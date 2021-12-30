function [servers, seats] = UpdateSettings(hFigure, monitorW, monitorH, serverNum, seatNum, serverTime)
    %UpdateSettings - Description
    %
    % Syntax: [servers, seats] = UpdateSettings(hFigure, monitorW, monitorH, serverNum, seatNum, serverTime)
    %
    % Long description
    %
    %   ����ϵͳ�����ã����û��Զ������ú󣬼���ÿһ������̨����λ������λ�ã�Ϊ�������Ƴ�ʼ��ϵͳ���������׼��
    figureW = monitorW * 0.4;
    figureH = monitorH * 0.4;

    serverMarginWFactor = serverNum * 3 + 1;
    serverMarginW = (figureW - 20) / serverMarginWFactor;
    serverSizeW = serverMarginW * 2;
    serverSizeH = (figureH - 20) / 8;
    servers(1, serverNum) = Server();
    % ����ÿһ������̨������λ��
    for serverIndex = 1:serverNum
        thisServer = servers(serverIndex);
        thisServer.setPos((serverIndex - 1) * serverSizeW + serverIndex * serverMarginW + 10,(figureH - 20) / 4 * 3,serverSizeW,serverSizeH);
        thisServer.setIndex(serverIndex);
        thisServer.serverTime = exprnd(serverTime);
    end

    seatMarginWFactor = (floor((seatNum + 1) / 2)) * 3 + 1;
    seatMarginW = (figureW - 20) / seatMarginWFactor;
    seatSizeW = seatMarginW * 2;
    seatSizeH = (figureH - 20) / 10;
    seats(1,seatNum) = Seat();
    % �����һ��ÿһ����λ������λ��
    for seatIndex = 1:floor((seatNum + 1) / 2)
        thisSeat = seats(seatIndex);
        thisSeat.setPos((seatIndex - 1) * seatSizeW + seatIndex * seatMarginW + 10, (figureH - 20) / 5 + 1.5 * seatSizeH, seatSizeW, seatSizeH);
        thisSeat.setIndex(seatIndex);
    end

    % ����ڶ���ÿһ����λ������λ��
    for seatIndexP = floor((seatNum + 1) / 2) + 1:seatNum
        thisSeat = seats(seatIndexP);
        thisSeat.setIndex(seatIndexP);
        seatIndex = seatIndexP - floor((seatNum + 1) / 2);
        thisSeat.setPos((seatIndex - 1) * seatSizeW + seatIndex * seatMarginW + 10, (figureH - 20) / 5, seatSizeW, seatSizeH);
    end

    Draw(hFigure, monitorW, monitorH, servers, seats);
end
