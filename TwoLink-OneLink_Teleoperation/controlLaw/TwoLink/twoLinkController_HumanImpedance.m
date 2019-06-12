
function F = twoLinkController_HumanImpedance(Q, x_dsr, t)

global t_pre ei;

[x, J, ~] = twoLinkKinematics(Q);
qd = Q(3:4, 1); % angular velocity
v = J*qd;
e = x_dsr - x; 
ki = 500;
kp = 1000; 
kd = 0; % 10;
% bug
if t-t_pre > 0
    ei = ei + e*(t-t_pre);
else
    
end
F = kp*e - kd*v + ki*ei; % Assume human is a spring

end