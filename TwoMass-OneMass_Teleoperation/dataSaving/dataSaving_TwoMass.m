
function [dataTwoMass] = dataSaving_TwoMass(t_his,Q_his)

for i = 1:length(t_his)
    Q = Q_his(:, i);
    [x, ~, X_config] = twoMassKinematics(Q); % forward kinematics
    x_his(1, i) = x;
    X_config_his(:, i) = X_config;
end

dataTwoMass.X_config_his = X_config_his;
dataTwoMass.x_his = x_his;

end