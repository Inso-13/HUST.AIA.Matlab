classdef Client < Rect
    properties
        isWaiting = 0;
        onSeatIndex = -1;
        waitingTime = 0;

        isBeingServed = 0;
        byServerIndex = -1;
        beingServedTime = 0;

        isServed = 0;
    end

    methods
        function obj = setIndex(obj, index)
            obj.index = index;
            obj.name = char(strcat('¹Ë¿Í', num2str(index)));
        end
    end
end
