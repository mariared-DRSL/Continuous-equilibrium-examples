function [] = Plot_Internal_Extensional(Phi,PE_1,PE_2,PEgrav)
    figure()
    hold on
    area(Phi*180/pi,PE_1+PE_2+(PEgrav-min(PEgrav)),'FaceColor',[0.5 0.5 0.5])
    area(Phi*180/pi,PE_1+PE_2,'FaceColor',[0/255 0/255 127/255])
    area(Phi*180/pi,PE_1,'FaceColor',[137/255 207/255 240/255])
    xlim([min(Phi)*180/pi max(Phi)*180/pi])
    % xticks([])
    % yticks([])
    xlabel('\phi','FontSize',18)
    ylabel('PE','FontSize',18)
%     ylim([0 2])
end