% System Dynamics

%%%% INPUT
%
%       ------ mass displacement ------  -------- mass velocity ----------
%       -- Two Mass --  -- One Mass --  -- Two Mass --  -- One Mass --
% Q = [     x1; x2;             x;                      v1; v2;                 v        ]
% 
%       -- Two Link --  -- One Link -- 
% F = [       F1;           F2;       ]

%%%% OUTPUT
%       ------ mass displacement ------  ------ mass acceleration --------
%       -- Two Mass --  -- One Mass --  -- Two Mass --  -- One Mass --
% Q = [     v1; v2;             v;                      a1; a2;                 a        ]

function [Qd, data] = systemDynamics(t, Q, x_dsr_TwoMass, x_wall)

global t_pre;

% State variable decomposition
Q_TwoMass = [Q(1:2, 1); Q(4:5, 1)];
Q_OneMass = [Q(3, 1); Q(6, 1)];

% Trajectory generation
% clear x_dsr_TwoMass;
% x_dsr_TwoMass = 0.07*sin(1*pi*t); 


%%%% Controller design 
%
SysConfig = systemConfiguration();
% Two Mass (haptics)
if SysConfig.ENABLE_HAPTICS == 1
    u_TwoMass = twoMassController_Haptics(Q_TwoMass, Q_OneMass);
elseif SysConfig.ENABLE_HAPTICS == 0
    u_TwoMass = zeros(2, 1);
else
    % do nothing
end
% Two Mass: (human impedance)
F_TwoMass = twoMassController_HumanImpedance(Q_OneMass, x_dsr_TwoMass, t);
% 
% One Mass: (controller)
u_OneMass = oneMassController_JacobianInverse(Q_TwoMass, Q_OneMass);
% u_OneMass = oneMassController_JacobianTranspose(Q_TwoMass, Q_OneMass);
% One Mass: (contact)
if SysConfig.ENABLE_WALL == 1
    F_OneMass = oneMassController_ExternalForce(x_wall, Q_OneMass);
elseif SysConfig.ENABLE_WALL == 0
    F_OneMass = 0;
else
    % Do no nothing
end


% Dynamics
Qd_TwoMass = twoMassDynamics(t, Q_TwoMass, F_TwoMass, u_TwoMass);
Qd_OneMass = oneMassDynamics(t, Q_OneMass, F_OneMass, u_OneMass);

Qd = [Qd_TwoMass(1:2, 1); Qd_OneMass(1, 1); Qd_TwoMass(3:4, 1); Qd_OneMass(2, 1)];

% Data Saving
[x_TwoMass, ~, ~] = twoMassKinematics(Q_TwoMass);
[x_OneMass, ~, ~] = oneMassKinematics(Q_OneMass);
data.e_mVSs = x_TwoMass - x_OneMass; 
data.e_dVSs = x_dsr_TwoMass - x_OneMass; 
data.x_TwoMass = x_TwoMass;
data.x_OneMass = x_OneMass;
data.F_TwoMassHumanOperator = F_TwoMass;
data.u_TwoMassHaptics = u_TwoMass;
t_pre = t;


end

