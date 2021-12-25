classdef Server < Rect
    properties
        isEmpty = 1;
        servingWho = -1;
    end

    methods 
        function obj = setIndex(obj, index)
            obj.index = index;
            obj.name = char(strcat('·şÎñÌ¨', num2str(index)));
        end
    end
end
