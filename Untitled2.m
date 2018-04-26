criticalPos = [CriticalPoint(:, 2), CriticalPoint(:, 1)];
criticalNum = length(criticalPos);
S.crit1 = [0, 0];
S.crit2 = [0, 0];
cellID = 0;
upFree([255,17], whiteImage)
for i = 1 : criticalNum
    % 3rd
    Pos = criticalPos(i, :);
    if upFree(Pos, whiteImage) && downFree(Pos, whiteImage) ...
            && ~rightFree(Pos, whiteImage) && leftFree(Pos, whiteImage)
        S(cellID).crit2 = Pos;
        cellID = cellID + 1;
        S(cellID).crit1 = Pos;
        S(cellID + 1).crit1 = Pos;
    end
    % 2nd
    if upFree(Pos, whiteImage) && downFree(Pos, whiteImage) ...
            && rightFree(Pos, whiteImage) && ~leftFree(Pos, whiteImage)
        cellID = cellID + 1;
        S(cellID).crit1 = Pos;
        S(cellID - 1).crit2 = Pos;
        S(cellID - 2).crit2 = Pos;
    end
    % 1st
    if ~upFree(Pos, whiteImage) && ~downFree(Pos, whiteImage) ...
            && rightFree(Pos, whiteImage) && ~leftFree(Pos, whiteImage)
        cellID = cellID + 1;
        S(cellID).crit1 = Pos;
    end
    % 4th
    if ~upFree(Pos, whiteImage) && ~downFree(Pos, whiteImage) ...
            && ~rightFree(Pos, whiteImage) && leftFree(Pos, whiteImage)
        S(cellID).crit2 = Pos;
        cellID = cellID + 1;
    end
end


function [ifFreeSpace] = upFree(Pos, whiteImage)
    ifFreeSpace = whiteImage(Pos(2) - 1, Pos(1)) == 0;
end
function [ifFreeSpace] = downFree(Pos, whiteImage)
    ifFreeSpace = whiteImage(Pos(2) + 1, Pos(1)) == 0;
end
function [ifFreeSpace] = leftFree(Pos, whiteImage)
    ifFreeSpace = whiteImage(Pos(2), Pos(1) - 1) == 0;
end
function [ifFreeSpace] = rightFree(Pos, whiteImage)
    ifFreeSpace = whiteImage(Pos(2), Pos(1) + 1) == 0;
end