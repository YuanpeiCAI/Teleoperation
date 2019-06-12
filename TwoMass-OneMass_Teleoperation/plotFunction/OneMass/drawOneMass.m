

function [] = drawOneMass(Q, x_wall)

MassSize = 0.05; % m

axis equal; axis(MassSize*[-0.5,10,0,2]); axis off;

[~, ~, X_config] = oneMassKinematics(Q);

%%%% Wall
rectangle('Position', [-MassSize/5 0 MassSize/5 1.5*MassSize],...
    'Curvature', 0.1,...
    'LineWidth', 0.2,...
    'FaceColor', [1 1 1]*0.7,...
    'EdgeColor', [1 1 1]*0.7);

%%%% Spring
x_spring1_start = 0.005;
length_spring = 0.08; 
y_spring = 0.8*MassSize;
plot([0; x_spring1_start], [y_spring;y_spring],'color', [0.8500, 0.3250, 0.0980], 'LineWidth',2);
x_spring_end = x_spring1_start+length_spring+X_config(1, 1);
[xs,ys] = spring(x_spring1_start,y_spring,x_spring_end,y_spring,10,length_spring,0.005); plot(xs,ys,'LineWidth',2);
x_m1_start = x_spring_end+x_spring1_start;
plot([x_spring_end; x_m1_start], [y_spring;y_spring],'color', [0.8500, 0.3250, 0.0980], 'LineWidth',2);

%%%%% Damper1
x_damper1_start = x_m1_start/2; % length_spring/2;
y_damper1 = 0.3*MassSize;
width_damper1 = 0.3*MassSize;
length_damper1 = 0.2*MassSize;
x_damper1_end = length_damper1/2+x_damper1_start;
plot([0 x_damper1_start],[y_damper1 y_damper1],'color', [0.8500, 0.3250, 0.0980],'LineWidth',2);
plot([x_damper1_start x_damper1_start],[-width_damper1/2+y_damper1  width_damper1/2+y_damper1],'color', [0.8500, 0.3250, 0.0980],'LineWidth',2);
plot([-length_damper1/2+x_damper1_start, x_damper1_end,x_damper1_end,-length_damper1/2+x_damper1_start,],...
    [width_damper1/2+y_damper1, width_damper1/2+y_damper1, -width_damper1/2+y_damper1 -width_damper1/2+y_damper1],'color', [0.8500, 0.3250, 0.0980],'LineWidth',2);
plot([ x_damper1_end,x_m1_start],[y_damper1 y_damper1],'color', [0.8500, 0.3250, 0.0980],'LineWidth',2);


%%%% m1
rectangle('Position', [x_m1_start 0 MassSize MassSize],...
    'Curvature', 0.4,...
    'LineWidth', 0.2,...
    'FaceColor', [1 1 1]*0.7,...
    'EdgeColor', [1 1 1]*0.7);

%%%% Wall
Wall_pos = [[x_wall+MassSize+x_spring1_start*2+length_spring;0], [x_wall+MassSize+x_spring1_start*2+length_spring;1.5*MassSize]];
plot(Wall_pos(1,:),Wall_pos(2,:),'Color',[0,0,0],'LineWidth',2);


end