
function [dataOneMass] = dataSaving_OneMass(t_his,Q_his)

for i = 1:length(t_his)
    Q = Q_his(:, i);
    [x, ~, X_config] = oneMassKinematics(Q); % forward kinematics
    x_his(1, i) = x;
    X_config_his(:, i) = X_config;
end

dataOneMass.X_config_his = X_config_his;
dataOneMass.x_his = x_his;

end