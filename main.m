% Created February 2023

%Brief description: simple script for testing the english abilities in three
%different domains (image recognition, words spelling, letters spelling).
%At the beginning there is a main menu with three different square, each of
%them can be clicked with the mouse for starting a specific exercise. You
%can press esc in the main menu for closing the script.If you press esc during the exercise,
%you will see a feedback screen with your performance in that task and then you will come back to 
%the main menu.

% Clear the MATLAB command window and clear all variables

clc
clear all
Screen('Preference', 'SkipSyncTests', 1);

%% Set the monitor parameter
screenNumber = 0;
[win,screenRect]=Screen('OpenWindow',screenNumber,[211 211 211])
ScreenX = screenRect(3)  
ScreenY = screenRect(4)

%% Present the introductory text
first_texttodisplay = ['Welcome in this english app \n\n You will have to choose between different exercise \n\n The first exercise is an image recognition task \n\n The second one is a word spelling task \n\n and the third one is a letter spelling task \n\n\n PRES ANY KEY TO CONTINUE']
DrawFormattedText(win, first_texttodisplay, 'center', 'center',[255,255,255]);
Screen('flip',win)
KbWait

 list_accuracy = []
 global_index = []
 column = []


%% Main Loop

noclickyet = 1 % stay in this loop until this condition is true

while noclickyet==1
     
%     exercise = 0
    
      %set random color
    
%     random_triplet1 = [randsample(255,3)]
%     random_triplet2 = [randsample(255,3)]
%     random_triplet3 = [randsample(255,3)]
    
    %display a rectangle
    Screen('FillRect', win,[211 211 211],[0 0 ScreenX ScreenY])
    Screen('flip',win)
    
    %find X and Y center of the screen
    ScreenXCenter = screenRect(3)/2;
    ScreenYCenter = screenRect(4)/2;
    
    %set the square size and the separator size of each square
    SquareSize = 250;
    squareExitSize = 100
    SeparationSize = 200;
    squareExitPosition = [0,0,squareExitSize,squareExitSize];
    
    % draw three square on the screen
    Screen('FillRect', win,[0 255 0],[ScreenXCenter-SquareSize/2,ScreenYCenter-SquareSize/2,ScreenXCenter+SquareSize/2,ScreenYCenter+SquareSize/2])
    Screen('FillRect', win,[0 0 255],[ScreenXCenter-SquareSize-SeparationSize-SquareSize/2,ScreenYCenter-SquareSize/2,ScreenXCenter-SeparationSize-SquareSize/2,ScreenYCenter+SquareSize/2])
    Screen('FillRect', win,[0 0 0],[ScreenXCenter+SeparationSize+SquareSize/2,ScreenYCenter-SquareSize/2,ScreenXCenter+SeparationSize+SquareSize+SquareSize/2,ScreenYCenter+SquareSize/2])
    Screen('FillRect', win, [255 0 0], squareExitPosition);

    
    % insert numbers inside each square
    first_exercise = ['1']
    second_exercise = ['2']
    third_exercise = ['3']
    DrawFormattedText(win, second_exercise, ScreenXCenter, ScreenYCenter,[255,255,255]);
    DrawFormattedText(win, first_exercise, ScreenXCenter-SquareSize-SeparationSize, ScreenYCenter,[255,255,255]);
    DrawFormattedText(win, third_exercise, ScreenXCenter+SeparationSize+SquareSize, ScreenYCenter,[255,255,255]);
    
    %insert the exit text inside the escapre square
    
    exit_text = ['EXIT']
%   DrawFormattedText(win,exit_text,0,squareExitSize/2,[255,255,255]);
    Screen('DrawText', win, exit_text,0,squareExitSize/2);

    
    % create and write a legend for each square
    legend = ['Legend: \n\n 1 - Word sound transcription \n\n 2- Image recognition \n\n 3 - Alphabet letters sound transcription']
    DrawFormattedText(win, legend, 'center', (ScreenY/1.2) ,[0,0,0]);

    
    % create a title
    title = ['Each square contains a different exercise. Click on one of them for starting the exercise \n\n Click the exit button for closing the script']
    DrawFormattedText(win, title, 'center', (ScreenY/10) ,[255,0,0]);
    Screen('flip',win)
    
 
%% Innested Loop

    while true
        
        %Get the mouse coordinates
        [mouseX,mouseY,button]=GetMouse(win);
        
        % check the coordinates of the mouse - escape rect 
        
        if IsInRect(mouseX,mouseY,squareExitPosition)==1 && button(1)==1 
            noclickyet = 0 % if you click the escape rect, noclickyet turned to false and the main loop will be closed
            sca
            break
            
        % check the coordinates of the mouse - Image recognition exercise            
            
        elseif IsInRect(mouseX,mouseY,[ScreenXCenter-SquareSize/2,ScreenYCenter-SquareSize/2,ScreenXCenter+SquareSize/2,ScreenYCenter+SquareSize/2]) == 1 && button(1)==1   
            
            % set the directory
            cd path/to/stimuli/images
            files = shuffle(dir('*.jpg')) ; 
            N = length(files);
            
            %create some variables for this exercise
            list_image = {}
            myString=[];
            typedword = []
            counter = 0
            i=1
            score_spelling = 0
            texttodisplay = ['Write the name of the image just displayed']
            textintroduction = ['You will see different images \n \n Write the correct name \n \n Press any key to continue']
            textintroduction_2 = ['Press enter for displaying the image or esc for closing']
            
            exercise = 2
            
            %display the text
            Screen('FillRect', win,[211 211 211],[0 0 ScreenX ScreenY])
            DrawFormattedText(win, textintroduction, 'center', 'center',[0,0,0]);
            Screen(win,'Flip');
            KbWait

%% Image recognition exercise
            
            % repeat until i < N
            while i<N 
                
                % display a rect and text
                Screen('FillRect', win,[211 211 211],[0 0 ScreenX ScreenY])
                DrawFormattedText(win, textintroduction_2, 'center', 'center',[0,0,0]);
                Screen(win,'Flip');
                
                %wait until a key is pressed, then convert the keyCode
                [secs, keyCode, deltaSecs] = KbStrokeWait()
                KeyPressed = KbName(keyCode)
                
                % if statement, check different key pressed and do
                % different actions
                
                if strcmp(KeyPressed,'return')
                    
                    %display the image in the folder
                    list_image{i} = files(i).name;
                    list_image = string(list_image)';
                    myImage=imread(files(i).name);
                    Screen('FillRect', win,[211 211 211],[0 0 ScreenX ScreenY])
                    tex=Screen('MakeTexture',win, myImage);
                    Screen('DrawTexture', win,tex);
                    Screen(win,'Flip');
                    pause(2)
                    DrawFormattedText(win, texttodisplay, 'center', 'center',[0,0,0]);
                    Screen('flip',win);
                    
                    % create a string with the name of the image in the
                    % position i inside list_image
                    splitted_keyword = strsplit(list_image(i),'.');
                    
                    %Increment i and the counter
                    i = i+1
                    counter = counter +1
                    
                    %call the typedword function 
                    [typedword] = PTBTypedWord(win)  
                    
                    % compare the output of the typedword function with the
                    % name of the image inside splitted_keyword
                    
                    if strcmp(typedword, splitted_keyword(1)) == 1
                        Screen('FillRect', win,[0,255,0],[0 0 ScreenX ScreenY])
                        DrawFormattedText(win, 'Correct! \n\n You are doing well!', 'center', 'center')
                        Screen('flip',win,[],0);
                        pause(2)
                        
                        % if correct, increment the score of the subject
                        score_spelling = score_spelling+1 
                        
                    elseif strcmp(typedword, splitted_keyword(1)) == 0
                        Screen('FillRect', win,[255,0,0],[0 0 ScreenX ScreenY] )
                        DrawFormattedText(win, 'Wrong! \n\n Try again! Practice make it perfect!', 'center', 'center')
                        Screen('flip',win,[],0);
                        pause(2)
                        
                        %if wrong, decrement the score of the subject
                        score_spelling = score_spelling      
                    end
                 
                % escape key - coming back to the main menu - break this while loop    
                elseif strcmp(KeyPressed,'esc')
                    break
                    
                % else do nothing
                else  
                    ;
                end
               
            end
            
            %assign the score_spelling value to accuracy
            accuracy = score_spelling
            
            %call the final_accuracy function for calculating the
            %performance of the subject in this task. Display a final
            %message
            [final_message,final_score,list_accuracy,global_index] = final_accuracy(win,accuracy,counter, ScreenX, ScreenY,list_accuracy,global_index,exercise)
            
            % loop always true until the subject press esc. The final
            % message is always on screen utile esc is pressed
             while true
                    [secs, keyCode, deltaSecs] = KbStrokeWait()
                    KeyPressed = KbName(keyCode)
                 if strcmp(KeyPressed,'esc')
                     break
                 else
                     ;
                 end
             end
                break
            

%                a = num2str(score_spelling/(i-1));
%                texttodisplay_5 = ['Your accuracy in this exercise is equal to \n \n' a];
%                DrawFormattedText(win, texttodisplay_5, 'center', 'center', [0,0,0]);
%                Screen('flip',win);
%                KbWait
%                break
    
       
        elseif IsInRect(mouseX,mouseY,[ScreenXCenter-SquareSize-SeparationSize-SquareSize/2,ScreenYCenter-SquareSize/2,ScreenXCenter-SeparationSize-SquareSize/2,ScreenYCenter+SquareSize/2]) == 1 && button(1)==1
            
        
            %Set the directory where to find the .wav file
            cd path/to/stimuli/words
            
            exercise = 1
            
            %Create some variables for this exercise
            files = shuffle(dir('*.wav')) ; 
            N = length(files) ; 
            word_sounds= {}
            texttodisplay_2 = ['You will hear different words. \n \n After each words, you have to spell that words. \n \n Press any key to continue ']
            DrawFormattedText(win, texttodisplay_2, 'center', 'center',[0,0,0]);
            Screen('flip',win);
            KbWait
            Screen('flip',win);
            i=1
            texttodisplay_3 = ['Press enter for playing the sound or press "esc" for closing']
            texttodisplay_4 = ['Spell the word']
            counter = 0
            accuracy = 0
            
            % condition always true until a specific requirement is reached
            while i<N
                
                word_sounds{i} = files(i).name
                word_sounds = string(word_sounds)
                splitted_keyword = strsplit(word_sounds(i),'.');

                % Load the WAV file 
                [y, fs] = audioread(word_sounds(i));

                % Open the audio device
                pahandle = PsychPortAudio('Open', [], [], 0, fs, 1);

                % Fill the audio playback buffer with the audio data
                PsychPortAudio('FillBuffer', pahandle, y');
                
                %Display a text
                DrawFormattedText(win, texttodisplay_3, 'center', 'center',[0,0,0]);
                Screen('flip',win);
                
                %Check if a key is pressed
                [secs, keyCode, deltaSecs] = KbStrokeWait()
                KeyPressed = KbName(keyCode)
                
                %if enter is pressed do this
                if strcmp(KeyPressed,'return') 
                    Screen('FillRect', win,[211 211 211],[0 0 ScreenX ScreenY])
                    Screen('flip',win);
                    pause(1)
                    
                    % Start audio playback
                    PsychPortAudio('Start', pahandle, 1, 0, 1);
                    pause(0.5)
                    DrawFormattedText(win, texttodisplay_4, 'center', 'center',[0,0,0]);
                    Screen('flip',win);
                    
                    %call the TypedWord function and return the typedword
                    [typedword] = PTBTypedWord(win)
                    
                    %call the checkword function and return the accuracy
                    %and the counter
                    [accuracy,counter] = checkword(win,accuracy,counter,splitted_keyword,typedword,ScreenX,ScreenY)
                    
                    % Wait for the audio to finish playing
                    PsychPortAudio('Stop', pahandle, 1);
                    
                    % Close the audio device
                    PsychPortAudio('Close', pahandle);
                    
                    %increment the i index
                    i = i+1
                    
                    %escape key condition
                    elseif strcmp(KeyPressed,'esc')
                        break      
                else
                    ;
                end
            end
            
            %call the final_accuracy function for calculating the
            %performance of the subject in this task. Display a final
            %message
            
            [final_message,final_score,list_accuracy,global_index] = final_accuracy(win,accuracy,counter, ScreenX, ScreenY,list_accuracy,global_index,exercise)
    
            
            % loop always true until the subject press esc. The final
            % message is always on screen utile esc is pressed
            while true
                   [secs, keyCode, deltaSecs] = KbStrokeWait()
                    KeyPressed = KbName(keyCode)
                if strcmp(KeyPressed,'esc')
                    break
                else
                    ;
                end
            end
            break

% a = num2str(accuracy/(i-1));
% texttodisplay_5 = ['Your accuracy in this exercise is equal to \n \n' a];
% DrawFormattedText(win, texttodisplay_5, 'center', 'center', [0,0,0]);
% Screen('flip',win);
% KbWait
% break

 % check the coordinates of the mouse - single letter spelling exercise
        elseif IsInRect(mouseX,mouseY,[ScreenXCenter+SeparationSize+SquareSize/2,ScreenYCenter-SquareSize/2,ScreenXCenter+SeparationSize+SquareSize+SquareSize/2,ScreenYCenter+SquareSize/2]) == 1 && button(1)==1
                
            exercise = 3
            
            %set the directory where to find the .wav files with letters
                cd path/to/stimuli/letters
            
                %create some variables for this exercise
                files = shuffle(dir('*.wav')) ; 
                N = length(files) ; 
                word_sounds= {}
                texttodisplay_2 = ['You will hear different letters. \n \n After each letters, you have to press the correct letter on the keyboard. \n \n Press any key to continue ']
                DrawFormattedText(win, texttodisplay_2, 'center', 'center',[0,0,0]);
                Screen('flip',win);
                KbWait
                Screen('flip',win);
                i = 1
                texttodisplay_3 = ['Press enter for playing the sound or press "esc" for closing']
                texttodisplay_4 = ['Press the correct letter on the keyboard']
                counter = 0
                accuracy = 0

                % condition true until a condition is reached
                while i<=N
                    word_sounds{i} = files(i).name
                    word_sounds = string(word_sounds)
                    splitted_keyword = strsplit(word_sounds(i),'.');

                    % Load the WAV file into memory
                    [y, fs] = audioread(word_sounds(i));

                    % Open the audio device
                    pahandle = PsychPortAudio('Open', [], [], 0, fs, 1);

                    % Fill the audio playback buffer with the audio data
                    PsychPortAudio('FillBuffer', pahandle, y');

                    DrawFormattedText(win, texttodisplay_3, 'center', 'center',[0,0,0]);
                    Screen('flip',win);
                    
                    %Check if a key is pressed
                    [secs, keyCode, deltaSecs] = KbStrokeWait()
                    KeyPressed = KbName(keyCode)
                    
                    %if return is pressed, do this
                    if strcmp(KeyPressed,'return') 
                        Screen('FillRect', win,[211 211 211],[0 0 ScreenX ScreenY])
                        Screen('flip',win);
                        pause(1)
                        % Start audio playback
                        PsychPortAudio('Start', pahandle, 1, 0, 1);
                        pause(0.5)
                        DrawFormattedText(win, texttodisplay_4, 'center', 'center',[0,0,0]);
                        Screen('flip',win);
                        [typedword] = PTBTypedWord(win)
                        [accuracy,counter] = checkword(win,accuracy,counter,splitted_keyword,upper(typedword),ScreenX,ScreenY)
                        % Wait for the audio to finish playing
                        PsychPortAudio('Stop', pahandle, 1);
                        % Close the audio device
                        PsychPortAudio('Close', pahandle); 
                        i = i+1
                        
                    % escape key condition
                    elseif strcmp(KeyPressed,'esc')
                        break 
                        
                    % do nothing
                    else
                        ;
                    end
                end
                 
                %call the final_accuracy function, and return final_message
                %as output
                [final_message, final_score,list_accuracy,global_index] = final_accuracy(win,accuracy,counter, ScreenX, ScreenY,list_accuracy,global_index,exercise)

                            
            % loop always true until the subject press esc. The final
            % message is always on screen utile esc is pressed
            
                while true
                       [secs, keyCode, deltaSecs] = KbStrokeWait()
                        KeyPressed = KbName(keyCode)
                    if strcmp(KeyPressed,'esc')
                        break
                    else
                        ;
                    end
                end
                break
                
        end
   
    end


end


%% create a final table for storing the accuracy of each attempt

row = 1:length(list_accuracy)

new_row = []

for each = row
    new_row = [new_row, each]
end
    
final_table = table(new_row',list_accuracy)
final_table = renamevars(final_table,["Var1","list_accuracy"],["Attempt","Accuracy in that attempt as a %"])

% take the global index array from the function final_accuracy. Each values
% of this global_index is associated with an exercise (1 - Word spelling,
% 2- image recognition, 3- Single letters spelling)

new_global = flip(global_index);

array = cell(1, length(new_global)); % initialize array with a preallocated length

% for loop - creating a cell array with the name of the exercises done by
% the subjects, based on the conted stored in new_global

for i = 1:length(new_global)
    if new_global(i) == 2
        text = 'Image recognition';
        array{i} = text;
    elseif new_global(i) == 1
        text = 'Words spelling';
        array{i} = text;
    elseif new_global(i) == 3
        text = 'Single letters spelling';
        array{i} = text;
    end
end

% add the content of array to the final_table
exercise_list = cell2table(array')
final_table.exercise = table2array(exercise_list)

%change directory and create an excel file as a output

cd path/to/output
writetable(final_table,'Final_Output.xlsx','Sheet',1);