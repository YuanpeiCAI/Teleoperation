% Two Mass Dynamics (Joint Space)

% Q = [x1; x2; v1; v2]
% Qd = [v1; v2; a1; a2]

function Qd = twoMassDynamics(t, Q, F, u)

% Model parameter
TwoMass = twoMassParameter();
m1 = TwoMass.m1;
m2 = TwoMass.m2;
k1 = TwoMass.k1;
k2 = TwoMass.k2;
b1 = TwoMass.b1;
b2 = TwoMass.b2;

% State variable
x1 = Q(1, 1);
x2 = Q(2, 1);
v1 = Q(3, 1);
v2 = Q(4, 1);

% M matrix
M(1, 1) = m1;
M(1, 2) = 0;
M(2, 1) = 0;
M(2, 2) = m2;

% b Vector
b(1, 1) = (b1+b2)*v1 - b2*v2; 
b(2, 1) = -b2*v1 + b2*v2;

% G vector
G(1, 1) = (k1+k2)*x1 - k2*x2;
G(2, 1) = -k2*x1 + k2*x2;

% F vector (Haptics and Human Operator)
f(1, 1) = 0; % Human Operator
f(2, 1) = F; % Human Operator
Tau(1, 1) = u(1, 1); % Haptics
Tau(2, 1) = u(2, 1); % Haptics
Tau = Tau + f;

a = M^-1*(Tau-b-G);
Qd = [v1; v2; a];

end

