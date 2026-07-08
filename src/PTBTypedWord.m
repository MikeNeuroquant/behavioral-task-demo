% Created February 2023


%%Brief description: This function return as a output an array. The otuput
%%is displayed on the screen through DrawFormattedText

function [typedword] = PTBTypedWord(win)

%define an empty array
typedword = []

%always true loop
while true
    
   %check if a key is pressed
   [secs, keyCode, deltaSecs] = KbStrokeWait()
    KeyPressed = KbName(keyCode)
    
    %break the loop if return is pressed
    if strcmp(KeyPressed, "return")
        break
    
    %delete the last word if backspace is pressed
    elseif strcmp(KeyPressed,"backspace")
       typedword(end)=[]
       
    %otherwise concatenate in lowercase in the empty array    
    else
       typedword = lower([typedword KeyPressed])
    end

    DrawFormattedText(win,typedword,'center','center')
    Screen(win,'flip')
end
