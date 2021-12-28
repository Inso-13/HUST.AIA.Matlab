% 顾客类
classdef Client < Rect
    properties
        isWaiting = 0;      % 顾客是否在等待
        onSeatIndex = -1;   % 顾客在等待时，座位的序号
        waitingTime = 0;    % 顾客的总等待时间

        isBeingServed = 0;  % 顾客是否正在被服务
        byServerIndex = -1; % 顾客在被服务时，服务台的序号
        beingServedTime = 0;% 顾客被服务的总时间

        isServed = 0;       % 顾客是否已经完成被服务
    end

    methods
        function obj = setIndex(obj, index)
            obj.index = index;
            obj.name = char(strcat('顾客', num2str(index)));
        end
    end
end
