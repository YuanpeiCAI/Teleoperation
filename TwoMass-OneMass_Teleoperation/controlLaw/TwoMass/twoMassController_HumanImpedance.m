
function F = twoMassController_HumanImpedance( Q, x_dsr, t)

global t_pre ei;

[x_s, J_s, ~] = oneMassKinematics(Q);
qd = Q(2, 1); % velocity
v = J_s*qd;
e = x_dsr - x_s; 
ki = 7e2; % 5e2; 
kp =  1.3e3; % 1e3; 
kd =1; %  0.8; 
% bug
if t-t_pre > 0
    ei = ei + e*(t-t_pre);
else
    
end
F = kp*e - kd*v + ki*ei; % Assume human is a spring

end