

function [] = animateTwoLink(t_his, Q_his)

SpeedRatio = 1;
s = get(0, 'ScreenSize');
figure('Name', 'Two Link Simulation',...
    'outerposition', [s(3)*0.1 s(4)*0.1 s(3)*0.8 s(4)*0.8]);
clf;

% Plot q1 & q2
%
subplot(3,1,3);
hold on;
plot(t_his, rad2deg(Q_his(1, :)), '-r', 'LineWidth',1);
plot(t_his, rad2deg(Q_his(2, :)), '-b', 'LineWidth',1);
xlabel('t');
ylabel('joint angle (degree)');
legend('q_1', 'q_2')

q1_ode_marker = plot(t_his(1), rad2deg(Q_his(1, 1)), 'ro');
q2_ode_marker = plot(t_his(1), rad2deg(Q_his(2, 1)), 'bo');
hold off;

subplot(3,1,[1 2]); hold on;
cla
title(sprintf('ODE45, t = %6.4f',0));
% if ~isempty(x_dsr)
%     plot(x_dsr(1,:), x_dsr(2,:), 'g')
% end
drawTwoLink(Q_his(:, 1));
hold off;
pause(0.1);



% Animation
%
sim_time = 0;
tic; % Start stopwatch timer for simulation

while sim_time < t_his(end)
    
    %Interpolate to get the new point at current time:
    sim_time = toc*SpeedRatio;
    q1_ode = interp1(t_his, Q_his(1, :), sim_time, 'spline')';
    q2_ode = interp1(t_his, Q_his(2, :), sim_time, 'spline')';
    Q_ode = [q1_ode; q2_ode; zeros(2, 1)];
    
    %clf;
    subplot(3,1,[1 2]); hold on;
    %
    cla
    title(sprintf('ODE45, t = %6.4f',sim_time));
%     if ~isempty(x_dsr)
%         plot(x_dsr(1,:), x_dsr(2,:), 'g')
%     end
    drawTwoLink(Q_ode);

    hold off;
    
    % Update maker
    set(q1_ode_marker, 'xData', sim_time);
    set(q1_ode_marker, 'yData', rad2deg(Q_ode(1)));
    %
    set(q2_ode_marker, 'xData', sim_time);
    set(q2_ode_marker, 'yData', rad2deg(Q_ode(2)));
    
    drawnow;
    
    % Update simulation time
    sim_time = toc*SpeedRatio;
end