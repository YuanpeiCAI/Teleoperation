% Two Link Dynamics

% Q = [q1; q2; q1d; q2d]
% Qd = [q1d; q2d; q1dd; q2dd]

function Qd = twoLinkDynamics(t, Q, F, u)

% Model parameter
TwoLink = twoLinkParameter();
L1 = TwoLink.L1;
L2 = TwoLink.L2;
m1 = TwoLink.m1;
m2 = TwoLink.m2;
mu = TwoLink.mu;
g = TwoLink.g;

% State variable
q1 = Q(1, 1);
q2 = Q(2, 1);
q1d = Q(3, 1);
q2d = Q(4, 1);

% M matrix
M(1, 1) = (m1+m2)*L1^2 + m2*L2^2 - 2*L1*L2*m2*cos(q2);
M(1, 2) = m2*L2^2 - m2*L1*L2*cos(q2);
M(2, 1) = M(1, 2);
M(2, 2) = m2*L2^2;

% b Vector
b(1, 1) = 2*m2*L1*L2*sin(q2)*q1d*q2d + m2*L1*L2*sin(q2)*q2d^2; 
b(2, 1) = -m2*L1*L2*sin(q2)*q1d^2;

% G vector
G(1, 1) = m2*g*L2*sin(q1+q2) + (m1+m2)*g*L1*sin(q1);
G(2, 1) = m2*g*L2*sin(q1+q2);

% F vector (including friction)
f(1, 1) = -mu*q1d; % fiction
f(2, 1) = -mu*q2d; % fiction
Tau(1, 1) = F*(L1*cos(q1) + L2*cos(q1+q2)); % External
Tau(2, 1) = F*L2*cos(q1+q2); % External
Tau = Tau + f + u;

qdd = M^-1*(Tau-b-G);
Qd = [q1d; q2d; qdd];

end

