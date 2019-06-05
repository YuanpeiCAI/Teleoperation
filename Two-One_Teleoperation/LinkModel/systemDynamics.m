% System Dynamics

%%%% INPUT
%
%       --------- Joing Angle --------  ------ Joint Velocity --------
%       -- Two Link --  -- One Link --  -- Two Link --  -- One Link --
% Q = [     q1; q2;         q;              q1d; q2d;       qd        ]
% 
%       -- Two Link --  -- One Link -- 
% F = [       F1;           F2;       ]

%%%% OUTPUT
%       ------ Joint Velocity --------  ------ Joint Velocity --------
%       -- Two Link --  -- One Link --  -- Two Link --  -- One Link --
% Q = [     q1d; q2d;       qd;             q1dd; q2dd;     qdd       ]

function [Qd, data] = systemDynamics(t, Q, F, u)

% State variable decomposition
Q_OneLink = [Q(3, 1); Q(6, 1)];
Q_TwoLink = [Q(1:2, 1); Q(4:5, 1)];

% External disturbance decomposition
F_OneLink = F(2, 1);
F_TwoLink = F(1, 1);

% Controller design 
%
% Two link :(human operator)
x_dsr_Twolink = 0.05; % 0.2*deg2rad(30)*sin(1*pi*t); % 
% Q_TwoLink = [deg2rad(30)*sin(0.2*pi*t); 0; deg2rad(30)*0.2*pi*cos(0.2*pi*t); 0];
[x_TwoLink, J_TwoLink, ~] = twoLinkKinematics(Q_TwoLink);
e_TwoLink = x_dsr_Twolink - x_TwoLink; 
k_TwoLink_Operator = 500; % need to tune
u_TwoLink = k_TwoLink_Operator*J_TwoLink'*e_TwoLink; % Jacobian Transpose Controller (Human)
% Two link :(haptics)
k_TwoLink_Haptics = 00;
[x_OneLink, ~, ~] = oneLinkKinematics(Q_OneLink);
F_TwoLink = k_TwoLink_Haptics*(x_OneLink - x_TwoLink); 
Qd_TwoLink = twoLinkDynamics(t, Q_TwoLink, F_TwoLink, u_TwoLink);
%

% % % Two link :(human operator)
% % Q_TwoLink = zeros(4, 1); F_TwoLink = 0; u_TwoLink = zeros(2, 1);
% % Qd_TwoLink = twoLinkDynamics(t, Q_TwoLink, F_TwoLink, u_TwoLink); x_TwoLink = 0.05;


% One link
[x_OneLink, J_OneLink, ~] = oneLinkKinematics(Q_OneLink);
e_OneLink = x_TwoLink - x_OneLink; 
k_OneLink = 500; % need to tune
% u_OneLink = k_OneLink*J_OneLink'*e_OneLink; % Jacobian Transpose Controller
u_OneLink = k_OneLink*norm(J_OneLink)^2*J_OneLink^-1*e_OneLink; % Jacobian Inverse Controller
Qd_OneLink = oneLinkDynamics(t, Q_OneLink, F_OneLink, u_OneLink);

% % % One link
% % F_OneLink = 0; u_OneLink = 0; Q_OneLink = zeros(2, 1); 
% % Qd_OneLink = oneLinkDynamics(t, Q_OneLink, F_OneLink, u_OneLink);


Qd = [Qd_TwoLink(1:2, 1); Qd_OneLink(1, 1); Qd_TwoLink(3:4, 1); Qd_OneLink(2, 1)];

% Data Saving
data.err = x_TwoLink - x_OneLink; 
data.x_TwoLink = x_TwoLink;
data.x_OneLink = x_OneLink;

end

