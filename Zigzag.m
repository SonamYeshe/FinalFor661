%% Require whiteImage & startPos & goalPos
% Initiate start and goal positions.
startPos = [255, 18];
goalPos = [255, 102]; % or [255, 102]. Not sure.[102, 102]
startPosX = startPos(2);
startPosY = startPos(1);
goalPosX = goalPos(2);
goalPosY = goalPos(1);
% 
currentX = startPosX;
currentY = startPosY;
figure (3)
hold on
plot (currentX - 186, currentY - 616, 's', 'MarkerSize', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
pause(0.001)
for i = startPosX : (goalPosX - 1)
    currentX = currentX + 1;
    % check if goal reached.
    if currentX == goalPosX && currentY == goalPosY
        plot (currentX - 186, currentY - 616, 's', 'MarkerSize', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
        pause(0.001)
    end
    % calculate how many steps can go up.
    moveUpAllowance = 0;
    while whiteImage(currentY - moveUpAllowance - 1, currentX) == 0
        moveUpAllowance = moveUpAllowance + 1;
    end
    % calculate how many steps can go down.
    moveDownAllowance = 0;
    while whiteImage(currentY + moveDownAllowance + 1, currentX) == 0
        moveDownAllowance = moveDownAllowance + 1;
    end
    % can only move to the right.
    if moveUpAllowance == 0 && moveDownAllowance == 0
        plot (currentX - 186, currentY - 616, 's', 'MarkerSize', 2, 'MarkerEdgeColor', 'g', 'MarkerFaceColor', 'g');
        pause(0.001)
    % move down-right first. (regard to figure 2)
    elseif moveDownAllowance < moveUpAllowance
        currentY = currentY + moveDownAllowance;
        plot (currentX - 186, currentY - 616, 's', 'MarkerSize', 2, 'MarkerEdgeColor', 'g', 'MarkerFaceColor', 'g');
        pause(0.001)
        for j = 1 : (moveDownAllowance + moveUpAllowance)
            currentY = currentY - 1;
            plot (currentX - 186, currentY - 616, 's', 'MarkerSize', 2, 'MarkerEdgeColor', 'g', 'MarkerFaceColor', 'g');
            pause(0.001)
        end
    % move up-right first. (regard to figure 2)
    else
        currentY = currentY - moveUpAllowance;
        plot (currentX - 186, currentY - 616, 's', 'MarkerSize', 2, 'MarkerEdgeColor', 'g', 'MarkerFaceColor', 'g');
        pause(0.001)
        for j = 1 : (moveDownAllowance + moveUpAllowance)
            currentY = currentY + 1;
            plot (currentX - 186, currentY - 616, 's', 'MarkerSize', 2, 'MarkerEdgeColor', 'g', 'MarkerFaceColor', 'g');
            pause(0.001)
        end
    end
    % check if goal reached.
    if currentX == goalPosX && currentY == goalPosY
        plot (currentX - 186, currentY - 616, 's', 'MarkerSize', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
        pause(0.001)
    end
end