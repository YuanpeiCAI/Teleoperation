% One Mass Dynamics (Joint Space)

% Q = [x; v]
% Qd = [v; a]

function Qd = oneMassDynamics(t, Q, F, u)

% Model parameter
OneMass = oneMassParameter();
m = OneMass.m;
k = OneMass.k;
b = OneMass.b;

% State variable
x = Q(1, 1);
v = Q(2, 1);

% M matrix
M(1, 1) = m;

% b Vector
b(1, 1) = b*v; 

% G vector
G(1, 1) = k*x;

% F vector (Haptics and Human Operator)
f(1, 1) = F; % Controller
Tau(1, 1) = u; % Wall
Tau = Tau + f;

a = M^-1*(Tau-b-G);
Qd = [v; a];

end

