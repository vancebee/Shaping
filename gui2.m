function gui2(n)
% clearvars -except n
global fig_h choice 
    
choice = n;

if choice ~= 1 && choice ~= 2 && choice ~= 3
    error('Invalid input. Please restart the program.')
end

fig_h = figure;
ax=gca;
set(gcf,'toolbar','figure');
mp = get(0,'MonitorPositions')
set(gcf, 'Position', mp(1,:));
ax.Position(1) = 0.2; 
hold on;


%% If linear
if choice == 1 % linear

% Text box to enter "InitialThreshold"
uicontrol('Style', 'edit','Tag','Edit1' ,'Position', [50 700 180 30], 'Callback', @Enter_InitialThreshold);
uicontrol('Style', 'text','String','Enter the value of the initial threshold' ,'Position', [50 650 180 40], 'FontSize',12);


% Text box to enter "DotSize"
uicontrol('Style', 'edit','Tag','Edit1' ,'Position', [50 550 180 30], 'Callback', @Enter_DotSize);
uicontrol('Style', 'text','String','Enter the value of the end threshold' ,'Position', [50 500 180 40], 'FontSize',12);


% Text box to enter "Num_Reinforce"
uicontrol('Style', 'edit','Tag','Edit1' ,'Position', [50 400 180 30], 'Callback', @Enter_Num_Reinforce);
uicontrol('Style', 'text','String','Enter the number of reinforcements' ,'Position', [50 330 180 60], 'FontSize',12);

% Button to plot dots
uicontrol('Style','pushbutton', 'String','Display reinforcements',...
        'Position', [50 230 180 50], 'Callback', @(hObject,callbackdata)Display_Dots, 'FontSize',10);
    
% Button to plot function
uicontrol('Style','pushbutton', 'String','Plot function',...
        'Position', [50 150 180 50], 'Callback', @(hObject,callbackdata)Plot_Linear, 'FontSize',10);
    
% Button to confirm function
uicontrol('Style','pushbutton', 'String','Confirm',...
        'Position', [50 80 180 50], 'Callback', @(hObject,callbackdata)Confirm, 'FontSize',10);
    
else
    
% Text box to enter "W0"
uicontrol('Style', 'edit','Tag','Edit1' ,'Position', [50 700 180 30], 'Callback', @Enter_InitialThreshold);
uicontrol('Style', 'text','String','Enter the value of W0' ,'Position', [50 650 180 40], 'FontSize',12);


% Text box to enter "DotSize"
uicontrol('Style', 'edit','Tag','Edit1' ,'Position', [50 550 180 30], 'Callback', @Enter_DotSize);
uicontrol('Style', 'text','String','Enter the value of Wc' ,'Position', [50 500 180 40], 'FontSize',12);


% Text box to enter "Num_Reinforce"
uicontrol('Style', 'edit','Tag','Edit1' ,'Position', [50 400 180 30], 'Callback', @Enter_Num_Reinforce);
uicontrol('Style', 'text','String','Enter the number of reinforcements' ,'Position', [50 330 180 60], 'FontSize',12);

% Button to plot dots
uicontrol('Style','pushbutton', 'String','Display reinforcements',...
        'Position', [50 230 180 50], 'Callback', @(hObject,callbackdata)Display_Dots, 'FontSize',10);
    
% Button to plot function
uicontrol('Style','pushbutton', 'String','Plot function',...
        'Position', [50 150 180 50], 'Callback', @(hObject,callbackdata)Plot_Nonlinear, 'FontSize',10);
    
% Button to confirm function
uicontrol('Style','pushbutton', 'String','Confirm',...
        'Position', [50 80 180 50], 'Callback', @(hObject,callbackdata)Confirm, 'FontSize',10);
    
end
    
    

function Enter_InitialThreshold(hObject,~,~)

global InitialThreshold W0
InitialThreshold = str2double(get(hObject,'String'));  % Used for linear
W0 = str2double(get(hObject,'String'));                % Used for nonlinear
    
return

function Enter_DotSize(hObject,~,~)

global DotSize Wc
DotSize = str2double(get(hObject,'String'));           % Used for linear
Wc = str2double(get(hObject,'String'));                % Used for nonlinear  
    
return

function Enter_Num_Reinforce(hObject,~,~)

global Num_Reinforce tf
Num_Reinforce = str2double(get(hObject,'String'));     % Used for linear
tf = str2double(get(hObject,'String'));                % Used for nonlinear
    
return

function Display_Dots()
global A b W0 Wc tf Num_Reinforce InitialThreshold DotSize Slope choice fig_h xdot_non ydot_non xx yy 
clear x_non y_non xx yy xdot_non ydot_non Slope

cla 
if choice == 1
    
    Slope = linspace(InitialThreshold, DotSize, Num_Reinforce);
    
    alpha = linspace(0,2*pi,360);
    for i = 1:size(Slope,2)
        
        R = Slope(i);      
        xx=R*cos(alpha);        
        yy=R*sin(alpha);
        plot(xx,yy)

        axis tight
        set(gca,'Units','Pixels');
        fig_h.Units = 'pixels';
        axis off
%         reso = get(0,'MonitorPositions');
        
        ylim([-0.5*1080 0.5*1080])
        xlim([-0.5*1920 0.5*1920])
        hold on
    end
    
elseif choice == 2
    
    b = 0.3;  % Define b value for convex
    A = (Wc-W0)/(1-exp(b*tf));
    
    for xdot_non = 0:tf
        ydot_non(xdot_non+1)=A*(1-exp(b*xdot_non))+W0;
        Slope(1,xdot_non+1) = ydot_non(xdot_non+1);
    end
        
        alpha = linspace(0,2*pi,360);        
        for i = 1:size(Slope,2)
        
        R = Slope(i);
        xx=R*cos(alpha);      
        yy=R*sin(alpha);
        plot(xx,yy)

        axis tight
        set(gca,'Units','Pixels');
        fig_h.Units = 'pixels';
        axis off
%         reso = get(0,'MonitorPositions');
        
        ylim([-0.5*1080 0.5*1080])
        xlim([-0.5*1920 0.5*1920])
        hold on
        end
    
        elseif choice == 3
    
    b = -0.3;  % Define b value for convex
    A = (Wc-W0)/(1-exp(b*tf));
    
    for xdot_non = 0:tf
        ydot_non(xdot_non+1)=A*(1-exp(b*xdot_non))+W0;
        Slope(1,xdot_non+1) = ydot_non(xdot_non+1);
    end
        
        alpha = linspace(0,2*pi,360);        
        for i = 1:size(Slope,2)
        
        R = Slope(i);
        xx=R*cos(alpha);      
        yy=R*sin(alpha);
        plot(xx,yy)

        axis tight
        set(gca,'Units','Pixels');
        fig_h.Units = 'pixels';
        axis off
%         reso = get(0,'MonitorPositions');
        
        ylim([-0.5*1080 0.5*1080])
        xlim([-0.5*1920 0.5*1920])
        hold on
    end

end
    


return

function Plot_Nonlinear()
global A b W0 Wc tf Slope choice x_non y_non 
clear x_non y_non 
cla reset

    if choice == 2
        
    b = 0.3;  % Define b value for convex
    A = (Wc-W0)/(1-exp(b*tf));

for x_non = 0:tf
y_non(x_non+1)=A*(1-exp(b*x_non))+W0;
Slope(1,x_non+1) = y_non(x_non+1);
end

plot(0:tf,y_non,'b')
hold on
plot(0:tf,y_non,'r*')
hold on

for x_non = tf:50
    y_non(x_non) = A*(1-exp(b*tf))+W0;
end
plot(tf:50,y_non(tf:50),'b')


    
ylim([0 W0*1.5])
xlim([0 50])
xlabel('Number of clicks');
ylabel('Reinforcement size');

    elseif choice == 3
        
    b = -0.3;  % Define b value for convex
    A = (Wc-W0)/(1-exp(b*tf));

for x_non = 0:tf
y_non(x_non+1)=A*(1-exp(b*x_non))+W0;
Slope(1,x_non+1) = y_non(x_non+1);
end

plot(0:tf,y_non,'b')
hold on
plot(0:tf,y_non,'r*')
hold on

for x_non = tf:50
    y_non(x_non) = A*(1-exp(b*tf))+W0;
end
plot(tf:50,y_non(tf:50),'b')


    
ylim([0 W0*1.5])
xlim([0 50])
xlabel('Number of clicks');
ylabel('Reinforcement size');

    end

return


function Plot_Linear()
global InitialThreshold DotSize Num_Reinforce Slope fig_h x y
clear x y 
cla reset


k = (InitialThreshold - DotSize)/(0 - Num_Reinforce);
Slope = linspace(InitialThreshold, DotSize, Num_Reinforce);


if ((~isempty(InitialThreshold))&& (~isempty(DotSize))&& (~isempty(Num_Reinforce))&&(~isempty(Slope)))&&(InitialThreshold > DotSize)&&((InitialThreshold > 0)&&(DotSize > 0)&&(Num_Reinforce > 0))

for x = 0:Num_Reinforce
y(x+1)=k*x + InitialThreshold ;
end

plot(0:Num_Reinforce,y,'b')
hold on
plot(0:Num_Reinforce,y,'r*')

for x = Num_Reinforce:50
    y(x) = DotSize;
end
plot(Num_Reinforce:50,y(Num_Reinforce:50),'b')


ylim([0 InitialThreshold*1.5])
xlim([0 50])
xlabel('Number of clicks');
ylabel('Reinforcement size');

else
    close(fig_h)
    error('Invalid input. Please restart the program.')
end


return

% function Confirm()
% global InitialThreshold DotSize  a b w Num_Reinforce fig_h QuitProgram
% 
% if ((~isempty(InitialThreshold ))&&(~isempty(DotSize))&&(~isempty(Num_Reinforce)))||((~isempty(a))&&(~isempty(b))&&(~isempty(w)))
%     
% close(fig_h)
% QuitProgram = 0;
% uiresume;
% 
% else
% close(fig_h)
% QuitProgram = 1;
% 
% end


function Confirm()
    close all

    



