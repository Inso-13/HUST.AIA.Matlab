% ����̨��
classdef Server < Rect
    properties
        isEmpty = 1;        % ����̨�Ƿ����
        servingWho = -1;    % ���ڱ�����Ĺ˿͵����
        serverTime = -1;    % �÷���̨��ʵ�ʷ���ʱ��
    end

    methods 
        function obj = setIndex(obj, index)
            obj.index = index;
            obj.name = char(strcat('����̨', num2str(index)));
        end
    end
end
