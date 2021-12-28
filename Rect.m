classdef Rect < handle
    properties
        x=-1;   % 横轴位置
        y=-1;   % 纵轴位置
        w=-1;   % 横轴宽度
        h=-1;   % 纵轴高度

        index = -1; % 对象序号
        name='';    % 对象名称
    end

    methods
        function obj = setPos(obj,x,y,w,h)
            % 设置对象的位置
            obj.x = x;
            obj.y = y;
            obj.w = w;
            obj.h = h;
        end

        function obj = setIndex(obj,index)
            % 设置对象的序号
            obj.index = index;
        end
    end
end
