

function ii_velocity_plot_selection(x,y)
% Calculate eye-movement velocity using eye-tracker X and Y channels as
% input. This vector is automatically saved to ii_cfg.velocity

if nargin ~= 2
    prompt = {'Channel 1 (X)', 'Channel 2 (Y)'};
    dlg_title = 'Velocity';
    num_lines = 1;
    answer = inputdlg(prompt,dlg_title,num_lines);
    
    x = answer{1};
    y = answer{2};
end

basevars = evalin('base','who');
ii_cfg = evalin('base', 'ii_cfg');

if ismember(x,basevars)
    if ismember(y,basevars)
        
        xvel = evalin('base',x);
        yvel = evalin('base',y);
        
        xvel = diff(xvel);
        yvel = diff(yvel);
        
        xvel = abs(xvel);
        yvel = abs(yvel);
        
        xvel = xvel.^2;
        yvel = yvel.^2;
        
        vel = xvel + yvel;
        vel = sqrt(vel);
        vel = [0; vel];
        
        ii_cfg.velocity = vel;
        
         % Plot results
         %figure('Name','Velocity Channel','NumberTitle','off');
         %plot(vel);
         
         velNoNaN=vel;
         velNoNaN(isnan(velNoNaN(:,1)),:)=[];
         mean_vel=mean(velNoNaN);
         std_vel=std(velNoNaN);
         mean_3std_thresh=mean(mean_vel)+(3*std_vel);

         [m,n]=size(velNoNaN);
         thresh(1:m,n)=mean_3std_thresh;

         temp_sel=ii_cfg.sel;
         temp_sel(isnan(temp_sel(:,1)),:)=[];
         
         figure;
         plot(velNoNaN)
         hold on
         plot(thresh,'r')
         hold on
         plot(temp_sel,'y')
         %grid on
         %grid minor
         %title('Zvel,2samples,')
         title(sprintf('Zvel,2samples: mean = %.3f, std = %.3f, meanPlus3Std = %.3f',mean_vel,std_vel,mean_3std_thresh))
         legend('Z velocity','thresh','selection')
         
         just_sel_vel=ii_cfg.sel .* vel;
         just_sel_vel(isnan(just_sel_vel(:,1)),:)=[];
         figure
         plot(just_sel_vel)
         grid on
         grid minor
         title('Z Velocity Plot of Selection Only')
         
        
        [m,n]=size(ii_cfg.trial.tsel_trial_ones{1});
        for trial=1:n

            
            maxVel_byTrial_EpochsInSelector(trial)=max((ii_cfg.trial.tsel_trial_ones{1}(:,trial)) .* (ii_cfg.sel .* vel));
            medVel_byTrial_EpochsInSelector(trial)=median((ii_cfg.trial.tsel_trial_ones{1}(:,trial)) .* (ii_cfg.sel .* vel));
            meanVel_byTrial_EpochsInSelector(trial)=mean((ii_cfg.trial.tsel_trial_ones{1}(:,trial)) .* (ii_cfg.sel .* vel));
            
        end

         ii_cfg.maxVel_byTrial_EpochsInSelector=maxVel_byTrial_EpochsInSelector;
         ii_cfg.medVel_byTrial_EpochsInSelector=medVel_byTrial_EpochsInSelector;
         ii_cfg.meanVel_byTrial_EpochsInSelector=meanVel_byTrial_EpochsInSelector;

         
         putvar(ii_cfg);

    else
        disp('Channel to does not exist in worksapce');
    end
else
    disp('Channel to does not exist in worksapce');
end


end

