classdef Rect < handle
    properties
        x=-1;   % ����λ��
        y=-1;   % ����λ��
        w=-1;   % ������
        h=-1;   % ����߶�

        index = -1; % �������
        name='';    % ��������
    end

    methods
        function obj = setPos(obj,x,y,w,h)
            % ���ö����λ��
            obj.x = x;
            obj.y = y;
            obj.w = w;
            obj.h = h;
        end

        function obj = setIndex(obj,index)
            % ���ö�������
            obj.index = index;
        end
    end
end
