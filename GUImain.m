clc;
clear;
close all;

% ��Ļ�ֱ�������
monitorW = 1920;
monitorH = 1080;

% ���������ʼ��
clientNum = 1;
clients(1,300)=Client();

% ��������ʼ��
hFigure = figure('Color', [1, 1, 1], ...
'Position', [0.2 * monitorW, 0.2 * monitorH, 0.4 * monitorW, 0.4 * monitorH], ...
'Name', 'M/M/N �Ŷӷ���ϵͳ', 'NumberTitle', 'off', 'MenuBar', 'none', 'Resize', 'off');

Draw(hFigure, monitorW, monitorH, [], []);
[serverNum, seatNum, serverTime, totalTime, clientFrequency] = GetSettings();
[servers, seats]=UpdateSettings(hFigure, monitorW, monitorH, serverNum, seatNum);

% ����λ��
exitRect = Rect();
exitRect.setPos(monitorW * 0.4 * 7/10 - 25, 25, 0, 0);

% ��¼���һ����������Ĺ˿͵ı��
lastServedClient = 0;
Draw(hFigure, monitorW, monitorH, servers, seats);

% ����ÿһ��ʱ������
for t = 1:totalTime
    % ���ɹ˿�
    randomNum = random('Poisson', clientFrequency);
    % ����Ƿ��иշ�����ķ���̨
    for serverIndex = 1:serverNum
        thisServer = servers(serverIndex);
        if thisServer.isEmpty == 0 && clients(thisServer.servingWho).beingServedTime >= serverTime
            thisClient = clients(thisServer.servingWho);
            DrawPath(hFigure, thisClient, exitRect);
            uicontrol(hFigure, 'style', 'text', 'Position', [thisClient.x, thisClient.y, thisClient.w, thisClient.h], 'String', '', 'backgroundColor', '[0.9,0.9,0.9]', 'fontSize', 10);
            thisClient.isBeingServed = 0;
            thisClient.isServed = 1;
            thisServer.isEmpty = 1;
            lastServedClient = thisClient.index;
            % �ȴ��Ĺ˿�����
            for clientIndex = lastServedClient + 1:clientNum-1
                if clients(clientIndex).isWaiting == 1
                    thisClient = clients(clientIndex);
                    seats(thisClient.onSeatIndex).isEmpty = 1;
                    seats(thisClient.onSeatIndex).seatingWho = -1;
                    thisClient.isWaiting = 0;
                    thisClient.isBeingServed = 1;
                    thisClient.byServerIndex = thisServer.index;
                    thisServer.servingWho = thisClient.index;
                    thisServer.isEmpty = 0;
                    DrawPath(hFigure, thisClient, thisServer);
                    uicontrol(hFigure, 'style', 'text', 'Position', [thisClient.x, thisClient.y, thisClient.w, thisClient.h], 'String', seats(thisClient.onSeatIndex).name, 'backgroundColor', '[1,1,1]', 'fontSize', 10);
                    thisClient.setPos(thisServer.x + thisServer.w / 2 - thisClient.w / 2, thisServer.y - thisClient.h * 1.5, thisClient.w, thisClient.h);
                    uicontrol(hFigure, 'style', 'text', 'Position', [thisClient.x, thisClient.y, thisClient.w, thisClient.h], 'String', thisClient.name, 'backgroundColor', '[0.5,0.5,0.5]', 'fontSize', 10);
                    break;
                end
            end
        end
    end

    % ����������ɵĹ˿�
    if randomNum > 0
        clients(clientNum) = Client();
        thisClient = clients(clientNum);
        thisClient.setPos(monitorW * 0.4 * 3 / 10 - 25, 25, 50, 50);

        thisClient.setIndex(clientNum);
        clientNum = clientNum + 1;
        uicontrol(hFigure, 'style', 'text', 'Position', [thisClient.x, thisClient.y, thisClient.w, thisClient.h], 'String', thisClient.name, 'backgroundColor', '[0.5,0.5,0.5]', 'fontSize', 10);

        emptyServerFlag = 0;
        % �Ƿ���Ŀǰ���еķ���̨
        for serverIndex = 1:serverNum
            if servers(serverIndex).isEmpty == 1
                DrawPath(hFigure, thisClient, servers(serverIndex));
                uicontrol(hFigure, 'style', 'text', 'Position', [thisClient.x, thisClient.y, thisClient.w, thisClient.h], 'String', '', 'backgroundColor', '[0.9,0.9,0.9]', 'fontSize', 10);
                thisClient.isBeingServed = 1;
                thisClient.byServerIndex = serverIndex;
                servers(serverIndex).isEmpty = 0;
                servers(serverIndex).servingWho = thisClient.index;
                thisClient.setPos(servers(serverIndex).x + servers(serverIndex).w / 2 - thisClient.w / 2, servers(serverIndex).y - thisClient.h * 1.5, thisClient.w, thisClient.h);
                uicontrol(hFigure, 'style', 'text', 'Position', [thisClient.x, thisClient.y, thisClient.w, thisClient.h], 'String', thisClient.name, 'backgroundColor', '[0.5,0.5,0.5]', 'fontSize', 10);
                emptyServerFlag = 1;
                break
            end
        end

        if emptyServerFlag == 0
            emptyFlag = 0;
            % �Ƿ���Ŀǰ���е���λ
            for seatIndex = 1:seatNum
                if seats(seatIndex).isEmpty == 1
                    DrawPath(hFigure,thisClient,seats(seatIndex));
                    uicontrol(hFigure, 'style', 'text', 'Position', [thisClient.x, thisClient.y, thisClient.w, thisClient.h], 'String', '', 'backgroundColor', '[0.9,0.9,0.9]', 'fontSize', 10);
                    thisClient.isWaiting = 1;
                    thisClient.onSeatIndex = seatIndex;
                    seats(seatIndex).isEmpty = 0;
                    seats(seatIndex).seatingWho = thisClient.index;
                    thisClient.setPos(seats(seatIndex).x, seats(seatIndex).y, seats(seatIndex).w,seats(seatIndex).h);
                    uicontrol(hFigure, 'style', 'text', 'Position', [thisClient.x, thisClient.y, thisClient.w, thisClient.h], 'String', thisClient.name, 'backgroundColor', '[0.5,0.5,0.5]', 'fontSize', 10);
                    emptyFlag = 1;
                    break
                end
            end
        else 
            emptyFlag = 1;
        end
        % ��û�У��˿�ֱ���뿪
        if emptyFlag == 0
            DrawPath(hFigure, thisClient, exitRect);
            uicontrol(hFigure, 'style', 'text', 'Position', [thisClient.x, thisClient.y, thisClient.w, thisClient.h], 'String', '', 'backgroundColor', '[0.9,0.9,0.9]', 'fontSize', 10);
        end
    end
    % ����ʱ�����
    for serverIndex = 1:serverNum
        thisServer = servers(serverIndex);
        if thisServer.isEmpty == 0
            clients(thisServer.servingWho).beingServedTime = clients(thisServer.servingWho).beingServedTime+1;
        end
    end
    % �ȴ�ʱ�����
    for seatIndex = 1:seatNum
        thisSeat = seats(seatIndex);
        if thisSeat.isEmpty == 0
            clients(thisSeat.seatingWho).waitingTime = clients(thisSeat.seatingWho).waitingTime + 1;
        end
    end
end


W = 0;
Wq = 0;
for clientIndex = 1:clientNum-1
    thisClient = clients(clientIndex);
    W = W + thisClient.waitingTime + thisClient.beingServedTime;
    Wq = Wq + thisClient.waitingTime;
end

W = W / (clientNum-1);
Wq = Wq / (clientNum-1);

L = W * clientFrequency;
Lq = Wq * clientFrequency;
fprintf('����ֵ���Ŷӵȴ���ƽ������Ϊ%5.2f��\n', Lq)
fprintf('����ֵ��ϵͳ�ڵ�ƽ������Ϊ%5.2f��\n', L)
fprintf('����ֵ��ƽ������ʱ��Ϊ%5.2f��\n', W)
fprintf('����ֵ��ƽ���ȴ�ʱ��Ϊ%5.2f��\n', Wq)