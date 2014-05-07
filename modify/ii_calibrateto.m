function ii_calibrateto(chan, chan2, polynum)
%II_CALIBRATETO Summary of this function goes here
%   Detailed explanation goes here

ii_cfg = evalin('base', 'ii_cfg');
cursel = ii_cfg.cursel;
sel = ii_cfg.sel;

if length(cursel) < 1
    disp('No selections made for calibration');
else
    if nargin ~= 3
        prompt = {'Enter channel to calibrate:', 'Enter channel to calibrate to:', 'Polynomial Degree'};
        dlg_title = 'Calibrate To';
        num_lines = 1;
        answer = inputdlg(prompt,dlg_title,num_lines);
        
        chan = answer{1};
        chan2 = answer{2};
        polynum = str2num(answer{3});
    end
    
    basevars = evalin('base','who');
    
    if ismember(chan,basevars)
        if ismember(chan2,basevars)
            c1 = evalin('base',chan);
            c2 = evalin('base',chan2);
            
            c1s = c1(sel==1);
            c2s = c2(sel==1);
            
            z = polyfit(c1s,c2s,polynum);
            fit = polyval(z,c1);
            
            disp('Calibration saved');
            assignin('base',chan,fit);
            ii_replot;
                                     

            [r2_sel rmse_sel]=rsquare(c2s,polyval(z,c1s)); %rsquare() from file exchange            
            [r2 rmse]=rsquare(c2,polyval(z,c1)); %rsquare() from file exchange
            
            % Plot selected data only with regression line
            figure
            scatter(c1s,c2s)
            hold on
            fake_x=linspace(floor(min(c1s)),ceil(max(c1s)));
            fake_y=polyval(z,fake_x);
            plot(fake_x,fake_y,'r')
            hold on
            title(sprintf('Selections only: R^2 = %.3f, RMSE = %.3f',r2_sel,rmse_sel))
            xlabel('recordedETdataPreCalib')
            ylabel('TargetEyePosition')
                                     
            % Plot all data with regression line from selected data only
            figure;            
            scatter(c1,c2);
            axis tight
            axis normal
            hold on
            fake_x=linspace(floor(min(c1)),ceil(max(c1)));
            fake_y=polyval(z,fake_x);
            plot(fake_x,fake_y,'r')
            hold on            
            title(sprintf('All data: R^2 = %.3f, RMSE = %.3f',r2,rmse))
            xlabel('recordedETdataPreCalib')
            ylabel('TargetEyePosition')
            %axis equal
            
            % Plot all three timeseries
            figure
            temp_fit=fit;
            temp_fit(isnan(temp_fit(:,1)),:)=[];
            plot(temp_fit,'r')
            hold on
            temp_c1=c1;
            temp_c1(isnan(temp_c1(:,1)),:)=[];
            plot(temp_c1,'g')
            hold on
            temp_c2=c2;
            temp_c2(isnan(temp_c2(:,1)),:)=[];
            plot(temp_c2,':b')
            legend('fit','original','target')
            title([num2str(chan),'  fit to  ', num2str(chan2)])
 
%              
%              
%              % Plot
%              figure;
%              plot(c1,polyval(z,c1),'r')
%              title('Model: polynomial regression (cubic)')
% 
%              % Plot fit at selections
%              [r2_sel rmse_sel]=rsquare(c2(sel==1),fit(sel==1)); %rsquare() from file exchange
%              %r=polyval(z,c1s); 
%              figure;            
%              scatter(fit(sel==1),c2(sel==1));
%              axis tight
%              axis normal
%              hold on
%              plot(c1,polyval(z,c1),'r')
%              title(sprintf('Selections only: R^2 = %.3f, RMSE = %.3f',r2_sel,rmse_sel))
%              xlabel('fit')
%              ylabel('TargetEyePosition')
%              %axis equal
%              
%              % Plot overall fit
%              [r2 rmse]=rsquare(c2,fit); %rsquare() from file exchange
%              figure;            
%              scatter(fit,c2);
%              axis tight
%              axis normal
%              hold on
%              plot(c1,polyval(z,c1),'r')
%              title(sprintf('All data: R^2 = %.3f, RMSE = %.3f',r2,rmse))
%              xlabel('fit')
%              ylabel('TargetEyePosition')
%              %axis equal
% 
%              figure
%              scatter(c1s,c2s)
%              hold on
%              fake_x=linspace(-1.5,1.5);
%              fake_y=polyval(z,fake_x);
%              plot(fake_x,fake_y,'r')
%              
            
        else
            disp('Channel to calibrate to does not exist in workspace');
        end
    else
        disp('Channel to calibrate does not exist in worksapce');
    end
end
end

