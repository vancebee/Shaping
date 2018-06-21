%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% REVIEW %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function review(n)

global Click DotLoc Dot_Rect DotSize Yes Threshold 

black = [0 0 0];
white = [255 255 255];
grey = [128 128 128];
red = [255 0 0];
green = [0 255 0];
blue = [0 0 255];


commandwindow;

% Screen setup
[w,winRect]=Screen('OpenWindow',0,[0 0 0]);

Screen('Preference', 'VisualDebugLevel', 1);
Screen('TextSize', w, 20);
Screen('TextFont',w,'Times');
Screen('TextStyle',w,1); 



% Display clicks and connect clicks

for m = 1:size(Click{n,1},1)
    
    
            %%%%%%Display target%%%%%%%%%%%%
% 
Dot_Rect(1,1) = DotLoc(n,1) - DotSize;  % Left
Dot_Rect(2,1) = DotLoc(n,2) - DotSize;  % Top
Dot_Rect(3,1) = DotLoc(n,1) + DotSize;  % Right
Dot_Rect(4,1) = DotLoc(n,2) + DotSize;  % Bottom
Screen('FillOval', w, grey, Dot_Rect);

%%%%%%%%%Display start and end click%%%%%%%%%%%%%%%%
frame_start = [Click{n,1}(1,1)-5 Click{n,1}(1,2)-8;Click{n,1}(1,1)-5 Click{n,1}(1,2)+8;Click{n,1}(1,1)+10 Click{n,1}(1,2)];  % First click
frame_end = [Click{n,1}(size(Click{n,1},1),1)-7 Click{n,1}(size(Click{n,1},1),2)-7;Click{n,1}(size(Click{n,1},1),1)-7 Click{n,1}(size(Click{n,1},1),2)+7;Click{n,1}(size(Click{n,1},1),1)+7 Click{n,1}(size(Click{n,1},1),2)+7;Click{n,1}(size(Click{n,1},1),1)+7 Click{n,1}(size(Click{n,1},1),2)-7];
Screen('FillPoly', w, white, frame_start ,1);
Screen('FillPoly', w, white, frame_end ,1);

% WaitSecs(0.5);

%%%%%%%%%%%%Display good and bad clicks
    if Yes{n,1}(m,1) == 1
    Screen('DrawDots', w, [Click{n,1}(m,1);Click{n,1}(m,2)], 10, green, [0 0], 1);
    else
    Screen('DrawDots', w, [Click{n,1}(m,1);Click{n,1}(m,2)], 10, red, [0 0], 1);
    end
    
    
    % Display reinforcements
Target_Rect(1,m) = DotLoc(n,1) - Threshold(n,m);  % Left
Target_Rect(2,m) = DotLoc(n,2) - Threshold(n,m);  % Top
Target_Rect(3,m) = DotLoc(n,1) + Threshold(n,m);  % Right
Target_Rect(4,m) = DotLoc(n,2) + Threshold(n,m);  % Bottom
Screen('FrameOval', w, grey, Target_Rect(1:4,m), 2);


DrawFormattedText(w, num2str(m), 0.9*winRect(3), 0.1*winRect(4), white);

Screen('Flip', w) ; 
WaitSecs(0.5);

end  % m


%%%%%%%%%%%%%%%% Display everything   %%%%%%%%%%%%%%%%%%

 %%%%%%Display target%%%%%%%%%%%%
 
Dot_Rect(1,1) = DotLoc(n,1) - DotSize;  % Left
Dot_Rect(2,1) = DotLoc(n,2) - DotSize;  % Top
Dot_Rect(3,1) = DotLoc(n,1) + DotSize;  % Right
Dot_Rect(4,1) = DotLoc(n,2) + DotSize;  % Bottom
Screen('FillOval', w, grey, Dot_Rect);

for m = 1:size(Click{n,1},1)
    
% Display reinforcements
Target_Rect(1,m) = DotLoc(n,1) - Threshold(n,m);  % Left
Target_Rect(2,m) = DotLoc(n,2) - Threshold(n,m);  % Top
Target_Rect(3,m) = DotLoc(n,1) + Threshold(n,m);  % Right
Target_Rect(4,m) = DotLoc(n,2) + Threshold(n,m);  % Bottom
Screen('FrameOval', w, grey, Target_Rect(1:4,m), 2);


% Display dots
    if Yes{n,1}(m,1) == 1
    Screen('DrawDots', w, [Click{n,1}(m,1);Click{n,1}(m,2)], 10, green, [0 0], 1);
    else
    Screen('DrawDots', w, [Click{n,1}(m,1);Click{n,1}(m,2)], 10, red, [0 0], 1);
    end

frame_start = [Click{n,1}(1,1)-5 Click{n,1}(1,2)-8;Click{n,1}(1,1)-5 Click{n,1}(1,2)+8;Click{n,1}(1,1)+10 Click{n,1}(1,2)];  % First click
frame_end = [Click{n,1}(size(Click{n,1},1),1)-7 Click{n,1}(size(Click{n,1},1),2)-7;Click{n,1}(size(Click{n,1},1),1)-7 Click{n,1}(size(Click{n,1},1),2)+7;Click{n,1}(size(Click{n,1},1),1)+7 Click{n,1}(size(Click{n,1},1),2)+7;Click{n,1}(size(Click{n,1},1),1)+7 Click{n,1}(size(Click{n,1},1),2)-7];
Screen('FillPoly', w, white, frame_start ,1);
Screen('FillPoly', w, white, frame_end ,1);

% Screen('DrawDots', w, [Click{n,1}(1,1);Click{n,1}(1,2)], 8, blue, [0 0], 1);   % First Click blue
% Screen('DrawDots', w, [Click{n,1}(size(Click{n,1},1),1);Click{n,1}(size(Click{n,1},1),2)], 8, white, [0 0], 1);   % Last Click white
end

%%%Display trajectory
for t = 1:size(Click{n,1},1) - 1
    Screen('DrawLines', w, [Click{n,1}(t,1) Click{n,1}(t+1,1);Click{n,1}(t,2) Click{n,1}(t+1,2)], 2, white, [0 0]);
end  % t

DrawFormattedText(w, num2str(size(Click{n,1},1)), 0.9*winRect(3), 0.1*winRect(4), white);

Screen('Flip', w) ; 

    press = true;

while press
    [~, keyCode, ~] = KbWait;
    
    pressedKey = KbName(keyCode) ;
    if  strcmpi(pressedKey, 'space') == 1
        press = false;
    end
    
end
Screen('CloseAll');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
