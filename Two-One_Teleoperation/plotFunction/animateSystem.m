

function [] = animateSystem(t_his, Q_his, SystemData)

% Parameter decomposition
Q_his_OneLink = [Q_his(3, :); Q_his(6, :)];
Q_his_TwoLink = [Q_his(1:2, :); Q_his(4:5, :)];

SpeedRatio = 1; % 0.2; % vedio speed
saveAnimation = 0; % save animation
s = get(0, 'ScreenSize');
figure('Name', 'Two Link Simulation',...
    'outerposition', [s(3)*0.1 s(4)*0.1 s(3)*0.8 s(4)*0.8]);
clf; 

% Plot q1 & q2
%


subplot(2,2,1); hold on; cla
title(sprintf('Master, t = %6.4f',0));
drawTwoLink(Q_his_TwoLink(:, 1));

subplot(2,2,2); hold on; cla
title(sprintf('Slave, t = %6.4f',0));
drawOneLink(Q_his_OneLink(:, 1));

subplot(2,2,3); hold on;
plot(t_his, SystemData.x_his_TwoLink, '-r', 'LineWidth',1);
plot(t_his, SystemData.x_his_OneLink, '-b', 'LineWidth',1);
xlabel('t');
ylabel('x (m)');
x_his_TwoLink_ode_marker = plot(t_his(1), SystemData.x_his_TwoLink(1, 1), 'ro');
x_his_OneLink_ode_marker = plot(t_his(1), SystemData.x_his_OneLink(1, 1), 'bo');
legend('x_m', 'x_s');
hold off;

subplot(2,2,4); hold on;
plot(t_his, SystemData.e_his, '-g', 'LineWidth',1);
xlabel('t');
ylabel('e_x (m)');
e_ode_marker = plot(t_his(1), SystemData.e_his(1, 1), 'go');
hold off;


hold off;
pause(0.1);



% Animation
%
sim_time = 0;
tic; % Start stopwatch timer for simulation
i = 1;

while sim_time < t_his(end)
    
    %Interpolate to get the new point at current time:
    sim_time = toc*SpeedRatio;
    q1_ode_TwoLink = interp1(t_his, Q_his_TwoLink(1, :), sim_time, 'spline')';
    q2_ode_TwoLink = interp1(t_his, Q_his_TwoLink(2, :), sim_time, 'spline')';
    Q_ode_TwoLink = [q1_ode_TwoLink; q2_ode_TwoLink; zeros(2, 1)];
    q_ode_OneLink = interp1(t_his, Q_his_OneLink(1, :), sim_time, 'spline')';
    Q_ode_OneLink = [q_ode_OneLink; 0];
    e_ode = interp1(t_his, SystemData.e_his(1, :), sim_time, 'spline')';
    x_TwoLink_ode = interp1(t_his, SystemData.x_his_TwoLink(1, :), sim_time, 'spline')';
    x_OneLink_ode = interp1(t_his, SystemData.x_his_OneLink(1, :), sim_time, 'spline')';
    
    %clf;
    subplot(2,2,1); hold on; cla
    title(sprintf('Master, t = %6.4f',sim_time));
    drawTwoLink(Q_ode_TwoLink);
    
    subplot(2,2,2); hold on; cla
    title(sprintf('Slave, t = %6.4f',sim_time));
    drawOneLink(Q_ode_OneLink);

    hold off;
    
    % Update maker
    set(e_ode_marker, 'xData', sim_time);
    set(e_ode_marker, 'yData', e_ode);
    set(x_his_TwoLink_ode_marker, 'xData', sim_time);
    set(x_his_TwoLink_ode_marker, 'yData', x_TwoLink_ode);
    set(x_his_OneLink_ode_marker, 'xData', sim_time);
    set(x_his_OneLink_ode_marker, 'yData', x_OneLink_ode);
    
    drawnow;
    
    % Update simulation time
    sim_time = toc*SpeedRatio;
    
    % Save animation
    if(saveAnimation == 1)
        thisFrame = getframe(gcf);
        myMovie(i) = thisFrame; i=i+1;
    end
    
end

if(saveAnimation == 1)
    sav_animation(myMovie);
end
