function path = Zigzag(startPos, goalPos)
    global labeledWhiteImageCopy
    % Initiate start and goal positions.
    startPosX = startPos(2);
    startPosY = startPos(1);
    goalPosX = goalPos(2);
    goalPosY = goalPos(1);
    % Initiate the position list.
    currentPos = [startPosX, startPosY];
    labelID = labeledWhiteImageCopy(startPosY, startPosX);
    [r, c] = find(labeledWhiteImageCopy == labelID);
    posList = [c r];
    % Initiaize path.
    path = zeros(size(posList, 1), 2);
    pathPosCount = 1;
    findGoal = 0;
    currentColumn = posList(posList(:, 1) == currentPos(1), :);
    figure (1)
    hold on
    while ~findGoal
        % Case 1: can only move to the right.
        if size(currentColumn, 1) == 1
            % Plot the positions in the new column ordered by sweeping order.
            path(pathPosCount, :) = currentColumn;
            pathPosCount = pathPosCount + 1;
            if isequal(currentPos, [startPos(2), startPos(1)])
                plot (currentPos(1) - 186, currentPos(2) - 616, 's', 'MarkerSize', 4, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
                pause(0.001)
            else
                plot (currentPos(1) - 186, currentPos(2) - 616, 's', 'MarkerSize', 2, 'MarkerEdgeColor', 'g', 'MarkerFaceColor', 'g');
                pause(0.001)
            end
            % Update currentPos and currentColumn.
            currentPos = [currentPos(1) + 1, currentPos(2)];
            currentColumn = posList(posList(:, 1) == currentPos(1), :);
            % Check if reach goal position.
            if isequal(currentPos, [goalPosX, goalPosY])
                findGoal = 1;
                plot (currentPos(1) - 186, currentPos(2) - 616, 's', 'MarkerSize', 4, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
                pause(0.001)
            end
        % Case 2: should move downward along the currentColumn.
        elseif isequal(currentColumn(1, :), currentPos)
            endPosInColumn = currentColumn(end, :);
            % Plot the positions in the new column ordered by sweeping order.
            while ~isempty(currentColumn)
                path(pathPosCount, :) = currentColumn(1, :);
                if isequal(path(pathPosCount, :), [startPos(2), startPos(1)])
                    plot (currentPos(1) - 186, currentPos(2) - 616, 's', 'MarkerSize', 4, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
                    pause(0.001)
                else
                    plot (path(pathPosCount, 1) - 186, path(pathPosCount, 2) - 616, 's', 'MarkerSize', 2, 'MarkerEdgeColor', 'g', 'MarkerFaceColor', 'g');
                    pause(0.001)
                end
                pathPosCount = pathPosCount + 1;
                currentColumn(1, :) = [];
            end
            % Check if reach goal position.
            if isequal(endPosInColumn, [goalPosX, goalPosY])
                findGoal = 1;
                plot (endPosInColumn(1) - 186, endPosInColumn(2) - 616, 's', 'MarkerSize', 4, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
                pause(0.001)
            else
                % Update currentColumn and currentPos.
                currentColumn = posList(posList(:, 1) == (currentPos(1) + 1), :);
                currentPos = currentColumn(end, :);
            end
        % Case 3: should move upward along the currentColumn.
        elseif isequal(currentColumn(end, :), currentPos)
            endPosInColumn = currentColumn(1, :);
            % Plot the positions in the new column ordered by sweeping order.
            while ~isempty(currentColumn)
                path(pathPosCount, :) = currentColumn(end, :);
                if isequal(path(pathPosCount, :), [startPos(2), startPos(1)])
                    plot (currentPos(1) - 186, currentPos(2) - 616, 's', 'MarkerSize', 4, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
                    pause(0.001)
                else
                    plot (path(pathPosCount, 1) - 186, path(pathPosCount, 2) - 616, 's', 'MarkerSize', 2, 'MarkerEdgeColor', 'g', 'MarkerFaceColor', 'g');
                    pause(0.001)
                end
                pathPosCount = pathPosCount + 1;
                currentColumn(end, :) = [];
            end
            % Check if reach goal position.
            if isequal(endPosInColumn, [goalPosX, goalPosY])
                findGoal = 1;
                plot (endPosInColumn(1) - 186, endPosInColumn(2) - 616, 's', 'MarkerSize', 4, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
                pause(0.001)
            else
                % Update currentColumn and currentPos.
                currentColumn = posList(posList(:, 1) == (currentPos(1) + 1), :);
                currentPos = currentColumn(1, :);
            end
        end
    end
end







