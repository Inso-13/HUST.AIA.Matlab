function [serverNum, seatNum, serverTime, totalTime, clientFrequency] = GetSettings()
%myFun - Description
%
% Syntax: [seatNum, serverNum, seatNum, serverTime, totalTime, clientFrequency] = GetSettings()
%
% Long description
    proptm = {'���÷���̨������', '���õȴ���λ����', '���õ��η�������ʱ�䣺', '����ϵͳ����ʱ�䣺', '���ÿͻ�����Ƶ��(lambda)��'};
    defaults = {'3','20','10','500','0.3'};
    ret = inputdlg(proptm,'',1,defaults);

    serverNum = floor(str2double(cell2mat(ret(1))));
    seatNum = floor(str2double(cell2mat(ret(2))));
    serverTime = str2double(cell2mat(ret(3)));
    totalTime = str2double(cell2mat(ret(4)));
    clientFrequency = str2double(cell2mat(ret(5)));
end