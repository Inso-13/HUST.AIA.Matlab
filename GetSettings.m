function [serverNum, seatNum, serverTime, totalTime, clientFrequency] = GetSettings()
%GetSettings - Description
%
% Syntax: [seatNum, serverNum, seatNum, serverTime, totalTime, clientFrequency] = GetSettings()
%
% Long description
%
%   得到用户自定义的系统属性
    proptm = {'设置服务台总数：', '设置等待座位数：', '设置单次服务所需时间：', '设置系统仿真时间：', '设置客户到达频率(lambda)：'};
    defaults = {'3','20','5','400','0.3'};
    ret = inputdlg(proptm,'',1,defaults);

    serverNum = floor(str2double(cell2mat(ret(1))));
    seatNum = floor(str2double(cell2mat(ret(2))));
    serverTime = str2double(cell2mat(ret(3)));
    totalTime = str2double(cell2mat(ret(4)));
    clientFrequency = str2double(cell2mat(ret(5)));
end