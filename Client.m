% �˿���
classdef Client < Rect
    properties
        isWaiting = 0;      % �˿��Ƿ��ڵȴ�
        onSeatIndex = -1;   % �˿��ڵȴ�ʱ����λ�����
        waitingTime = 0;    % �˿͵��ܵȴ�ʱ��

        isBeingServed = 0;  % �˿��Ƿ����ڱ�����
        byServerIndex = -1; % �˿��ڱ�����ʱ������̨�����
        beingServedTime = 0;% �˿ͱ��������ʱ��

        isServed = 0;       % �˿��Ƿ��Ѿ���ɱ�����
    end

    methods
        function obj = setIndex(obj, index)
            obj.index = index;
            obj.name = char(strcat('�˿�', num2str(index)));
        end
    end
end
