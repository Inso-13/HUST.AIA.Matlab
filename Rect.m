classdef Rect < handle
    properties
        x=-1;
        y=-1;
        w=-1;
        h=-1;

        index = -1;
        name='';
    end

    methods
        function obj = setPos(obj,x,y,w,h)
            obj.x = x;
            obj.y = y;
            obj.w = w;
            obj.h = h;
        end

        function obj = setIndex(obj,index)
            obj.index = index;
        end
    end
end
