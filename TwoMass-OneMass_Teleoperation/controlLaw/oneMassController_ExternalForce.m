function F = oneMassController_ExternalForce(x_wall, Q)

v = Q(2, 1); % velocity
[x, J, ~] = oneMassKinematics(Q);
v = J*v; % tip velocity

% Wall impedance
kp = 9e5; % 90000; 
kd = 0;

if x > x_wall
    F = kp*(x_wall-x) - kd*v;
else
    F = 0;
end

end