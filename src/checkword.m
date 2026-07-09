function [accuracy,counter] = checkword(win,accuracy,counter,splitted_keyword,typedword,ScreenX,ScreenY)


     if strcmp(typedword,splitted_keyword(1)) == 1
        Screen('FillRect', win,[0,255,0],[0 0 ScreenX ScreenY])
        DrawFormattedText(win, 'Correct! \n\n You are doing well!', 'center', 'center')
        Screen('flip',win,[],0);
        pause(2)
        accuracy = accuracy + 1
        
              
    else
        Screen('FillRect', win,[255,0,0],[0 0 ScreenX ScreenY])
        DrawFormattedText(win, 'Wrong! \n\n Try again! Practice make it perfect!', 'center', 'center')
        Screen('flip',win,[],0);
        pause(2)
        accuracy = accuracy
       
     end
     Screen('FillRect', win,[211,211,211],[0 0 ScreenX ScreenY])
     counter = counter+1
     
end