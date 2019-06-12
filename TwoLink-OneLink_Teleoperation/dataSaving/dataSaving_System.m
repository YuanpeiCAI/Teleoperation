
function [SystemData] = dataSaving_System(t_his, Q_his, x_dsr, x_wall)

for i = 1:length(t_his)

    % State variable
    Q = Q_his(:, i);
    
    % Tracking error
    [~, SystemData_i] = systemDynamics(t_his(1, i), Q, x_dsr, x_wall);
    e_his(1, i) = SystemData_i.err;
    x_his_TwoLink(1, i) = SystemData_i.x_TwoLink;
    x_his_OneLink(1, i) = SystemData_i.x_OneLink;
end

SystemData.e_his = e_his;
SystemData.x_his_TwoLink = x_his_TwoLink;
SystemData.x_his_OneLink = x_his_OneLink;

end