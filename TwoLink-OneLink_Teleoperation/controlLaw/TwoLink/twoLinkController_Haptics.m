% 

function u = twoLinkController_Haptics(Q_TwoLink, Q_OneLink)

[x_TwoLink, J_TwoLink, ~] = twoLinkKinematics(Q_TwoLink);
[x_OneLink, ~, ~] = oneLinkKinematics(Q_OneLink);
k_Haptics = 200;
F_Haptics = k_Haptics*(x_OneLink - x_TwoLink); 
u = J_TwoLink'*F_Haptics; % may have multiple choice, as it's redundant

end