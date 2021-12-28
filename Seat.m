% 座位类
classdef Seat < Rect
    properties
        isEmpty = 1;        % 座位是否空闲
        seatingWho = -1;    % 坐在该座位上的顾客的序号
    end

    methods
        function obj = setIndex(obj, index)
            obj.index = index;
            obj.name = char(strcat('座位', num2str(index)));
        end
    end
end