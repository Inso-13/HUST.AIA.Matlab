% ��λ��
classdef Seat < Rect
    properties
        isEmpty = 1;        % ��λ�Ƿ����
        seatingWho = -1;    % ���ڸ���λ�ϵĹ˿͵����
    end

    methods
        function obj = setIndex(obj, index)
            obj.index = index;
            obj.name = char(strcat('��λ', num2str(index)));
        end
    end
end