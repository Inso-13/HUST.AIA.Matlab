classdef Seat < Rect
    properties
        isEmpty = 1;
        seatingWho = -1;
    end

    methods
        function obj = setIndex(obj, index)
            obj.index = index;
            obj.name = char(strcat('��λ', num2str(index)));
        end
    end
end