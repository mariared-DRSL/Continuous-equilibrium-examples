function [] = Plot_External_Torsional(Phi,PE_E,PEgrav)
    figure()
    hold on
    area(Phi*180/pi,PE_E+(PEgrav-min(PEgrav)),'FaceColor',[0.5 0.5 0.5])
    area(Phi*180/pi,PE_E,'FaceColor',[0.4940 0.1840 0.5560])
    % xticks([])
    % yticks([])
    xlabel('\phi','FontSize',18)
    ylabel('PE','FontSize',18)
%     ylim([0 2])
end