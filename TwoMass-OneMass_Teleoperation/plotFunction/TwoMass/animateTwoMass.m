

function [] = animateTwoMass(t_his, Q_his)

SpeedRatio = 1;
s = get(0, 'ScreenSize');
figure('Name', 'Two Link Simulation',...
    'outerposition', [s(3)*0.1 s(4)*0.1 s(3)*0.8 s(4)*0.8]);
clf;
dataTwoMass = dataSaving_TwoMass(t_his,Q_his);
x_his = dataTwoMass.x_his(1, :);

% Plot animation
%
subplot(2,2,1);
hold on;
drawTwoMass(Q_his(:, 1));

% Plot x
%
subplot(2,2,3);
hold on;
plot(t_his, x_his(1, :), '-r', 'LineWidth',1); 
xlabel('t');
ylabel('x (m)');

x_ode_marker = plot(t_his(1),x_his(1, 1), 'ro');
hold off;

hold off;
pause(2);



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
    x_ode = interp1(t_his, x_his(1, :), sim_time, 'spline')';
    
    %clf;
    subplot(2,2,1); hold on;
    %
    cla
    title(sprintf('Master, t = %6.4f',sim_time));
    drawTwoMass(Q_ode);

    hold off;
    
    % Update maker
    set(x_ode_marker, 'xData', sim_time);
    set(x_ode_marker, 'yData', x_ode);
    
    drawnow;
    
    % Update simulation time
    sim_time = toc*SpeedRatio;
end