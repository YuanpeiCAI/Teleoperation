% One Link Dynamics

% Q = [q; qd]
% Qd = [qd; qdd]

function Qd = oneLinkDynamics(t, Q, F, u)

% Model parameter
OneLink = oneLinkParameter();
L = OneLink.L;
m = OneLink.m;
mu = OneLink.mu;
g = OneLink.g;

% State variable
q = Q(1, 1);
qd = Q(2, 1);

% M matrix
M(1, 1) = m*L^2;

% b Vector
b(1, 1) = 0;

% G vector
G(1, 1) = m*g*L*sin(q);

% F vector (including friction)
f(1, 1) = -mu*qd; % friction
Tau(1, 1) = F*L*cos(q); % external
Tau = Tau + f + u;

qdd = M^-1*(Tau-b-G);
Qd = [qd; qdd];

end

