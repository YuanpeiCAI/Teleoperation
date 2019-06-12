

function [] = animateSystem(t_his, Q_his, x_wall, SystemData)

% Parameter decomposition
Q_his_OneMass = [Q_his(3, :); Q_his(6, :)];
Q_his_TwoMass = [Q_his(1:2, :); Q_his(4:5, :)];

% Animation property
SpeedRatio = 3; % 0.2; % vedio speed
saveAnimation = 0; % save animation

% Frame definition
s = get(0, 'ScreenSize');
figure('Name', 'Two Link Simulation',...
    'outerposition', [s(3)*0.1 s(4)*0.1 s(3)*0.8 s(4)*0.8]);
clf; 

% Plot first frame
%
subplot(2,2,1); hold on; cla
title(sprintf('Master, t = %6.4f',0));
drawTwoMass(Q_his_TwoMass(:, 1));
%
subplot(2,2,2); hold on; cla
title(sprintf('Slave, t = %6.4f',0));
drawOneMass(Q_his_OneMass(:, 1), x_wall);
%
subplot(2,2,3); hold on;
plot(t_his, SystemData.x_his_TwoMass, '-r', 'LineWidth',1);
plot(t_his, SystemData.x_his_OneMass, '-b', 'LineWidth',1);
xlabel('t');
ylabel('x (m)');
x_his_TwoMass_ode_marker = plot(t_his(1), SystemData.x_his_TwoMass(1, 1), 'ro');
x_his_OneMass_ode_marker = plot(t_his(1), SystemData.x_his_OneMass(1, 1), 'bo');
legend('x_m', 'x_s');
hold off;
%
subplot(2,2,4); hold on;
plot(t_his, SystemData.e_mVSs_his, '-g', 'LineWidth',1);
xlabel('t');
ylabel('e_x (m)');
e_ode_marker = plot(t_his(1), SystemData.e_mVSs_his(1, 1), 'go');
hold off;
%
hold off;
pause(2);



% Animation
%
i = 1; % for saving the animation
sim_time = 0;
tic; % Start stopwatch timer for simulation

while sim_time < t_his(end)
    
    %Interpolate to get the new point at current time:
    sim_time = toc*SpeedRatio;
    q1_ode_TwoMass = interp1(t_his, Q_his_TwoMass(1, :), sim_time, 'spline')';
    q2_ode_TwoMass = interp1(t_his, Q_his_TwoMass(2, :), sim_time, 'spline')';
    Q_ode_TwoMass = [q1_ode_TwoMass; q2_ode_TwoMass; zeros(2, 1)];
    q_ode_OneMass = interp1(t_his, Q_his_OneMass(1, :), sim_time, 'spline')';
    Q_ode_OneMass = [q_ode_OneMass; 0];
    e_ode = interp1(t_his, SystemData.e_mVSs_his(1, :), sim_time, 'spline')';
    x_TwoMass_ode = interp1(t_his, SystemData.x_his_TwoMass(1, :), sim_time, 'spline')';
    x_OneMass_ode = interp1(t_his, SystemData.x_his_OneMass(1, :), sim_time, 'spline')';
    
    %clf;
    subplot(2,2,1); hold on; cla
    title(sprintf('Master, t = %6.4f',sim_time));
    drawTwoMass(Q_ode_TwoMass);
    
    subplot(2,2,2); hold on; cla
    title(sprintf('Slave, t = %6.4f',sim_time));
    drawOneMass(Q_ode_OneMass, x_wall);

    hold off;
    
    % Update maker
    set(e_ode_marker, 'xData', sim_time);
    set(e_ode_marker, 'yData', e_ode);
    set(x_his_TwoMass_ode_marker, 'xData', sim_time);
    set(x_his_TwoMass_ode_marker, 'yData', x_TwoMass_ode);
    set(x_his_OneMass_ode_marker, 'xData', sim_time);
    set(x_his_OneMass_ode_marker, 'yData', x_OneMass_ode);
    
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
