function [] = Plot_External_Extensional(Phi,PE_3,PEgrav)
    figure()
    hold on
    area(Phi*180/pi,PE_3+(PEgrav-min(PEgrav)),'FaceColor',[0.5 0.5 0.5])
    area(Phi*180/pi,PE_3,'FaceColor',[0.6 0.6 1])
    xlim([min(Phi)*180/pi max(Phi)*180/pi])
    % xticks([])
    % yticks([])
    xlabel('\phi','FontSize',18)
    ylabel('PE','FontSize',18)
%     ylim([0 2])
end