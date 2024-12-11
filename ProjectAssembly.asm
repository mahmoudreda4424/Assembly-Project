.MODEL SMALL
;.STACK 500H
  
  .DATA            
      NL DB 0DH,0AH,'$'
      msg_stars DB '                         *******************************', 0DH, 0AH, '$' 
      msg_error_stars DB '                     --<<->>-<<->>-<<->>-<<->>-<<->>-<<->>--', 0DH, 0AH, '$'
      msg_line DB '--------------------------------------', 0DH, 0AH, '$'
      msg_project_name DB '                     --<<* Mind vs Computer Challenges *>>--', 0DH, 0AH, '$'
      msg_welcome DB '    --------<< Welcome to the game! Please choose a game to play >>--------', 0DH, 0AH, '$'
      msg_choice DB 0DH, 0AH, ' {0_0} Enter your choice (1 or 2): $'
      msg_invalid DB 0DH, 0AH, '                        Invalid choice, please try again!$', 0DH, 0AH
      msg_correct DB '        Correct answer!$', 0DH, 0AH
      msg_wrong DB '        Wrong answer!$', 0DH, 0AH
      msg_continue DB 'Do you want to continue? (Y/N): $', 0DH, 0AH
      msg_exit DB '                           Exiting the game. Goodbye!$', 0DH, 0AH 
      final_stage DB 0Dh, 0Ah, '            ----<<You have completed the questions. Thank you!>>----', 0Dh, 0Ah, '$'
     
      choice DB ? 
      user_input DB ? 
      continue_choice DB ? 
  
        
      choose_prompt DB '    Choose the correct answer: a, b, or c', 0DH, 0AH, '$'
  
      
      seq_question1 DB '        1)Find the next number in the series: 1, 1, 2, 3, 5, ...$', 0DH, 0AH, '$'
      seq_question1_1 DB '        a) 8    b) 7    c) 6 ','$'
      seq_answer1 DB 'a'
      
      seq_question2 DB '        2)What comes next in the series: 2, 6, 12, 20, ...$', 0DH, 0AH, '$'
      seq_question2_1 DB '        a) 28    b) 30    c) 36 ','$'
      seq_answer2 DB 'b'
      
      seq_question3 DB '        3)Find the next number in the series: 3, 9, 27, 81, ...$', 0DH, 0AH, '$'
      seq_question3_1 DB '        a) 243    b) 162    c) 324 ','$'
      seq_answer3 DB 'a'
      
      seq_question4 DB '        4)What comes next in the series: 10, 5, 15, 7.5, ...$', 0DH, 0AH, '$'
      seq_question4_1 DB '        a) 12.5    b) 16.25    c) 22.5 ','$'
      seq_answer4 DB 'c'
      
      seq_question5 DB '        5)Find the missing number: 2, 4, 8, 16, 32, ...$', 0DH, 0AH, '$'
      seq_question5_1 DB '        a) 48    b) 64    c) 96 ','$'
      seq_answer5 DB 'b'
      
      seq_question6 DB '        6)What is the next number in the series: 7, 14, 28, 56, 112, ...$', 0DH, 0AH, '$'
      seq_question6_1 DB '        a) 224    b) 182    c) 196 ','$'
      seq_answer6 DB 'a'
      
      seq_question7 DB '        7)Find the next number: 5, 10, 25, 50, 125, ...$', 0DH, 0AH, '$'
      seq_question7_1 DB '        a) 150    b) 200    c) 250 ','$'
      seq_answer7 DB 'c'
      
      seq_question8 DB '        8)What is next in the series: 1, 4, 9, 16, 25, ...$', 0DH, 0AH, '$'
      seq_question8_1 DB '        a) 30    b) 36    c) 42 ','$'
      seq_answer8 DB 'b'
      
      seq_question9 DB '        9)Find the missing number: 11, 22, 33, 55, 77, ...$', 0DH, 0AH, '$'
      seq_question9_1 DB '        a) 99    b) 88    c) 121 ','$'
      seq_answer9 DB 'a'
      
      seq_question10 DB '        10)What is next in the series: 0, 1, 1, 2, 3, 5, 8, 13, ...$', 0DH, 0AH, '$'
      seq_question10_1 DB '        a) 20    b) 21    c) 22 ','$'
      seq_answer10 DB 'b'
      
  
      current_question DB 1
      
      msg_score DB 'Your score: ', '$'
      points DB 0 
                      
                      
      msg_time_elapsed db 'Time elapsed: ','$'

      ; Variables to store the time at the start of the game
      start_hours db 0
      start_minutes db 0
      start_seconds db 0
      start_ticks db 0
      
      ; Variables to store the time at the end of the game
      end_hours db 0
      end_minutes db 0
      end_seconds db 0
      end_ticks db 0

      
      msg_games_list DB '1. Number Sequence Game (1)', 0DH, 0AH, '2. Exit the Game (2)', 0DH, 0AH, '$'
  
.CODE 

   MAIN PROC FAR
    
       .STARTUP
                 
       ; Initial setup for display properties using BIOS interrupt (INT 10H)
       MOV AH, 0
       MOV AL, 2
       INT 10H
       
       
       ; Display the introductory project title with decorative stars
   
       call NEW_LINE    ; Call to print a new line
   
       LEA DX, msg_stars
       MOV AH, 09H
       INT 21H
   
       LEA DX, msg_project_name
       MOV AH, 09H
       INT 21H
   
       LEA DX, msg_stars
       MOV AH, 09H
       INT 21H  
       
       call NEW_LINE
       call NEW_LINE
                     
       ; Display the welcome message                   
       LEA DX, msg_welcome
       MOV AH, 09H
       INT 21H
       
       
       call NEW_LINE
       call NEW_LINE
       
       ; Display the game menu
       LEA DX, msg_games_list
       MOV AH, 09H
       INT 21H
       
       call NEW_LINE
       
   START:
   
       ; Prompt user to enter their choice (1 for game, 2 for exit) 
       LEA DX, msg_choice
       MOV AH, 09H
       INT 21H  
       
   
       MOV AH, 01H
       INT 21H
       SUB AL, '0'
       MOV choice, AL  ; Store the user's choice
       
       call NEW_LINE 
       call NEW_LINE
   
       CMP choice, 1
       JE GAME_SEQUENCE ; Jump to the game if choice is 1 
       
       CMP choice, 2
       JE EXIT_GAME  ; Exit the game if choice is 2
   
      
       ; If the choice is invalid, prompt the user again
   
       LEA DX, msg_invalid
       MOV AH, 09H
       INT 21H
       
       
       call NEW_LINE
       call NEW_LINE
         
       LEA DX, msg_stars
       MOV AH, 09H
       INT 21H
       LEA DX, msg_error_stars
       MOV AH, 09H
       INT 21H 
       LEA DX, msg_stars
       MOV AH, 09H
       INT 21H 
       
       call NEW_LINE 
       
       JMP START  ; Loop back to the start if the choice is invalid
       
       
   GAME_SEQUENCE:  
   
      ; Display prompt to choose the correct answer
    
       LEA DX, choose_prompt
       MOV AH, 09H           
       INT 21H
       
       
       ; Start of the game
       MOV AH, 2Ch    ;Get the current time
       INT 21h   ; Call interrupt to get the time
       MOV start_hours, CH
       MOV start_minutes, CL
       MOV start_seconds, DH
       MOV start_ticks, DL 
        
       
       
       MOV current_question, 1  ; Start with the first question 
    
       CALL ASK_QUESTION
       
       JMP GAME_LOOP    ; Loop for answering questions
   
   
   ASK_QUESTION PROC     
       
    ; Compare the current question number and jump to the corresponding question
    
       CMP current_question, 1
       JE QUESTION_1
       CMP current_question, 2
       JE QUESTION_2
       CMP current_question, 3
       JE QUESTION_3
       CMP current_question, 4
       JE QUESTION_4
       CMP current_question, 5
       JE QUESTION_5
       CMP current_question, 6
       JE QUESTION_6
       CMP current_question, 7
       JE QUESTION_7
       CMP current_question, 8
       JE QUESTION_8
       CMP current_question, 9
       JE QUESTION_9
       CMP current_question, 10
       JE QUESTION_10
   
   
   QUESTION_1:
       ; Display the first question and wait for user input
       call NEW_LINE
       
       LEA DX, seq_question1
       MOV AH, 09H
       INT 21H           
       
       call NEW_LINE   
       call NEW_LINE
          
       LEA DX, seq_question1_1
       MOV AH, 09H
       INT 21H
       
       call NEW_LINE       
       
       CALL READ    ; Call to read the user's input
       
       JMP ASK_ANSWER1  ; Check the user's answer
   
   QUESTION_2:
       call NEW_LINE
       
   
       
       LEA DX, seq_question2
       MOV AH, 09H
       INT 21H 
       
       call NEW_LINE
       call NEW_LINE
   
          
       LEA DX, seq_question2_1
       MOV AH, 09H
       INT 21H
       call NEW_LINE
    
       CALL READ
       JMP ASK_ANSWER2
        
   QUESTION_3:
   
      call NEW_LINE
   
       LEA DX, seq_question3
       MOV AH, 09H
       INT 21H  
       
       call NEW_LINE
       call NEW_LINE
   
          
       LEA DX, seq_question3_1
       MOV AH, 09H
       INT 21H
       call NEW_LINE
       
       CALL READ
       JMP ASK_ANSWER3
   
   QUESTION_4: 
      call NEW_LINE
   
       
       LEA DX, seq_question4
       MOV AH, 09H
       INT 21H   
       
       call NEW_LINE
       call NEW_LINE
          
       LEA DX, seq_question4_1
       MOV AH, 09H
       INT 21H
       call NEW_LINE 
       CALL READ
       JMP ASK_ANSWER4
   
   QUESTION_5:
      call NEW_LINE
       
       LEA DX, seq_question5
       MOV AH, 09H
       INT 21H   
       
       call NEW_LINE
       call NEW_LINE
          
       LEA DX, seq_question5_1
       MOV AH, 09H
       INT 21H  
       call NEW_LINE
       
       CALL READ
       JMP ASK_ANSWER5
   
   QUESTION_6:
      call NEW_LINE
       
       LEA DX, seq_question6
       MOV AH, 09H
       INT 21H    
       
       call NEW_LINE
       call NEW_LINE
          
       LEA DX, seq_question6_1
       MOV AH, 09H
       INT 21H
       
       call NEW_LINE 
       
       CALL READ
       JMP ASK_ANSWER6
       
   QUESTION_7:
      call NEW_LINE
       
       LEA DX, seq_question7
       MOV AH, 09H
       INT 21H    
       
       call NEW_LINE
       call NEW_LINE
          
       LEA DX, seq_question7_1
       MOV AH, 09H
       INT 21H
       
       call NEW_LINE 
       
       CALL READ
       JMP ASK_ANSWER7
    
   QUESTION_8:
       call NEW_LINE
       
       LEA DX, seq_question8
       MOV AH, 09H
       INT 21H    
       
       call NEW_LINE
       call NEW_LINE
          
       LEA DX, seq_question8_1
       MOV AH, 09H
       INT 21H
       
       call NEW_LINE 
       
       CALL READ
       JMP ASK_ANSWER8
      
   QUESTION_9:
       call NEW_LINE
       
       LEA DX, seq_question9
       MOV AH, 09H
       INT 21H    
       
       call NEW_LINE
       call NEW_LINE
          
       LEA DX, seq_question9_1
       MOV AH, 09H
       INT 21H
       
       call NEW_LINE 
       
       CALL READ
       JMP ASK_ANSWER9
   
   QUESTION_10:
       call NEW_LINE
       
       LEA DX, seq_question10
       MOV AH, 09H
       INT 21H    
       
       call NEW_LINE
       call NEW_LINE
          
       LEA DX, seq_question10_1
       MOV AH, 09H
       INT 21H
       
       call NEW_LINE 
       
       CALL READ
       JMP ASK_ANSWER10
   
   READ:   
       ; Read the user's input and display it
       call NEW_LINE
       
       MOV AH, 01H
       INT 21H
       MOV user_input, AL ; Store user input
       
       MOV AH, 02H        
       MOV DL, user_input 
       INT 21H     ; Output the user's input to the screen
       RET
       
       
   
   ASK_ANSWER1: 
       ; Compare the answer with the correct one
    
       CMP user_input, 'a'
       JE CORRECT_ANSWER  ; If the answer is correct, jump to CORRECT_ANSWER
       JNE WRONG_ANSWER   ; If wrong, jump to WRONG_ANSWER   
   
   ASK_ANSWER2:
       CMP user_input, 'b'
       JE CORRECT_ANSWER 
       JNE WRONG_ANSWER
       
   
   ASK_ANSWER3:
       CMP user_input, 'a'
       JE CORRECT_ANSWER 
       JNE WRONG_ANSWER
      
   
   ASK_ANSWER4:
       CMP user_input, 'c'
       JE CORRECT_ANSWER
       JNE WRONG_ANSWER   
       
     
   ASK_ANSWER5:
       CMP user_input, 'b'
       JE CORRECT_ANSWER 
       JNE WRONG_ANSWER
     
   
   ASK_ANSWER6:
       CMP user_input, 'a'
       JE CORRECT_ANSWER 
       JNE WRONG_ANSWER
   
   
   ASK_ANSWER7:
       CMP user_input, 'c'
       JE CORRECT_ANSWER
       JNE WRONG_ANSWER
   
      
   ASK_ANSWER8:
       CMP user_input, 'b'
       JE CORRECT_ANSWER
       JNE WRONG_ANSWER
    
   
   ASK_ANSWER9:
       CMP user_input, 'a'
       JE CORRECT_ANSWER 
       JNE WRONG_ANSWER     
       
       
   ASK_ANSWER10:
       CMP user_input, 'b'
       JE CORRECT_ANSWER 
       JNE WRONG_ANSWER
       ;LEA DX, msg_wrong
       ;MOV AH, 09H
       ;INT 21H         
       ;call NEW_LINE  
       ;call NEW_LINE
       ;LEA DX, msg_error_stars
       ;MOV AH, 09H           
       ;INT 21H            
       ;JMP ASK_QUESTION  
        
   WRONG_ANSWER:  
       ; If the answer is wrong, show a failure message and prompt to continue
     
       LEA DX, msg_wrong
       MOV AH, 09H
       INT 21H
        
       call NEW_LINE
       call NEW_LINE 
       
       again:
       LEA DX, msg_line
       MOV AH, 09H
       INT 21H
         
              
       LEA DX, msg_continue
       MOV AH, 09H
       INT 21H   
       
       MOV AH, 01H
       INT 21H 
       MOV continue_choice, AL 
       call NEW_LINE
               
       LEA DX, msg_line
       MOV AH, 09H
       INT 21H       
       
       call NEW_LINE
       
       
       CMP continue_choice,'y'
       JE NEXT_QUESTION             
       CMP continue_choice,'n'
       JE Score 
       call again
   
   CORRECT_ANSWER:
       ; Increment the score and display a success message
       INC points
   
       LEA DX, msg_correct
       MOV AH, 09H
       INT 21H
        
       call NEW_LINE  
       call NEW_LINE 
         
       again1:
       LEA DX, msg_line
       MOV AH, 09H
       INT 21H
                         
       LEA DX, msg_continue
       MOV AH, 09H
       INT 21H   
       
       MOV AH, 01H
       INT 21H 
       MOV continue_choice, AL 
       call NEW_LINE
               
       LEA DX, msg_line
       MOV AH, 09H
       INT 21H
       
                              
       call NEW_LINE
       
                      
       CMP continue_choice,'y' ; If 'y', go to the next question
       JE NEXT_QUESTION             
       CMP continue_choice,'n' ; If 'n', exit the game 
       JE Score
       call again1
       
   Score:   
     ; Show the final score after completing all questions
     MOV AH, 2Ch
     INT 21h
     MOV end_hours, CH
     MOV end_minutes, CL
     MOV end_seconds, DH
     MOV end_ticks, DL 
       
     LEA DX, msg_score
     MOV AH, 09H
     INT 21H
   
     
     MOV AL, points
     ADD AL, '0' ; Convert score to ASCII
     MOV DL, AL
     MOV AH, 02H
     INT 21H
     
     call NEW_LINE 
     
     
     
   
    ; End of the game and calculate the elapsed time
       MOV AH, 2Ch
       INT 21h
       MOV end_hours, CH
       MOV end_minutes, CL
       MOV end_seconds, DH
       MOV end_ticks, DL
   
    ; Calculate the difference in time 
       
       ; First, the difference in tick
       MOV AL, end_ticks
       SUB AL, start_ticks
       JMP continue_time_ticks ;JNS checks if the result of a subtraction is non-negative (SF = 0).
       ;ADD AL, 60
       ;DEC end_minutes
   
   continue_time_ticks:
       MOV end_ticks, AL
   
       ; Second, the difference in seconds
       MOV AL, end_seconds
       SUB AL, start_seconds
       JMP continue_time_seconds
       ;ADD AL, 60
       ;DEC end_minutes
   
   continue_time_seconds:
       MOV end_seconds, AL
   
       ; Third, the difference in minutes
       MOV AL, end_minutes
       SUB AL, start_minutes
       JMP continue_time_minutes
       ;ADD AL, 60
       ;DEC end_hours
   
   continue_time_minutes:
       MOV end_minutes, AL
   
       ; Fourth, the difference in hours
       MOV AL, end_hours
       SUB AL, start_hours
       MOV end_hours, AL
   
       ; Display the elapsed time
       LEA DX, msg_time_elapsed
       MOV AH, 09h
       INT 21h
        
       ; Display hours 
       MOV DL, end_hours
       ADD DL, '0'
       MOV AH, 02h
       INT 21h
       
       ; Display separator between minutes and seconds
       MOV DL, ':'
       MOV AH, 02h
       INT 21h
        
       ; Display minutes
       MOV DL, end_minutes
       ADD DL, '0'
       MOV AH, 02h
       INT 21h
   
       ; Display separator between minutes and seconds
       MOV DL, ':'
       MOV AH, 02h
       INT 21h
   
       ; Display seconds
       MOV DL, end_seconds
       ADD DL, '0'
       MOV AH, 02h
       INT 21h
       
        ; Display separator between minutes and seconds
       MOV DL, ':'
       MOV AH, 02h
       INT 21h
        
       ; Display ticks
       MOV DL, end_ticks
       ADD DL, '0'
       MOV AH, 02h
       INT 21h
        
       call NEW_LINE
       call NEW_LINE
       
       LEA DX, final_stage
       MOV AH, 09H
       INT 21H     
       
       call NEW_LINE  
       
       
       JMP  EXIT_GAME 
     
     
     
   
   NEXT_QUESTION:
       INC current_question
       CMP current_question, 11d  ; If all questions have been answered, show score
       JE Score
       CALL ASK_QUESTION
       JMP GAME_LOOP        ; Repeat for the next question
       ret
   
   GAME_LOOP:
       JMP MAIN
   
   EXIT_GAME:   
       ; Display exit message and terminate the program
   
      LEA DX, msg_exit
      MOV AH, 09H
      INT 21H 
      call NEW_LINE
      call NEW_LINE
      MOV AH, 4CH
      INT 21H 
      
   NEW_LINE PROC NEAR
          LEA DX , NL
          MOV AH,9H
          INT 21H                           
          RET
   NEW_LINE ENDP   
  
END MAIN
 
