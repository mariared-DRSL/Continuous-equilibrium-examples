function [] = Plot_PE_Breakdown(Phi,PE_A,PE_B,PE_C,PE_D,PEgrav)
    figure()
    hold on

    if exist('PE_A','var')
        if exist('PE_E','var')
            area(Phi*180/pi,PE_A+PE_B+PE_C+PE_D+PE_E+(PEgrav-min(PEgrav)),'FaceColor',[0.5 0.5 0.5])
            area(Phi*180/pi,PE_A+PE_B+PE_C+PE_D+PE_E,'FaceColor',[0.5 0.5 0.5])
        else
            area(Phi*180/pi,PE_A+PE_B+PE_C+PE_D+(PEgrav-min(PEgrav)),'FaceColor',[0.5 0.5 0.5])
        end
            
        area(Phi*180/pi,PE_A+PE_B+PE_C+PE_D,'FaceColor',[0 0.4470 0.7410])
        area(Phi*180/pi,PE_A+PE_B+PE_C,'FaceColor',[0.4660 0.6740 0.1880]) 
        area(Phi*180/pi,PE_A+PE_B,'FaceColor',[0.9290 0.6940 0.1250])
        area(Phi*180/pi,PE_A,'FaceColor','r')
    else 
        if exist('PE_E','var')
            area(Phi*180/pi,PE_E+(PEgrav-min(PEgrav)),'FaceColor',[0.5 0.5 0.5])
            area(Phi*180/pi,PE_E,'FaceColor',[0.5 0.5 0.5])
        else
            area(Phi*180/pi,(PEgrav-min(PEgrav)),'FaceColor',[0.5 0.5 0.5])
        end
    end

    xlim([min(Phi)*180/pi max(Phi)*180/pi])
    %  xticks([])
    % yticks([])
    xlabel('\phi','FontSize',18)
    ylabel('PE','FontSize',18)
    ylim([0 2])
end