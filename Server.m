% 服务台类
classdef Server < Rect
    properties
        isEmpty = 1;        % 服务台是否空闲
        servingWho = -1;    % 正在被服务的顾客的序号
    end

    methods 
        function obj = setIndex(obj, index)
            obj.index = index;
            obj.name = char(strcat('服务台', num2str(index)));
        end
    end
end
