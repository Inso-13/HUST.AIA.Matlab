function UpdatehMenuSetServerNum(hMenuSetServerNum, hThisMenuSetServerNum)
    %UpdatehMenuSetServerNum - Description
    %
    % Syntax: UpdatehMenuSetServerNum(hMenuSetServerNum)
    %
    % Long description
    children = get(hMenuSetServerNum, 'children');

    for childIndex = 1:6

        if children(childIndex) == hThisMenuSetServerNum
            set(children(childIndex), 'checked', 'on');
        else
            set(children(childIndex), 'checked', 'off');
        end

    end
