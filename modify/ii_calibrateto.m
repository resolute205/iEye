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
                                     
             % Plot
             figure
             fit_timeseries=z(1)*c1s.^3+z(2)*c1s.^2+z(3)*c1s+z(4);
             plot(fit_timeseries,'r')
             hold on
             plot(c1s,'g')
             hold on
             plot(c2s,':b')
             legend('fit','original','target')
             title([num2str(chan),'  fit to  ', num2str(chan2)])
            
             % Plot
             figure;
             plot(c1,polyval(z,c1),'r')
             title('Model: polynomial regression (cubic)')

             % Plot fit at selections
             [r2_sel rmse_sel]=rsquare(c2(sel==1),fit(sel==1)); %rsquare() from file exchange
             %r=polyval(z,c1s); 
             figure;            
             scatter(fit(sel==1),c2(sel==1));
             axis tight
             axis normal
             hold on
             plot(c1,polyval(z,c1),'r')
             title(sprintf('Selections only: R^2 = %.3f, RMSE = %.3f',r2_sel,rmse_sel))
             xlabel('fit')
             ylabel('TargetEyePosition')
             %axis equal
             
             % Plot overall fit
             [r2 rmse]=rsquare(c2,fit); %rsquare() from file exchange
             figure;            
             scatter(fit,c2);
             axis tight
             axis normal
             hold on
             plot(c1,polyval(z,c1),'r')
             title(sprintf('All data: R^2 = %.3f, RMSE = %.3f',r2,rmse))
             xlabel('fit')
             ylabel('TargetEyePosition')
             %axis equal

            
        else
            disp('Channel to calibrate to does not exist in workspace');
        end
    else
        disp('Channel to calibrate does not exist in worksapce');
    end
end
end

