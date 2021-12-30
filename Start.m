function Start(servers, seats, clients, clientFrequency, serverTime, totalTime, hFigure, monitorW)
    %myFun - Description
    %
    % Syntax: Start()
    %
    % Long description
    
    % ����λ��
    exitRect = Rect();
    exitRect.setPos(monitorW * 0.4 * 7/10 - 25, 25, 0, 0);

    % ��¼���һ����������Ĺ˿͵ı��
    serverNum = length(servers);
    seatNum = length(seats);
    clientNum = 1;
    global stopNow;
    stopNow = 0;
    H = findobj('String', '��ʼ');
    set(H,'String', 'ֹͣ');
    set(H, 'call', 'Stop();')


    % ����ÿһ��ʱ������
    for t=1:totalTime
        if stopNow == 1
            proptm = {'����ֵ���Ŷӵȴ���ƽ��������', '����ֵ��ƽ���ȴ�ʱ�䣺', '����ֵ��ϵͳ�ڵ�ƽ��������', '����ֵ��ƽ������ʱ�䣺', '����ֵ��ϵͳ�ڵ�ƽ��������', '����ֵ��ƽ���ȴ�ʱ�䣺', '����ֵ��ϵͳ�ڵ�ƽ��������', '����ֵ��ƽ������ʱ�䣺'};
            W = 0;
            Wq = 0;
            clientNum = length(clients);
            for clientIndex = 1:clientNum - 1
                thisClient = clients(clientIndex);
                W = W + thisClient.waitingTime + thisClient.beingServedTime;
                Wq = Wq + thisClient.waitingTime;
            end
            W = W / (clientNum - 1);
            Wq = Wq / (clientNum - 1);
            L = W * clientFrequency;
            Lq = Wq * clientFrequency;

            service = 1.0/serviceTime ; a_s = clientFrequency / 1;
            %�����ǿ��
            service_strength = clientFrequency / (serverNum * service);
            %��P_0ʽ�ӵ��������д�k�ļ����Ͳ��ֵ�ֵ
            sum_1 = 0;
            for k = 0:(serverNum - 1)
                sum_1 = sum_1 + a_s^k / factorial(k);
            end
            %��P_0ʽ�ӵ���������ʣ�²��ֵ�ֵ
            sum_2 = a_s^serverNum / (factorial(serverNum) * (1 - service_strength));
            %------------��P_0��ֵ--------------(tʱ��ϵͳ���и���)
            P_0 = 1 / (sum_1 + sum_2);
            %------------��L_q��ֵ--------------(tʱ���Ŷӵ��ÿ���)
            LqReal = a_s^serverNum * service_strength * P_0 / (factorial(serverNum) * (1 - service_strength)^2);
            %------------��W_q��ֵ--------------(tʱ���Ż����Ŷӵ�ʱ��)
            WqReal = LqReal / clientFrequency;
            WReal = WqReal + serverTime;
            LReal = WReal * clientFrequency;

            defaults = {num2str(Lq), num2str(Wq), num2str(L), num2str(W), num2str(RealLq), num2str(RealWq), num2str(RealL), num2str(RealW)};
            inputdlg(proptm, '', 1, defaults);
            close all;
            return;
        end
        % ���ɹ˿�
        randomNum = random('Poisson', clientFrequency);
        % ����Ƿ��иշ�����ķ���̨
        for serverIndex = 1:serverNum
            thisServer = servers(serverIndex);

            if thisServer.isEmpty == 0 && clients(thisServer.servingWho).beingServedTime >= thisServer.serverTime
                thisServer.serverTime = exprnd(serverTime);
                thisClient = clients(thisServer.servingWho);
                DrawPath(hFigure, thisClient, exitRect);
                uicontrol(hFigure, 'style', 'text', 'Position', [thisClient.x, thisClient.y, thisClient.w, thisClient.h], 'String', '', 'backgroundColor', '[0.9,0.9,0.9]', 'fontSize', 10);
                thisClient.isBeingServed = 0;
                thisClient.isServed = 1;
                thisServer.isEmpty = 1;
                lastServedClient = thisClient.index;
                % �ȴ��Ĺ˿�����
                for clientIndex = lastServedClient + 1:clientNum - 1

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
        while randomNum > 0
            randomNum = randomNum - 1;
            clients(clientNum) = Client();
            thisClient = clients(clientNum);
            thisClient.setPos(monitorW * 0.4 * 3/10 - 25, 25, 50, 50);

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
                        DrawPath(hFigure, thisClient, seats(seatIndex));
                        uicontrol(hFigure, 'style', 'text', 'Position', [thisClient.x, thisClient.y, thisClient.w, thisClient.h], 'String', '', 'backgroundColor', '[0.9,0.9,0.9]', 'fontSize', 10);
                        thisClient.isWaiting = 1;
                        thisClient.onSeatIndex = seatIndex;
                        seats(seatIndex).isEmpty = 0;
                        seats(seatIndex).seatingWho = thisClient.index;
                        thisClient.setPos(seats(seatIndex).x, seats(seatIndex).y, seats(seatIndex).w, seats(seatIndex).h);
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
                clients(thisServer.servingWho).beingServedTime = clients(thisServer.servingWho).beingServedTime + 1;
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

    proptm = {'����ֵ���Ŷӵȴ���ƽ��������', '����ֵ��ƽ���ȴ�ʱ�䣺', '����ֵ��ϵͳ�ڵ�ƽ��������', '����ֵ��ƽ������ʱ�䣺', '����ֵ��ϵͳ�ڵ�ƽ��������', '����ֵ��ƽ���ȴ�ʱ�䣺', '����ֵ��ϵͳ�ڵ�ƽ��������', '����ֵ��ƽ������ʱ�䣺'};
    W = 0;
    Wq = 0;
    clientNum = length(clients);

    for clientIndex = 1:clientNum - 1
        thisClient = clients(clientIndex);
        W = W + thisClient.waitingTime + thisClient.beingServedTime;
        Wq = Wq + thisClient.waitingTime;
    end

    W = W / (clientNum - 1);
    Wq = Wq / (clientNum - 1);
    L = W * clientFrequency;
    Lq = Wq * clientFrequency;

    service = 1.0 / serviceTime; a_s = clientFrequency / 1;
    %�����ǿ��
    service_strength = clientFrequency / (serverNum * service);
    %��P_0ʽ�ӵ��������д�k�ļ����Ͳ��ֵ�ֵ
    sum_1 = 0;

    for k = 0:(serverNum - 1)
        sum_1 = sum_1 + a_s^k / factorial(k);
    end

    %��P_0ʽ�ӵ���������ʣ�²��ֵ�ֵ
    sum_2 = a_s^serverNum / (factorial(serverNum) * (1 - service_strength));
    %------------��P_0��ֵ--------------(tʱ��ϵͳ���и���)
    P_0 = 1 / (sum_1 + sum_2);
    %------------��L_q��ֵ--------------(tʱ���Ŷӵ��ÿ���)
    LqReal = a_s^serverNum * service_strength * P_0 / (factorial(serverNum) * (1 - service_strength)^2);
    %------------��W_q��ֵ--------------(tʱ���Ż����Ŷӵ�ʱ��)
    WqReal = LqReal / clientFrequency;
    WReal = WqReal + serverTime;
    LReal = WReal * clientFrequency;

    defaults = {num2str(Lq), num2str(Wq), num2str(L), num2str(W), num2str(RealLq), num2str(RealWq), num2str(RealL), num2str(RealW)};
    inputdlg(proptm, '', 1, defaults);
    close all;
    return;
end