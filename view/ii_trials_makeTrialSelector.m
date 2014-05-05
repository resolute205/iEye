function ii_trials_makeTrialSelector()
%II_TRIALS Summary of this function goes here
%   Detailed explanation goes here


% if nargin ~= 4
%     prompt = {'Start when Channel', 'is at Value', 'Until Channel', 'is at Value'};
%     dlg_title = 'Trial Parameters';
%     num_lines = 1;
%     answer = inputdlg(prompt,dlg_title,num_lines);
%     c1 = answer{1};
%     v1 = str2num(answer{2});
%     c2 = answer{3};
%     v2 = str2num(answer{4});
% end
ii_hideselections;
basevars = evalin('base','who');
ii_cfg = evalin('base', 'ii_cfg');

c1='XDAT';
c2='XDAT';

if ismember(c1,basevars)
    if ismember(c2,basevars)
        thechan = evalin('base',c1);
        thechan2 = evalin('base',c2);
        
        %%%xdat 1
        tsel = thechan*0;
        swhere = find(thechan == 1);
        tcursel(:,1) = SplitVec(swhere,'consecutive','firstval');
        tcursel(:,2) = SplitVec(swhere,'consecutive','lastval');
 
        for i=1:(size(tcursel,1))
            tsel(tcursel(i,1):tcursel(i,2)) = 1;
        end

        tcursel_xdat1=tcursel;
        tsel_xdat1=tsel;
        
                
        %%% xdat 2
        tsel = thechan*0;
        swhere = find(thechan == 2);
        tcursel(:,1) = SplitVec(swhere,'consecutive','firstval');
        tcursel(:,2) = SplitVec(swhere,'consecutive','lastval');
 
        for i=1:(size(tcursel,1))
            tsel(tcursel(i,1):tcursel(i,2)) = 1;
        end

        tcursel_xdat2=tcursel;
        tsel_xdat2=tsel;

        
        %%% xdat 3
        tsel = thechan*0;
        swhere = find(thechan == 3);
        tcursel(:,1) = SplitVec(swhere,'consecutive','firstval');
        tcursel(:,2) = SplitVec(swhere,'consecutive','lastval');
 
        for i=1:(size(tcursel,1))
            tsel(tcursel(i,1):tcursel(i,2)) = 1;
        end

        tcursel_xdat3=tcursel;
        tsel_xdat3=tsel;
        
        
        %%% xdat 4
        tsel = thechan*0;
        swhere = find(thechan == 4);
        tcursel(:,1) = SplitVec(swhere,'consecutive','firstval');
        tcursel(:,2) = SplitVec(swhere,'consecutive','lastval');
 
        for i=1:(size(tcursel,1))
            tsel(tcursel(i,1):tcursel(i,2)) = 1;
        end

        tcursel_xdat4=tcursel;
        tsel_xdat4=tsel;
        
        
        %%% xdat 5
        tsel = thechan*0;
        swhere = find(thechan == 5);
        tcursel(:,1) = SplitVec(swhere,'consecutive','firstval');
        tcursel(:,2) = SplitVec(swhere,'consecutive','lastval');
 
        for i=1:(size(tcursel,1))
            tsel(tcursel(i,1):tcursel(i,2)) = 1;
        end

        tcursel_xdat5=tcursel;
        tsel_xdat5=tsel;
        
        
        %%% xdat 6
        tsel = thechan*0;
        swhere = find(thechan == 6);
        tcursel(:,1) = SplitVec(swhere,'consecutive','firstval');
        tcursel(:,2) = SplitVec(swhere,'consecutive','lastval');
 
        for i=1:(size(tcursel,1))
            tsel(tcursel(i,1):tcursel(i,2)) = 1;
        end

        tcursel_xdat6=tcursel;
        tsel_xdat6=tsel;
        
        

        for trial=1:length(tcursel_xdat1)

            tsel = thechan*0;
            clear tcursel
            tcursel=[tcursel_xdat1(trial,1),tcursel_xdat6(trial,2)];

            %tsel(tcursel_xdat1(trial,1):tcursel_xdat6(trial,2)) = 1;
            
            for i=1:(size(tcursel,1))
                tsel(tcursel(i,1):tcursel(i,2)) = 1;
            end
            
            tsel_trial(:,trial)=tsel;
            
        end
        
        
        
        for trial=1:length(tcursel_xdat1)

            tsel_trial_numbered(:,trial)=tsel_trial(:,trial)*trial;
        
        end
        
        
        trial_all_sel=sum(tsel_trial_numbered,2);
        
        
        
        
        %%%%
        
        ii_cfg.xdat.tcursel_xdat{1}=tcursel_xdat1;
        ii_cfg.xdat.tcursel_xdat{2}=tcursel_xdat2;
        ii_cfg.xdat.tcursel_xdat{3}=tcursel_xdat3;
        ii_cfg.xdat.tcursel_xdat{4}=tcursel_xdat4;
        ii_cfg.xdat.tcursel_xdat{5}=tcursel_xdat5;
        ii_cfg.xdat.tcursel_xdat{6}=tcursel_xdat6;
        
        ii_cfg.xdat.tsel_xdat{1}=tsel_xdat1;
        ii_cfg.xdat.tsel_xdat{2}=tsel_xdat2;
        ii_cfg.xdat.tsel_xdat{3}=tsel_xdat3;
        ii_cfg.xdat.tsel_xdat{4}=tsel_xdat4;
        ii_cfg.xdat.tsel_xdat{5}=tsel_xdat5;
        ii_cfg.xdat.tsel_xdat{6}=tsel_xdat6;

        ii_cfg.trial.tsel_trial_ones{1}=tsel_trial;
        ii_cfg.trial.tsel_trial_numbered{1}=tsel_trial_numbered;
        ii_cfg.trial.tsel_trial_numbered_together{1}=trial_all_sel;

        
%         tindex = 1;        
%         ii_cfg.tcursel = tcursel;
%         ii_cfg.tsel = tsel;
%         ii_cfg.tindex = tindex;
%         
        putvar(ii_cfg);
        
%         ii_trialplot(1);
    else
        disp('Channel does not exist')
    end
else
    disp('Channel does not exist')
end

end

