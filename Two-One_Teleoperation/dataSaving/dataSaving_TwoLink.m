
function [E_his] = dataSaving_TwoLink(t_his,Q_his)

for i = 1:length(t_his)
    
    % Model parameter
    TwoLink = twoLinkParameter();
    L1 = TwoLink.L1;
    L2 = TwoLink.L2;
    m1 = TwoLink.m1;
    m2 = TwoLink.m2;
    g = TwoLink.g;
    
    % State variable
    Q = Q_his(:, i);
    q1 = Q(1, 1);
    q2 = Q(2, 1);
    q1d = Q(3, 1);
    q2d = Q(4, 1);
    
    % Energy
    P = -m1*g*L1*cos(q1) - m2*g*(L1*cos(q1)+L2*cos(q1+q2)); % potential energy
    L3_sqrare = L1^2 + L2^2 -2*L1*L2*cos(q2);
    K = 1/2*m1*(L1*q1d)^2 + ...
        1/2*m2*((L3_sqrare*q1d + L2^2*q2d)*(q1d+q2d) - L1^2*q1d*q2d); % kinetic energy
    E = P + K;
    E_his(1, i) = E;
end

end