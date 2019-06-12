
function [SystemData] = dataSaving_System(t_his, Q_his, x_dsr, x_wall)

for i = 1:length(t_his)

    % State variable
    Q = Q_his(:, i);
    
    % Tracking error
    [~, SystemData_i] = systemDynamics(t_his(1, i), Q, x_dsr, x_wall);
    e_mVSs_his(1, i) = SystemData_i.e_mVSs;
    e_dVSs_his(1, i) = SystemData_i.e_dVSs;
    x_his_TwoMass(1, i) = SystemData_i.x_TwoMass;
    x_his_OneMass(1, i) = SystemData_i.x_OneMass;
    F_TwoMassHumanOperator_his(1, i) = SystemData_i.F_TwoMassHumanOperator;
    u_TwoMassHaptics_his(:, i) = SystemData_i.u_TwoMassHaptics;
    
end


SystemData.e_mVSs_his = e_mVSs_his;
SystemData.e_dVSs_his = e_dVSs_his;
SystemData.x_his_TwoMass = x_his_TwoMass;
SystemData.x_his_OneMass = x_his_OneMass;
SystemData.F_TwoMassHumanOperator_his = F_TwoMassHumanOperator_his;
SystemData.u_TwoMassHaptics_his_his = u_TwoMassHaptics_his;

end