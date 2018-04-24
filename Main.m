clear all
%% create the plot 
bellyA=[-170 -360];
bellyB=[170 -360];
bellyC=[170 -610];
bellyD=[-160 -610];
bellyE=[-85 -515];
 

global X_MIN X_MAX Y_MIN Y_MAX;
X_MIN=-185;
X_MAX=170;
Y_MIN=-615;
Y_MAX=-350;
whiteImage = 255 * ones(180, 180, 'uint8');
imshow(whiteImage);


% axis([X_MIN X_MAX Y_MIN Y_MAX]);
global bellyF bellyF_radius
bellyF=[170 -485]; % origin of circle 
bellyF_radius= 125;
eq_pos_circle=[bellyF(1)-bellyF_radius bellyF(2)-bellyF_radius 2*bellyF_radius 2*bellyF_radius];
% plot the result 
figure(1)
plot([bellyA(1) bellyB(1)],[bellyA(2) bellyB(2)],'-bs', 'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5]);
hold on
plot([bellyA(1) bellyE(1)],[bellyA(2) bellyE(2)],'-bs', 'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5]);
hold on
plot([bellyD(1) bellyE(1)],[bellyD(2) bellyE(2)],'-bs', 'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5]);
hold on
plot([bellyC(1) bellyD(1)],[bellyC(2) bellyD(2)],'-bs', 'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5]);
hold on
rectangle('Position',eq_pos_circle,'Curvature',[1 1],'EdgeColor','b');
axis([X_MIN X_MAX Y_MIN Y_MAX]);

axis equal

global eqA_E eqD_E eqA_B eqC_D
eqA_E=polyfit([bellyA(1) bellyE(1)],[bellyA(2) bellyE(2)],1); 
eqD_E=polyfit([bellyD(1) bellyE(1)],[bellyD(2) bellyE(2)],1); 
eqA_B=polyfit([bellyA(1) bellyB(1)],[bellyA(2) bellyB(2)],1); 
eqC_D=polyfit([bellyC(1) bellyD(1)],[bellyC(2) bellyD(2)],1); 


%% fill the region and mark the boundary 
% free space = 1
% boundary = 2
% obstacle = 0

for i=X_MIN:X_MAX
   for j= Y_MIN:Y_MAX
       if(ToCheckIfInObstacleSpace(i,j))
           % is a free space, mark as 1
           
       else
           
           
       end
  
   end
end

function [InFreeSpace]=ToCheckIfInObstacleSpace(Current_X, Current_Y)
global bellyF bellyF_radius
global eqA_E eqD_E eqA_B eqC_D

poly_half_A_E=eqA_E(1)*Current_X+eqA_E(2)-Current_Y;
poly_half_D_E=eqD_E(1)*Current_X+eqD_E(2)-Current_Y;

% check for the square obstacle
if(Current_Y <= eqA_B(2) && Current_Y >= eqC_D(2) && ...
      ((Current_X-bellyF(1))^2+(Current_Y-bellyF(2))^2-bellyF_radius^2)>=0  && ... 
       (poly_half_A_E <0 || poly_half_D_E >0) )
    InFreeSpace=true;
else
    InFreeSpace=false;
end

end

%% morse decomposition 




%% Zig-zag