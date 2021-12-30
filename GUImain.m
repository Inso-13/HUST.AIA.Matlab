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
[servers, seats] = UpdateSettings(hFigure, monitorW, monitorH, serverNum, seatNum, serverTime);



Draw(hFigure, monitorW, monitorH, servers, seats);

uicontrol(hFigure, 'style', 'pushButton', 'Position', [monitorW * 0.4/5 * 4 + 50, 15, 50, 20], 'String', '��ʼ', 'backgroundColor', '[0.8,0.8,0.8]', 'fontSize', 8, 'call', 'Start(servers, seats, clients, clientFrequency, serverTime, totalTime, hFigure, monitorW)');

