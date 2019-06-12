function F = oneLinkController_ExternalForce(x_wall, Q)

w = Q(2, 1); % angular velocity
[x, J, ~] = oneLinkKinematics(Q);
v = J*w; % tip velocity

% Wall impedance
kp = 90000; 
kd = 0;

if x > x_wall
    F = kp*(x_wall-x) - kd*v;
else
    F = 0;
end

end