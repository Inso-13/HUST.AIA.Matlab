clc;
clear;
close all;

% 屏幕分辨率设置
monitorW = 1920;
monitorH = 1080;

% 对象数组初始化
clientNum = 1;
clients(1,300)=Client();

% 仿真界面初始化
hFigure = figure('Color', [1, 1, 1], ...
'Position', [0.2 * monitorW, 0.2 * monitorH, 0.4 * monitorW, 0.4 * monitorH], ...
'Name', 'M/M/N 排队仿真系统', 'NumberTitle', 'off', 'MenuBar', 'none', 'Resize', 'off');


Draw(hFigure, monitorW, monitorH, [], []);
[serverNum, seatNum, serverTime, totalTime, clientFrequency] = GetSettings();
[servers, seats] = UpdateSettings(hFigure, monitorW, monitorH, serverNum, seatNum, serverTime);



Draw(hFigure, monitorW, monitorH, servers, seats);

uicontrol(hFigure, 'style', 'pushButton', 'Position', [monitorW * 0.4/5 * 4 + 50, 15, 50, 20], 'String', '开始', 'backgroundColor', '[0.8,0.8,0.8]', 'fontSize', 8, 'call', 'Start(servers, seats, clients, clientFrequency, serverTime, totalTime, hFigure, monitorW)');

