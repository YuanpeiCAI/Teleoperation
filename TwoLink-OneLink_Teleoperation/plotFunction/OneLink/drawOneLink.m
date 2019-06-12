

function [] = drawOneLink(Q, x_wall)

OneLink = oneLinkParameter();

length = OneLink.L;
axis equal; axis(length*[-1,1,-1.2,1.2]); axis off;

[~, ~, X_config] = oneLinkKinematics(Q);
pos = [[0;0], X_config];

%%%% Base
base_size = OneLink.L * 0.2;
% 
rectangle('Position', [-base_size/2 -base_size/2 base_size base_size],...
    'Curvature', 0.4,...
    'LineWidth', 0.2,...
    'FaceColor', [1 1 1]*0.7,...
    'EdgeColor', [1 1 1]*0.7);
% Link
plot(pos(1,:),pos(2,:),'Color',[0.0664, 0.422, 0.988],'LineWidth',8)
plot(pos(1,:),pos(2,:),'k.','MarkerSize',60, ...
    'Color', [0.1914 0.0469 0.3242]);

% Wall
Wall_pos = [[x_wall;-1.1*length], [x_wall;0]];
plot(Wall_pos(1,:),Wall_pos(2,:),'Color',[0,0,0],'LineWidth',2);

end