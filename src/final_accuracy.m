% Created February 2023

%Brief description: this function is called final_accuracy. It is called in
%the main script for calculating the final performance of the subject after
%an exercise. It take as a input different parameters, like
%win,accuracy,counter,ScreenX, ScreenY defined in the main script, and it
%give as output a final_message. The accuracy of the subject is subdivided
%in four categories, from 0 to 100% of accuracy. Also this function display
%as output an emoji, in accordance with the performance of the subject.

function [final_message, final_score,list_accuracy,global_index] = final_accuracy(win,accuracy,counter,ScreenX, ScreenY,list_accuracy,exercise,global_index)

    % calculate the final score with some imported parameters from the main
    % script
    final_score = accuracy/counter
    
    %set the directory where to find the emoji
    cd path/to/assets/smile_results
    
    %set the size of the emoji
    squareSize = 200
    
    %create a structure with different image format
    smile = [dir('*.jpg');dir('*.png')]
    
    %convert the structure into a table and sort the rows
    smile = struct2table(smile);
    sorted = sortrows(smile);
    
    %reconvert the table into struct
    sortedsmile = table2struct(sorted)
    
    %find the coordinate on the screen fro drawing the square
    centerX = ScreenX/2;
    centerY = ScreenY - squareSize/2;
    height = 100

    % set different if statement for the final score
    if isnan(final_score) 
       
       final_message = ['Accuracy not available because you have not complete anything\n\n Press esc to return to the main menu']
       color = [255,0,255]
       index = 1
       
    elseif final_score*100 <= 25
        
        final_message = ['Your accuracy in this exercise is equal to \n \n' num2str(final_score*100) '%\n\n You can improve a lot more!\n\n Press esc to return to the main menu'];
        color = [255,0,0]
        index = 2

         
    elseif final_score*100 >25 && final_score*100 <= 50
        
        final_message = ['Your accuracy in this exercise is equal to \n \n' num2str(final_score*100) '%\n\n Fairly good but you can improve a bit more!\n\n Press esc to return to the main menu'];
        color = [255,117,20]
        index = 3
        
    elseif final_score*100 > 50 && final_score*100 <= 75
        
        final_message = ['Your accuracy in this exercise is equal to \n \n' num2str(final_score*100) '%\n\n You are good!\n\n Press esc to return to the main menu'];
        
        color = [0,255,0]
        index = 4
        
    else 
        
        final_message = ['Your accuracy in this exercise is equal to \n \n' num2str(final_score*100) '%\n\n You are excelent!\n\n Press esc to return to the main menu'];
        color = [8,143,143]
        index = 5
    end

%change the color of the screen in accordance with the final score of the
%subject
Screen('FillRect', win,[color(1) color(2) color(3)],[0 0 ScreenX, ScreenY])

%draw the square
squareCoords = [centerX - squareSize/2, centerY - squareSize/2-height, centerX + squareSize/2, centerY + squareSize/2-height];
myImage=imread(sortedsmile(index).name)

%draw the image in the squareCoords
tex=Screen('MakeTexture',win, myImage);
Screen('DrawTexture', win,tex,[],squareCoords);
DrawFormattedText(win,final_message, 'center', 'center', [0,0,0]);
Screen('flip',win)

list_accuracy = [list_accuracy;(final_score*100)]
global_index = [global_index;exercise]

end







        

    
        