global whiteImage
whiteImageCopy = whiteImage;
% Cell decomposition.
for i = 1 : length(CriticalPoint)
    Pos=CriticalPoint(i, :);
    % onlu apply to the critical points inside the area rather than the edge.
    if downFree(Pos) && upFree(Pos)
        count = 1;
        while whiteImage(Pos(2) - count, Pos(1)) == 0 || whiteImage(Pos(2) - count, Pos(1)) == 255
            whiteImageCopy(Pos(2) - count, Pos(1)) = 110;
            count = count + 1;
        end
        count = 1;
        while whiteImage(Pos(2) + count, Pos(1)) == 0 || whiteImage(Pos(2) + count, Pos(1)) == 255
            whiteImageCopy(Pos(2) + count, Pos(1)) = 110;
            count = count + 1;
        end
    end
    whiteImageCopy(Pos(2), Pos(1)) = 110;
end
binaryWhiteImageCopy = ~imbinarize(whiteImageCopy, 0.4);% threshold = 0.4*255 = 102
binaryWhiteImageCopy = bwareaopen(binaryWhiteImageCopy, 50);
labeledWhiteImageCopy = bwlabel(binaryWhiteImageCopy);
% Find start & goal positions for each cell.
stats = regionprops(binaryWhiteImageCopy, 'Centroid');
startPos = zeros(length(stats), 2);
goalPos = zeros(length(stats), 2);
for i = 1 : length(stats)
    [r, c] = find(labeledWhiteImageCopy == i);
    rc = [r c];
    startPos(i, :) = rc(1, :);
    goalYMightBe = r(c == c(end)); 
    validatedColNum = c(end) - c(1) + 1;
    % Calculate the validated column numbers. The columns has only 1 point should be ignored because they don't influent the goal point position.
    for j = c(1) : c(end)
        count = length(c(c == j));
        if count == 1
            validatedColNum = validatedColNum - 1;
        end
    end
    % If validated columns number is even, the goal has the same height as the start.
    if rem(validatedColNum, 2) == 0
        goalPos(i, 1) = rc(1, 1);
        goalPos(i, 2) = c(end);
    % If validated columns number is odd, the goal is on the other side of last column.
    else
        if goalYMightBe(1) ~= rc(1, 1)
            goalPos(i, 1) = goalYMightBe(1);
        else
            goalPos(i, 1) = goalYMightBe(end);
        end
        goalPos(i, 2) = c(end);
    end
end

%% Detect if the upside of the critical point is free.
function [ifFreeSpace] = upFree(Pos)
    global whiteImage
    ifFreeSpace = [];
    for i = 1 : 50
        if Pos(2) - i <= 0
            break
        elseif whiteImage(Pos(2) - i, Pos(1)) == 0
            ifFreeSpace = true; % true = 1
        end
    end
    if isempty(ifFreeSpace)
        ifFreeSpace = false; % false = 0
    end
end

%% Detect if the downside of the critical point is free.
function [ifFreeSpace] = downFree(Pos)
    global whiteImage
    ifFreeSpace = [];
    for i = 1 : 50
        if Pos(2) + i > size(whiteImage, 1) % 266
            break
        elseif whiteImage(Pos(2) + i, Pos(1)) == 0
            ifFreeSpace = true; % true = 1
        end
    end
    if isempty(ifFreeSpace)
        ifFreeSpace = false; % false = 0
    end
end