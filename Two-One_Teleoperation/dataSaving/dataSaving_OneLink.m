
function [E_his] = dataSaving_OneLink(t_his,Q_his)

for i = 1:length(t_his)
    
    % Model parameter
    OneLink = oneLinkParameter();
    L = OneLink.L;
    m = OneLink.m;
    g = OneLink.g;
    
    % State variable
    Q = Q_his(:, i);
    q = Q(1, 1);
    qd = Q(2, 1);
    
    % Energy
    P = -m*g*L*cos(q); % potential energy
    K = 1/2*m*(L*qd)^2; % kinetic energy
    E = P + K;
    E_his(1, i) = E;
end

end