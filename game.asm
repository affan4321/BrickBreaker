;        									Brick Breaker By Muhammad Affan (21i-0474) and Bilal Ahmad (20i-0730)


Brick STRUCT
	X dw ?
	Y dw ?
	hitCount dw ?
Brick ENDS

EXTERNDELAY = 1
.model small
.stack 101h
.data
	fileName db 'HighScores.txt', 0                                         			; This is the file name, but actual name that it stores is: 'HIGHSCOR.TXT' idk why
	handle dw 0                                                             			; This is the pointer for the file
	fileIntro db '          Score Card'                                     			; This is the first header that I will place in the file
	playerNameinFile db 'Name: '                                            			; This is second information in file
	playerScoreinFile db 'Score: '                                          			; //      third    //    //
	playerLevelinFile db '     Level: '                                     			; //      fourth   //    //
	putEnterinFile dw 10                                                    			; ASCII of enter used to place Enter in file
	alignAfterEnter dw 13                                                   			; To Align after entering a new line in File
	unitScore dw ?                                                          			; Dividing score into unit to show in file
	tenthScore dw ?                                                         			; The tenth part of score //     // 
	scoreCardInfo dw 400 dup (?), '$'                                       			; This is the buffer to actually save all the information of the file
	innerDelay db 0          															; game produces extra delay
	tempYpos dw 20,20,20,20,20,20,20,20,40,40,40,40,40,40,40,60,60,60,60,60,60,60,60    ; These are the Y positions of all the bricks to reset them 
	boundary dw 4            															; This is top and left boundary with a little cutoff for early rebound
	max_height dw 200        															; Collision limits: y_pos-> 0-199
	max_heighta db 200															        ; Just a copy of max height for background changing since it requires an 8-bit register		
	max_width dw 320																	; Collision limits: x_pos-> 0-319
	restartX dw 160                     												; To start over ball from initial X position
	restartY dw 180																		; //      //       //    //    // Y position 
	ballXi dw 160                       												; Initial X position of Ball
	ballYi dw 180                      													; Initial Y position of Ball
	sizeBall dw 5                       												; Size of the Ball
	ballXf dw ?        																	; Final X position of Ball
	ballYf dw ?        																	; Final Y position of Ball
	shadowXi dw ?																		; This is second image of Ball to make it special (initial X position)
	shadowXf dw ?																		; //    //   //    //    //    //    //    //     (final X position)
	shadowYi dw ?																		; //    //   //    //    //    //    //    //     (initial Y position)  
	shadowYf dw ?																		; //    //   //    //    //    //    //    //     (final Y position)
	ballSpeed_X dw 3                   													; Ball speed in X direction
	ballSpeed_Y dw 2                   													; Ball speed in Y direction
	leverXi dw 140                     													; Initial X position of Lever
	leverYi dw 190                     													; Initial Y position of Lever
	restartleverX dw 140																; To start over lever from initial X position
	restartleverY dw 190																; To start over lever from initial Y position
	leverXf dw ?                      													; Final X position of Lever
	leverYf dw ?                     													; Final Y position of Lever
	leverWidth dw 60                  													; Lever width
	leverHeight dw 6                 													; Lever height
	leverSpeed dw 10                  													; Speed of the lever
	lifecount dw 3                    													; Player's life count, beginning with 3
	playerLives db 3            														; Display of lives
	life db 'Lives: ','$'             													; Lives text displayed on screen
	lifecolor db 0ch                   													; determines if it exist or not (0 means Black or empty)
	playerScore dw 0h           														; Player's initial score
	score db 'Score: ','$'            													; Score text displayed on screen
	initialname db 'Enter your Name: ','$'          									; Prompt for User's Name
	playerName db 10 dup(?),'$'                                                         ; Array storing player's name
	mainMenu1 db 'Welcome to Brick Breaker','$'     									; Main menu introduction text
	mainMenu2 db 'By Muhammad Affan, Bilal Ahmad','$'                                   ; //   //   //         //
	mainMenu3 db '21i-0474     20i-0730','$'                                            ; //   //   //         // 
	instructions db 'Use <- OR -> keys to move Lever.	                  Enjoy! ','$'  ; Basic instruction to play the game
	instructionsLevel1 db 'Level 1','$'													; Instruction Screen for Level 1
	instructionsLevel1a db 'Break Bricks and Win!','$'                                  ; //          //      //   //
	instructionsLevel2 db 'Level 2','$'                                                 ; //          //      // Level 2
	instructionsLevel2a db 'More speed but small striker','$'                           ; //          //      //   //
	instructionsLevel2b db 'Hit Yellow Bricks 2x now','$'                               ; //          //      //   //
	instructionsLevel3 db 'Level 3','$'                                                 ; //          //      // Level 3
	instructionsLevel3a db 'Some Bricks are fixed','$'                                  ; //          //      //   //
	instructionsLevel3b db 'Hit Blue Bricks 3x now','$'                                 ; //          //      //   //
	mainMenu4 db '(1) Play Now!','$'													; Main menu option 1
	mainMenu5 db '(2) Goto Scorecard','$'												; //   //    //    2
	exitGameOption db '(3) Exit the Game','$'        									; Option to end the game
	playerLevel db '1 ','$'        														; Player's current level on screen 
	level db 'Lvl: ','$'           														; displays level text on screen
	pausedMessage db 'Game Paused','$'            										; Pause screen message
	pausedMessage2 db '(1) Continue','$'     											; To continue where left off
	pausedMessage3 db '(2) exit','$'            										; Option to end the game
	gameOverMessage db 'Game Over!','$'													; Game over message displayed on screen
	gameOverMessage2 db '(1) Play Again','$'    										; To play again
	gameOverMessage3 db '(3) Exit','$'													; Option to end the game
	win db 'Congratulations! You Won!','$'      										; Win message on screen
	
	brickHeight dw 10																	; Brick height
	brickWidth dw 30																	; Brick Width
	startBrickX dw ?                      												; Used to determine the start of Xpos before drawing
	startBrickY dw ?                      												; Used to determine the start of Ypos before drawing
	endBrickX dw ?                        												; Used to determine the end of Xpos before drawing
	endBrickY dw ?                        												; Used to determine the end of Xpos before drawing
	
	; All the values that I will provide
	; - to print the bricks
	; - Keep in mind that these are the
	;   starting positions of the bricks
	;   (the point from where it starts printing)
	  
	brick1 Brick <5,20,1>
	brick2 Brick <45,20,2>                ; yellow      
	brick3 Brick <85,20,3>                ; blue 
	brick4 Brick <125,20,1>
	brick5 Brick <165,20,2>               ; yellow
	brick6 Brick <205,20,3>               ; blue
	brick7 Brick <245,20,1>
	brick8 Brick <285,20,2>               ; yellow
	
	brick9 Brick <25,40,2>                ; yellow
	brick10 Brick <65,40,3>               ; blue
	brick11 Brick <105,40,1>
	brick12 Brick <145,40,2>              ; yellow
	brick13 Brick <185,40,3>              ; blue 
	brick14 Brick <225,40,1>
	brick15 Brick <265,40,2>              ; yellow
	
	brick16 Brick <5,60,3>                ; blue
	brick17 Brick <45,60,1>
	brick18 Brick <85,60,2>               ; yellow
	brick19 Brick <125,60,3>              ; blue
	brick20 Brick <165,60,1>
	brick21 Brick <205,60,2>              ; yellow
	brick22 Brick <245,60,3>              ; blue
	brick23 Brick <285,60,1>

	boolhit db 0																		; This is just a bool variable that keeps check of being hit by the ball or not
	boollvl2 db 0																		; This is just a bool variable that keeps check of level updation to 2
	boollvl3 db 0																		; This is just a bool variable that keeps check of level updation to 3
	
	
	
.code
	addBrick MACRO Xpos, Ypos, color            										; Receives X, Y coordinates of the Brick along with color and call drawBrick Procedure
		push bx
		push cx
		push dx
		
		mov cx, Xpos
		mov dx, Ypos
		mov bh, 0
		mov bl, color
		call drawBrick
		
		pop dx
		pop cx
		pop bx
	ENDM
	
	eliminateBrick MACRO  Xpos, Ypos													; Receives X, Y coordinates of the Brick along with color and call removeBrick Procedure
		push bx
		push cx
		push dx
		
		
		mov cx, Xpos
		mov dx, Ypos
		call brickBeep
		call removeBrick
		replaceObject Xpos Ypos
		
		pop dx
		pop cx
		pop bx
	ENDM
	
	collisionBricks MACRO Xpos, Ypos, hitCount											; Receives X, Y coordinates of the Brick along with hitcount and call eliminateBrick Procedure
	local nojustskip
	local nothanks
	local killbrick
	local dontDestroy
		push ax
		push bx
		push cx
		push dx
		
		; Checking if the ball has collided with the brick
		; (maxx1 > minx2) && (minx1 < maxx2) && (maxy1 > miny2) && (miny1 < maxy2)
		; (ballXi+sizeBall > Xpos) && (ballXi < Xpos+brickWidth) &&
		;        (ballYi+sizeBall > Ypos) && (ballYi < Ypos+brickHeight)
		
		
		mov ax, ballXi
		add ax, sizeBall       ; ballXi+sizeBall
		
		mov bx, Xpos
		add bx, brickWidth     ; Xpos+brickWidth
		
		mov cx, ballYi
		add cx, sizeBall       ; ballYi+sizeBall
		
		mov dx, Ypos
		add dx, brickHeight     ; Ypos+brickHeight
		
		cmp ax, Xpos
		jl nojustskip
		cmp ballXi, bx
		jg nojustskip
		cmp cx, Ypos
		jl nojustskip
		cmp ballYi, dx
		jg nojustskip
		
		
		mov ax, hitCount
		
		cmp ax, 1																		; If hitcount == 1 then destroy otherwise decrement until it's 1
		jg dontDestroy
		jl nothanks
		jmp killbrick
		
		dontDestroy:
			mov boolhit, 1
			jmp nothanks
		
		killbrick:
			eliminateBrick Xpos Ypos
			mov Ypos, 200
			add playerScore, 1h                       
		nothanks:
		
		neg ballSpeed_Y																	; upon collision, reverses the speed in Y direction
		call levelCal																	; //     //       checks score and player level
		
		nojustskip:
		
		pop dx
		pop cx
		pop bx
		pop ax
	ENDM
	
	drawLifes MACRO color
		push ax
		
		mov al, color
		mov lifecolor, al          														; color means (red or black) -> exist or not
		call displayLives
	
		pop ax
	ENDM
	
	changeBackground MACRO color
		mov ah, 06h                														; service to change background and foreground color
		mov al, 0
		mov cx, 0
		mov dh, max_heighta
		mov dl, max_heighta
		mov bh, color
		int 10h
	ENDM
	
	replaceObject MACRO Xpos, Ypos														; This is bonus activity to replace something whenever brick is eliminated
	local iloop2																		; Draws a crow type bird in it's place
	local iloop4
		push ax
		push bx
		push cx
		push dx
	
		mov cx, Xpos
		add cx, 15           															; Goes to the top center of the brick
		mov dx, Ypos
		mov bx, Ypos
		add bx, brickHeight
		iloop2:                 														; Left
			mov ah, 0Ch
			mov al, 15
		
			int 10h
			inc dx
			dec cx
			cmp dx, bx
			jne iloop2
		
		mov cx, Xpos
		add cx, 15           															; Goes to the top center of the brick
		mov dx, Ypos
		mov bx, Ypos
		add bx, brickHeight
		iloop4:                  														; Right
			mov ah, 0Ch
			mov al, 15
			
			int 10h
			inc dx
			inc cx
			cmp dx, bx
			jne iloop4
		
		
		pop dx
		pop cx
		pop bx
		pop ax
	ENDM

	Main PROC
		mov ax, @data
		mov ds, ax  
		
		call clearPlayerName
		call createFile
		
		i:                               												; i is a loop for new player
		
		call clrScreen
		call initial
		call introMusic
		call mainMenu
		call instructionScreen
		playnow:
		; Prints everything every 1/100th second
		gameLoop:
			
			drawLifes 0ch           													; Macro called with red color
			call ballMovement
			call drawBall
			call leverMovement
			call drawLever
			call inGameUI
			
			.IF(playerLevel == '1')
			
				; Macro name           Xpos       Ypos   Color   hitCount
				addBrick           brick1.X    brick1.Y  13            					; first row
				addBrick   		   brick2.X    brick2.Y  14       
				addBrick   		   brick3.X    brick3.Y  9        
				addBrick   		   brick4.X    brick4.Y  13       
				addBrick   		   brick5.X    brick5.Y  14       
				addBrick   		   brick6.X    brick6.Y  9        
				addBrick   		   brick7.X    brick7.Y  13       
				addBrick   		   brick8.X    brick8.Y  14       
			
				addBrick   		   brick9.X    brick9.Y  14            					; second row
				addBrick   		   brick10.X   brick10.Y  9       
				addBrick   		   brick11.X   brick11.Y  13      
				addBrick   		   brick12.X   brick12.Y  14      
				addBrick   		   brick13.X   brick13.Y  9       
				addBrick   		   brick14.X   brick14.Y  13      
				addBrick   		   brick15.X   brick15.Y  14      
			
				addBrick   		   brick16.X   brick16.Y  9           					; third row
				addBrick   		   brick17.X   brick17.Y  13      
				addBrick   		   brick18.X   brick18.Y  14      
				addBrick   		   brick19.X   brick19.Y  9       
				addBrick   		   brick20.X   brick20.Y  13      
				addBrick   		   brick21.X   brick21.Y  14      
				addBrick   		   brick22.X   brick22.Y  9       
				addBrick           brick23.X   brick23.Y  13      
			
			
				collisionBricks    brick1.X    brick1.Y           1   					; first row
				.IF(boolhit == 1)
					dec brick1.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick2.X    brick2.Y           1
				.IF(boolhit == 1)
					dec brick2.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick3.X    brick3.Y           1
				.IF(boolhit == 1)
					dec brick3.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick4.X    brick4.Y           1
				.IF(boolhit == 1)
					dec brick4.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick5.X    brick5.Y           1
				.IF(boolhit == 1)
					dec brick5.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick6.X    brick6.Y           1
				.IF(boolhit == 1)
					dec brick6.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick7.X    brick7.Y           1
				.IF(boolhit == 1)
					dec brick7.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick8.X    brick8.Y           1            
				.IF(boolhit == 1)
					dec brick8.hitCount
					mov boolhit, 0
				.ENDIF
			
				collisionBricks    brick9.X    brick9.Y           1   					; second row
				.IF(boolhit == 1)
					dec brick9.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick10.X   brick10.Y          1
				.IF(boolhit == 1)
					dec brick10.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick11.X   brick11.Y          1
				.IF(boolhit == 1)
					dec brick11.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick12.X   brick12.Y          1
				.IF(boolhit == 1)
					dec brick12.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick13.X   brick13.Y          1
				.IF(boolhit == 1)
					dec brick13.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick14.X   brick14.Y          1
				.IF(boolhit == 1)
					dec brick14.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick15.X   brick15.Y          1
				.IF(boolhit == 1)
					dec brick15.hitCount
					mov boolhit, 0
				.ENDIF
			
				collisionBricks    brick16.X   brick16.Y          1  					; third row
				.IF(boolhit == 1)
					dec brick16.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick17.X   brick17.Y          1
				.IF(boolhit == 1)
					dec brick17.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick18.X   brick18.Y          1
				.IF(boolhit == 1)
					dec brick18.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick19.X   brick19.Y          1
				.IF(boolhit == 1)
					dec brick19.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick20.X   brick20.Y          1
				.IF(boolhit == 1)
					dec brick20.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick21.X   brick21.Y          1
				.IF(boolhit == 1)
					dec brick21.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick22.X   brick22.Y          1
				.IF(boolhit == 1)
					dec brick22.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick23.X   brick23.Y          1
				.IF(boolhit == 1)
					dec brick23.hitCount
					mov boolhit, 0
				.ENDIF
			
				
			.ELSEIF(playerLevel == '2') 
				
				; Macro name           Xpos       Ypos   Color   hitCount
				addBrick           brick1.X    brick1.Y  14            					; first row
				addBrick   		   brick2.X    brick2.Y  9       
				addBrick   		   brick3.X    brick3.Y  13        
				addBrick   		   brick4.X    brick4.Y  14       
				addBrick   		   brick5.X    brick5.Y  9       
				addBrick   		   brick6.X    brick6.Y  13        
				addBrick   		   brick7.X    brick7.Y  14       
				addBrick   		   brick8.X    brick8.Y  9       
			
				addBrick   		   brick9.X    brick9.Y  13            					; second row
				addBrick   		   brick10.X   brick10.Y  14       
				addBrick   		   brick11.X   brick11.Y  9      
				addBrick   		   brick12.X   brick12.Y  13      
				addBrick   		   brick13.X   brick13.Y  14      
				addBrick   		   brick14.X   brick14.Y  9      
				addBrick   		   brick15.X   brick15.Y  13      
			
				addBrick   		   brick16.X   brick16.Y  14           					; third row
				addBrick   		   brick17.X   brick17.Y  9      
				addBrick   		   brick18.X   brick18.Y  13      
				addBrick   		   brick19.X   brick19.Y  14      
				addBrick   		   brick20.X   brick20.Y  9      
				addBrick   		   brick21.X   brick21.Y  13      
				addBrick   		   brick22.X   brick22.Y  14       
				addBrick           brick23.X   brick23.Y  9     
			
			
				collisionBricks    brick1.X    brick1.Y           brick1.hitCount   	; first row
				.IF(boolhit == 1)
					dec brick1.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick2.X    brick2.Y           brick2.hitCount
				.IF(boolhit == 1)
					dec brick2.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick3.X    brick3.Y           brick3.hitCount
				.IF(boolhit == 1)
					dec brick3.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick4.X    brick4.Y           brick4.hitCount
				.IF(boolhit == 1)
					dec brick4.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick5.X    brick5.Y           brick5.hitCount
				.IF(boolhit == 1)
					dec brick5.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick6.X    brick6.Y           brick6.hitCount
				.IF(boolhit == 1)
					dec brick6.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick7.X    brick7.Y           brick7.hitCount
				.IF(boolhit == 1)
					dec brick7.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick8.X    brick8.Y           brick8.hitCount            
				.IF(boolhit == 1)
					dec brick8.hitCount
					mov boolhit, 0
				.ENDIF
			
				collisionBricks    brick9.X    brick9.Y           brick9.hitCount   	; second row
				.IF(boolhit == 1)
					dec brick9.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick10.X   brick10.Y          brick10.hitCount
				.IF(boolhit == 1)
					dec brick10.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick11.X   brick11.Y          brick11.hitCount
				.IF(boolhit == 1)
					dec brick11.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick12.X   brick12.Y          brick12.hitCount
				.IF(boolhit == 1)
					dec brick12.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick13.X   brick13.Y          brick13.hitCount
				.IF(boolhit == 1)
					dec brick13.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick14.X   brick14.Y          brick14.hitCount
				.IF(boolhit == 1)
					dec brick14.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick15.X   brick15.Y          brick15.hitCount
				.IF(boolhit == 1)
					dec brick15.hitCount
					mov boolhit, 0
				.ENDIF
			
				collisionBricks    brick16.X   brick16.Y          brick16.hitCount  	; third row
				.IF(boolhit == 1)
					dec brick16.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick17.X   brick17.Y          brick17.hitCount
				.IF(boolhit == 1)
					dec brick17.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick18.X   brick18.Y          brick18.hitCount
				.IF(boolhit == 1)
					dec brick18.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick19.X   brick19.Y          brick19.hitCount
				.IF(boolhit == 1)
					dec brick19.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick20.X   brick20.Y          brick20.hitCount
				.IF(boolhit == 1)
					dec brick20.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick21.X   brick21.Y          brick21.hitCount
				.IF(boolhit == 1)
					dec brick21.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick22.X   brick22.Y          brick22.hitCount
				.IF(boolhit == 1)
					dec brick22.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick23.X   brick23.Y          brick23.hitCount
				.IF(boolhit == 1)
					dec brick23.hitCount
					mov boolhit, 0
				.ENDIF
			
			
			.ELSEIF(playerLevel == '3')
			
				; Macro name           Xpos       Ypos   Color   hitCount
				addBrick           brick1.X    brick1.Y  9            					; first row
				addBrick   		   brick2.X    brick2.Y  13       
				addBrick   		   brick3.X    brick3.Y  14        
				addBrick   		   brick4.X    brick4.Y  9       
				addBrick   		   brick5.X    brick5.Y  13       
				addBrick   		   brick6.X    brick6.Y  14        
				addBrick   		   brick7.X    brick7.Y  15    ; -> Fixed       
				addBrick   		   brick8.X    brick8.Y  13       
			
				addBrick   		   brick9.X    brick9.Y  14            					; second row
				addBrick   		   brick10.X   brick10.Y  15   ; -> Fixed       
				addBrick   		   brick11.X   brick11.Y  13      
				addBrick   		   brick12.X   brick12.Y  15   ; -> Fixed      
				addBrick   		   brick13.X   brick13.Y  9       
				addBrick   		   brick14.X   brick14.Y  13      
				addBrick   		   brick15.X   brick15.Y  14      
			
				addBrick   		   brick16.X   brick16.Y  9           					; third row
				addBrick   		   brick17.X   brick17.Y  13      
				addBrick   		   brick18.X   brick18.Y  14      
				addBrick   		   brick19.X   brick19.Y  9       
				addBrick   		   brick20.X   brick20.Y  14      
				addBrick   		   brick21.X   brick21.Y  13      
				addBrick   		   brick22.X   brick22.Y  15   ; -> Fixed       
				addBrick           brick23.X   brick23.Y  14  
			
			
				collisionBricks    brick1.X    brick1.Y           brick1.hitCount   	; first row
				.IF(boolhit == 1)
					dec brick1.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick2.X    brick2.Y           brick2.hitCount
				.IF(boolhit == 1)
					dec brick2.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick3.X    brick3.Y           brick3.hitCount
				.IF(boolhit == 1)
					dec brick3.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick4.X    brick4.Y           brick4.hitCount
				.IF(boolhit == 1)
					dec brick4.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick5.X    brick5.Y           brick5.hitCount
				.IF(boolhit == 1)
					dec brick5.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick6.X    brick6.Y           brick6.hitCount
				.IF(boolhit == 1)
					dec brick6.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick7.X    brick7.Y           brick7.hitCount
				.IF(boolhit == 1)
					dec brick7.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick8.X    brick8.Y           brick8.hitCount            
				.IF(boolhit == 1)
					dec brick8.hitCount
					mov boolhit, 0
				.ENDIF
			
				collisionBricks    brick9.X    brick9.Y           brick9.hitCount   	; second row
				.IF(boolhit == 1)
					dec brick9.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick10.X   brick10.Y          brick10.hitCount
				.IF(boolhit == 1)
					dec brick10.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick11.X   brick11.Y          brick11.hitCount
				.IF(boolhit == 1)
					dec brick11.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick12.X   brick12.Y          brick12.hitCount
				.IF(boolhit == 1)
					dec brick12.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick13.X   brick13.Y          brick13.hitCount
				.IF(boolhit == 1)
					dec brick13.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick14.X   brick14.Y          brick14.hitCount
				.IF(boolhit == 1)
					dec brick14.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick15.X   brick15.Y          brick15.hitCount
				.IF(boolhit == 1)
					dec brick15.hitCount
					mov boolhit, 0
				.ENDIF
			
				collisionBricks    brick16.X   brick16.Y          brick16.hitCount  	; third row
				.IF(boolhit == 1)
					dec brick16.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick17.X   brick17.Y          brick17.hitCount
				.IF(boolhit == 1)
					dec brick17.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick18.X   brick18.Y          brick18.hitCount
				.IF(boolhit == 1)
					dec brick18.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick19.X   brick19.Y          brick19.hitCount
				.IF(boolhit == 1)
					dec brick19.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick20.X   brick20.Y          brick20.hitCount
				.IF(boolhit == 1)
					dec brick20.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick21.X   brick21.Y          brick21.hitCount
				.IF(boolhit == 1)
					dec brick21.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick22.X   brick22.Y          brick22.hitCount
				.IF(boolhit == 1)
					dec brick22.hitCount
					mov boolhit, 0
				.ENDIF
				collisionBricks    brick23.X   brick23.Y          brick23.hitCount
				.IF(boolhit == 1)
					dec brick23.hitCount
					mov boolhit, 0
				.ENDIF
			
			.ENDIF
			
			call ballDelayCal  
			call sleep
			JMP gameLoop
			call Exit
		ret
	Main ENDP
	
	clrScreen PROC
		push ax
		push bx
		push cx
		push dx
		
		mov ah, 00h        																	; set to Video Mode
		mov al, 13h       												    				; choosing video mode
		int 10h
		
		mov ah, 0Bh        																	; set background
		mov bx, 0000h      																	; forground and background both Black
		int 10h
		
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	clrScreen ENDP
	
	ballDelayCal proc 
		inc innerDelay
		cmp innerDelay, EXTERNDELAY
		jne skipDelay 
		mov innerDelay, 0
		call removeBall 
		call removeLever
		;call drawBall
		skipDelay:
		ret
	ballDelayCal endp   
	
	sleep proc

		mov cx, 65535

		l:
			loop l
		ret
	sleep endp
	
	drawBall PROC
		push cx
		push dx
		push bx
		
		mov cx, ballXi
		mov dx, ballYi
		mov bx, cx         																; updating final size in X direction
		add bx, sizeBall
		mov ballXf, bx
		mov bx, dx         																; updating final size in Y direction
		add bx, sizeBall
		mov ballYf, bx
		
		draw_ball_y_position:
			draw_ball_x_position:
				mov ah, 0Ch        														; set to write pixel
				mov al, 0Fh        														; color
				int 10h
				inc cx
				mov bx, ballXf
				cmp cx, bx
				jne draw_ball_x_position
			mov cx, ballXi
			inc dx
			CMP dx, ballYf
			jb draw_ball_y_position
		
		mov cx, ballXi
		mov dx, ballYi
		add cx, 1
		mov shadowXi, cx
		add dx, 1
		mov shadowYi, dx
		mov bx, shadowXi
		add bx, sizeBall
		sub bx, 2
		mov shadowXf, bx
		mov bx, shadowYi
		add bx, sizeBall
		sub bx, 2
		mov shadowYf, bx
		
		mov cx, shadowXi
		mov dx, shadowYi
		draw_ball_y_position2:
			draw_ball_x_position2:
				mov ah, 0Ch       							 							; set to write pixel
				mov al, 0Ch        							 							; color
				int 10h
				inc cx
				mov bx, shadowXf
				cmp cx, bx
				jne draw_ball_x_position2
			mov cx, shadowXi
			inc dx
			CMP dx, shadowYf
			jb draw_ball_y_position2
		
		
		
		pop bx
		pop dx
		pop cx
		ret
	drawBall ENDP
	
	removeBall PROC
		push cx
		push dx
		push bx
		
		mov cx, ballXi
		mov dx, ballYi
		mov bx, cx         																; updating final size in X direction
		add bx, sizeBall
		mov ballXf, bx
		mov bx, dx         																; updating final size in Y direction
		add bx, sizeBall
		mov ballYf, bx
		
		remove_ball_y_position:
			remove_ball_x_position:
				mov ah, 0Ch        														; set to write pixel
				mov al, 0        														; color set to black to remove
				int 10h
				inc cx
				mov bx, ballXf
				cmp cx, bx
				jne remove_ball_x_position
			mov cx, ballXi
			inc dx
			CMP dx, ballYf
			jb remove_ball_y_position
		
		mov cx, ballXi
		mov dx, ballYi
		add cx, 1
		mov shadowXi, cx
		add dx, 1
		mov shadowYi, dx
		mov bx, shadowXi
		add bx, sizeBall
		sub bx, 2
		mov shadowXf, bx
		mov bx, shadowYi
		add bx, sizeBall
		sub bx, 2
		mov shadowYf, bx
		
		mov cx, shadowXi
		mov dx, shadowYi
		remove_ball_y_position2:
			remove_ball_x_position2:
				mov ah, 0Ch        														; set to write pixel
				mov al, 0        														; color set to black to remove
				int 10h
				inc cx
				mov bx, shadowXf
				cmp cx, bx
				jne remove_ball_x_position2
			mov cx, shadowXi
			inc dx
			CMP dx, shadowYf
			jb remove_ball_y_position2
		
		pop bx
		pop dx
		pop cx
		ret
	removeBall ENDP
	
	ballMovement PROC
		push bx
		push dx
		push cx
		
		mov cx, boundary
		
		mov bx, ballSpeed_X       														; initial movement in X direction
		sub ballXi, bx
		
		cmp ballXi, cx          														; left boundary collided
		jb reverseSpeedX
		
		mov bx, max_width         														; right boundary collided
		sub bx, sizeBall
		sub bx, cx
		cmp ballXi, bx
		ja reverseSpeedX
		
		mov dx, ballSpeed_Y      														; initial movement in Y direction
		sub ballYi, dx
		
		cmp ballYi, cx             														; top boundary collided
		jb reverseSpeedY
		
		mov dx, max_height       														; bottom boundary collided
		sub dx, sizeBall
		sub dx, cx
		cmp ballYi, dx
		ja reset               															; restarts whenever ball hits bottom
		
		; Checking if the ball has collided with the lever
		; (maxx1 > minx2) && (minx1 < maxx2) && (maxy1 > miny2) && (miny1 < maxy2)
		; (ballXi+sizeBall > leverXi) && (ballXi < leverXi+leverWidth) &&
		;        (ballYi+sizeBall > leverYi) && (ballYi < leverYi+leverWidth)
		
		mov ax, ballXi
		add ax, sizeBall       ; ballXi+sizeBall
		
		mov bx, leverXi
		add bx, leverWidth     ; leverXi+leverWidth
		
		mov cx, ballYi
		add cx, sizeBall       ; ballYi+sizeBall
		
		mov dx, leverYi
		add dx, leverWidth     ; leverYi+leverWidth
		
		.IF(ax > leverXi && ballXi < bx && cx > leverYi && ballYi < dx)
			jmp reverseSpeedY
		.ENDIF
		
		
		pop cx
		pop dx
		pop bx
		ret
		
		reverseSpeedX:
			neg ballSpeed_X      														; returns the negative value
			pop cx
			pop dx
			pop bx
			ret
		reverseSpeedY:
			neg ballSpeed_Y      														; returns the negative value
			pop cx
			pop dx
			pop bx
			ret
		reset:
			drawLifes 0           														; Macro called with black color
			call lifeCounter
			call lightBeep
			call Restart_Ball_Position
			pop cx
			pop dx
			pop bx
			ret	
	ballMovement ENDP
	
	Restart_Ball_Position PROC
		push ax
		push bx
		push cx
		
		call removeBall
		mov cx, ballYi
		sub cx, ballSpeed_Y
		
		neg ballSpeed_X         														; reverses the previous movement so that it look random
		.IF(cx > ballYi)    															; only reverse the y direction if ball was moving down
			neg ballSpeed_Y
		.ENDIF
		
		mov ax, restartX        														; resets old positions
		mov bx, restartY
		
		mov ballXi, ax
		mov ballYi, bx
	
		pop cx
		pop bx
		pop ax
		ret
	Restart_Ball_Position ENDP
	
	drawLever PROC
		push cx
		push dx
		push bx
		
		mov cx, leverXi
		mov dx, leverYi
		mov bx, cx         																; updating final size in X direction
		add bx, leverWidth
		mov leverXf, bx
		mov bx, dx         																; updating final size in Y direction
		add bx, leverHeight
		mov leverYf, bx
		
		draw_lever_y_position:
			draw_lever_x_position:
				mov ah, 0Ch        														; set to write pixel
				mov al, 0Fh     														; color
				int 10h
				inc cx
				mov bx, leverXf
				cmp cx, bx
				jne draw_lever_x_position
			mov cx, leverXi
			inc dx
			CMP dx, leverYf
			jb draw_lever_y_position
				
		pop bx
		pop dx
		pop cx
		ret
	drawLever ENDP
	
	removeLever PROC
		push cx
		push dx
		push bx
		
		mov cx, leverXi
		mov dx, leverYi
		mov bx, cx         																; updating final size in X direction
		add bx, leverWidth
		mov leverXf, bx
		mov bx, dx         																; updating final size in Y direction
		add bx, leverHeight
		mov leverYf, bx
		
		remove_lever_y_position:
			remove_lever_x_position:
				mov ah, 0Ch        														; set to write pixel
				mov al, 0     															; color set to black to remove
				int 10h
				inc cx
				mov bx, leverXf
				cmp cx, bx
				jne remove_lever_x_position
			mov cx, leverXi
			inc dx
			CMP dx, leverYf
			jb remove_lever_y_position
				
		pop bx
		pop dx
		pop cx
		ret
	removeLever ENDP
	
	leverMovement PROC
		push bx
		push dx
		push cx
		
		mov cx, boundary
		
		mov ah, 01h                														; checks for key press
		int 16h                   														; interupt for keyboard
		
		jz next                  														; no key pressed -> ZF = 1
		
		mov ah, 00h               														; determines which key is pressed
		int 16h
		
		cmp ah, 4bh				  														; checks for left arrow key
		je left

		cmp ah, 4dh			  															; checks for right arrow key
		je right
		
		cmp al, 'p'			  															; checks for p key for pause menu
		je pauseit
		jne next
		
		left:
			mov dx, leverXi
			cmp leverXi, cx      														; Checks for left boundry
			ja skipReboundToRight
			add dx, leverSpeed   	 													; if reached to max left, then rebound occurs
			mov leverXi, dx
			jmp next
			
			skipReboundToRight:
			sub dx, leverSpeed
			mov leverXi, dx       														; Subtract value from lever x position
			jmp next
			
		right:
			mov bx, leverXi        														; using bx for simple movement
			mov dx, leverXi        														; using dx to check lever's right side
			add dx, leverWidth
			cmp dx, max_width       													; Checks for right boundry
			jb skipReboundToLeft
			sub bx, leverSpeed    														; if reached to max right, then rebound occurs
			mov leverXi, bx 
			jmp next
			
			skipReboundToLeft:
			add bx, leverSpeed
			mov leverXi, bx      														; Add value from lever x position
			jmp next
		
		pauseit:
			call pauseScreen
		
		next:
		pop cx 
		pop dx
		pop bx
		ret
	leverMovement ENDP
	
	displayLives PROC
		push ax
		push bx
		push cx
		push dx
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 01h																		; row
		mov dl, 31																		; column
		int 10h
		
		
		mov ah, 9h          															; sets to write string
		lea dx, life       																; displays the lives
		int 21h
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 01h																		; row
		mov dl, 25h																		; column
		int 10h
		
		mov ah, 09h            															; service used to print character at current pointer location
		mov al, playerLives     														; character
		mov bh, 00h            															; page number
		mov bl, lifecolor             													; color
		mov cx, lifecount       														; number of times to print
		int 10h
		
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	displayLives ENDP
	
	inGameUI PROC
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 01h																		; row
		mov dl, 10																		; column
		int 10h
		
		mov ah, 9h          															; sets to write string
		lea dx, playerName       														; displays the player name
		int 21h
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 01h																		; row
		mov dl, 25																		; column
		int 10h
		
		mov ah, 9h          															; sets to write string
		lea dx, level       															; displays the current level message
		int 21h
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 01h																		; row
		mov dl, 29																		; column
		int 10h
		
		mov ah, 9h          															; sets to write string
		lea dx, playerLevel       														; displays the current level
		int 21h
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 01h																		; row
		mov dl, 01h																		; column
		int 10h
		
		mov ah, 9h          															; sets to write string
		lea dx, score       															; displays the score
		int 21h
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 01h																		; row
		mov dl, 07h																		; column
		int 10h
		
		call printmyScore
		ret
	inGameUI ENDP
	
	mainMenu PROC
		call clrScreen
		changeBackground 11100001b
		mainloop:
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 01h																		; row
		mov dl, 07h																		; column
		int 10h
		
		mov ah, 9h          															; sets to write string
		lea dx, mainMenu1       														; displays the message
		int 21h
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 03h																		; row
		mov dl, 03h																		; column
		int 10h
		
		mov ah, 9h          															; sets to write string
		lea dx, mainMenu2       														; displays the message
		int 21h
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 05h																		; row
		mov dl, 07h																		; column
		int 10h
		
		mov ah, 9h          															; sets to write string
		lea dx, mainMenu3      	 														; displays the message
		int 21h
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 10h																		; row
		mov dl, 02h																		; column
		int 10h
		
		mov ah, 9h          															; sets to write string
		lea dx, mainMenu4      															; plays the game
		int 21h
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 12h																		; row
		mov dl, 02h																		; column
		int 10h
		
		mov ah, 9h          															; sets to write string
		lea dx, mainMenu5      															; displays the scorecard
		int 21h
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 14h																		; row
		mov dl, 02h																		; column
		int 10h
		
		mov ah, 9h          															; sets to write string
		lea dx, exitGameOption      													; ends the game
		int 21h
	
		mov ah, 01h                														; checks for key press
		int 16h                   														; interupt for keyboard
		
		jz mainloop                														; no key pressed -> ZF = 1
		
		mov ah, 00h               														; determines which key is pressed
		int 16h
		
		cmp al, '1'				  														; checks for 1 key
		je first

		cmp al, '2'		  		  														; checks for 2 key
		je second
		
		cmp al, '3'               														; checks for 3 key
		je third
		jne mainloop
		
		first:                   														; play now option
			call instructionScreen
			
		second:
			call writeFile
			call readFile
			call scoreCardScreen
			call mainMenu
			
		third:                   														; third option for exiting
			call Exit
		
		ret
	mainMenu ENDP
	
	pauseScreen PROC
		call clrScreen
		changeBackground 11100001b
		mainloop2:
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 01h																		; row
		mov dl, 09h																		; column
		int 10h
		
		mov ah, 9h          															; sets to write string
		lea dx, pausedMessage       													; displays the message
		int 21h
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 06h																		; row
		mov dl, 09h																		; column
		int 10h
		
		mov ah, 9h          															; sets to write string
		lea dx, pausedMessage2       													; displays the message
		int 21h
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 08h																		; row
		mov dl, 09h																		; column
		int 10h
		
		mov ah, 9h          															; sets to write string
		lea dx, pausedMessage3       													; displays the message
		int 21h
		
		mov ah, 01h                														; checks for key press
		int 16h                   														; interupt for keyboard
		
		jz mainloop2                													; no key pressed -> ZF = 1
		
		mov ah, 00h               														; determines which key is pressed
		int 16h
		
		cmp al, '1'				  														; checks for 1 key
		je pausedfirst

		cmp al, '2'		  		  														; checks for 2 key
		je pausedsecond
		jne mainloop2
		
		pausedfirst:                   													; continue
			call clrScreen
			ret
			
		pausedsecond:               													; exit
			call Exit
		ret
	pauseScreen ENDP
	
	gameOverScreen PROC
		call clrScreen
		changeBackground 11100001b
		mainloop3:
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 03h																		; row
		mov dl, 07h																		; column
		int 10h
		
		mov ah, 9h          															; to write string at cursor position
		lea dx, gameOverMessage   														; prints game over message
		int 21h
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 05h																		; row
		mov dl, 07h																		; column
		int 10h
		
		mov ah, 9h          															; to write string at cursor position
		lea dx, gameOverMessage2  														; prints to play again
		int 21h
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 07h																		; row
		mov dl, 07h																		; column
		int 10h
		
		mov ah, 9h          															; to write string at cursor position
		lea dx, mainMenu5   															; Goes to ScoreCard
		int 21h
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 09h																		; row
		mov dl, 07h																		; column
		int 10h
		
		mov ah, 9h          															; to write string at cursor position
		lea dx, gameOverMessage3   														; Goes to exit
		int 21h
		
		mov ah, 01h                														; checks for key press
		int 16h                   														; interupt for keyboard
		
		jz mainloop3                													; no key pressed -> ZF = 1
		
		mov ah, 00h               														; determines which key is pressed
		int 16h
		
		cmp al, '1'				  														; checks for 1 key
		je postplay

		cmp al, '2'		  		  														; checks for 2 key
		je scoreCardAfterGameover
		
		cmp al, '3'
		je exitAfterGameover
		jne mainloop3
		
		postplay:
			call writeFile
			mov lifecount, 3      														; reseting lives 
			mov ballSpeed_X, 3 
			mov ballSpeed_Y, 2
			mov playerScore, 0h   														; reseting score
			mov playerLevel, '1'
			call clearPlayerName  														; to clear the playerName array
			call resetBricks
			call Restart_Ball_Position
			call resetHitCountlvl1
			call resetLeverULTRA
			jmp i                 														; jumps to the very top
		
		scoreCardAfterGameover:
			call writeFile
			call readFile
			call scoreCardScreen
			mov lifecount, 3      														; reseting lives 
			mov ballSpeed_X, 3 
			mov ballSpeed_Y, 2
			mov playerScore, 0h    														; reseting score
			mov playerLevel, '1'
			call clearPlayerName  														; to clear the playerName array
			call resetBricks
			call Restart_Ball_Position
			call resetHitCountlvl1
			call resetLeverULTRA
			jmp i                 														; jumps to the very top
		
		exitAfterGameover:
			call writeFile
			call Exit
		ret
	gameOverScreen ENDP
	
	initial PROC
		call clrScreen
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 07h																		; row
		mov dl, 07h																		; column
		int 10h
		
		mov ah, 9h          															; to write string at cursor position
		lea dx, initialname
		int 21h
		
		; inputs player name
		
		mov si, offset playerName
		myLoop:
			mov ah, 01h           														; service for inputting a character
			int 21h
		
			cmp al, 13            														; waiting for enter key
			je enterpressed
			mov [si], al
			inc si
			jmp myLoop
		
		enterpressed:
		ret
	initial ENDP
	
	instructionScreen PROC
		call clrScreen
		mainloop4:
		
		mov ah, 02h         															; sets the curser position
		mov bh, 00h																		; page number
		mov dh, 07h																		; row
		mov dl, 06h																		; column
		int 10h
		
		mov ah, 9h          															; to write string at cursor position
		lea dx, instructions
		int 21h
		
		mov ah, 01h                														; checks for key press
		int 16h                   														; interupt for keyboard
		
		jz mainloop4               														; no key pressed -> ZF = 1
		
		mov ah, 00h               														; determines which key is pressed
		int 16h
		
		cmp al, 13				  														; checks for Enter key
		je begin
		
		cmp al, 32				  														; checks for Enter key
		je begin
		jne mainloop4
		
		begin:
			call clrScreen
			call leveloneScreen          												; To display level 1 Screen
			jmp playnow
		
		ret
	instructionScreen ENDP
	
	Exit PROC
		mov ah, 4ch
		int 21h
		ret
	Exit ENDP
	
	lifeCounter PROC
		dec lifecount
		.IF(lifecount == 0)
			call mediumBeep
			call highBeep
			call mediumBeep
			call lightBeep
			call highBeep
			call gameOverScreen
		.ENDIF
		ret
	lifeCounter ENDP
	
	brickBeep PROC
        push ax
        push bx
        push cx
        push dx
		
        mov al, 182          															; ready state speaker
        out 43h, al         
        mov ax, 400          															; Frequency number for middle C.  400
        out 42h, al          															; Output LSByte.
        mov al, ah           															; Output HSByte.
        out 42h, al 
        in al, 61h           															; reads from port 61 
        or al, 00000011b     															; Set bits 1 and 0.
        out 61h, al          															; Send new value.
        mov bx, 2            															; Pause for some time.
		p1:
			mov cx, 65535
			p2:
				dec cx
				jne p2
				dec bx
				jne p1
		in al, 61h           															; reads from port 61             
        and al, 11111100b    															; Reset bits 1 and 0.
        out 61h, al          															; Send new value.

		pop dx 
        pop cx
        pop bx
        pop ax

		ret
	brickBeep ENDP
	
	lightBeep PROC
        push ax
        push bx
        push cx
        push dx
		
        mov al, 182          															; ready state speaker
        out 43h, al         
        mov ax, 2000          															; Frequency number for middle C.  400
        out 42h, al          															; Output LSByte.
        mov al, ah           															; Output HSByte.
        out 42h, al 
        in al, 61h           															; reads from port 61 
        or al, 00000011b     															; Set bits 1 and 0.
        out 61h, al          															; Send new value.
        mov bx, 2            															; Pause for some time.
		p1a:
			mov cx, 65535
			p2a:
				dec cx
				jne p2a
				dec bx
				jne p1a
		in al, 61h           															; reads from port 61             
        and al, 11111100b    															; Reset bits 1 and 0.
        out 61h, al          															; Send new value.

		pop dx 
        pop cx
        pop bx
        pop ax

		ret
	lightBeep ENDP
	
	mediumBeep PROC
        push ax
        push bx
        push cx
        push dx
		
        mov al, 182          															; ready state speaker
        out 43h, al         
        mov ax, 4000          															; Frequency number for middle C.  400
        out 42h, al          															; Output LSByte.
        mov al, ah           															; Output HSByte.
        out 42h, al 
        in al, 61h           															; reads from port 61 
        or al, 00000011b     															; Set bits 1 and 0.
        out 61h, al          															; Send new value.
        mov bx, 2            															; Pause for some time.
		p1b:
			mov cx, 65535
			p2b:
				dec cx
				jne p2b
				dec bx
				jne p1b
		in al, 61h           															; reads from port 61             
        and al, 11111100b    															; Reset bits 1 and 0.
        out 61h, al          															; Send new value.

		pop dx 
        pop cx
        pop bx
        pop ax

		ret
	mediumBeep ENDP
	
	highBeep PROC
        push ax
        push bx
        push cx
        push dx
		
        mov al, 182          															; ready state speaker
        out 43h, al         
        mov ax, 7000          															; Frequency number for middle C.  400
        out 42h, al          															; Output LSByte.
        mov al, ah           															; Output HSByte.
        out 42h, al 
        in al, 61h           															; reads from port 61 
        or al, 00000011b     															; Set bits 1 and 0.
        out 61h, al          															; Send new value.
        mov bx, 2            															; Pause for some time.
		p1c:
			mov cx, 65535
			p2c:
				dec cx
				jne p2c
				dec bx
				jne p1c
		in al, 61h           															; reads from port 61             
        and al, 11111100b    															; Reset bits 1 and 0.
        out 61h, al          															; Send new value.

		pop dx 
        pop cx
        pop bx
        pop ax

		ret
	highBeep ENDP
	
	introMusic PROC
		call highBeep
		call highBeep
		call highBeep
		
		call mediumBeep
		call mediumBeep
		call mediumBeep
		
		call highBeep
		call highBeep
		call highBeep
		call highBeep
		call highBeep
		
		call lightBeep
		
		call highBeep
		call highBeep
		call highBeep
		call highBeep
		
		ret
	introMusic ENDP
	
	drawBrick PROC
		push ax
		push bx
		push cx
		push dx
					; cx -> Xpos
					; dx -> Ypos
					; bl -> color
		
		mov startBrickX, cx            													; values saved in variables
		mov startBrickY, dx
		add cx, brickWidth          													; now cx has the final Xpos
		mov endBrickX, cx
		add dx, brickHeight         													; now dx has the final Ypos
		mov endBrickY, dx
		
		
		mov cx, startBrickX         													; reseting initial values for printing
		mov dx, startBrickY
		draw_brick_y_position:
			draw_brick_x_position:
				mov ah, 0Ch         													; set to write pixel
				mov al, bl          													; color
				int 10h
				inc cx
				cmp cx, endBrickX
				jne draw_brick_x_position
			mov cx, startBrickX
			inc dx
			CMP dx, endBrickY
			jb draw_brick_y_position
		
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	drawBrick ENDP
	
	removeBrick PROC
		push ax
		push bx
		push cx
		push dx
					; cx -> Xpos
					; dx -> Ypos
					; bl -> color
		
		mov startBrickX, cx            													; values saved in variables
		mov startBrickY, dx
		add cx, brickWidth          													; now cx has the final Xpos
		mov endBrickX, cx
		add dx, brickHeight         													; now dx has the final Ypos
		mov endBrickY, dx
		
		
		mov cx, startBrickX         													; reseting initial values for printing
		mov dx, startBrickY
		remove_brick_y_position:
			remove_brick_x_position:
				mov ah, 0Ch         													; set to write pixel
				mov al, 0          														; painting black (same as background)
				int 10h
				inc cx
				cmp cx, endBrickX
				jne remove_brick_x_position
			mov cx, startBrickX
			inc dx
			CMP dx, endBrickY
			jb remove_brick_y_position
		
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	removeBrick ENDP
	
	printmyScore proc
		push ax
		push bx
		push cx
		push dx
    
		mov cx, 0
		mov ax, playerScore
		
		.REPEAT
			mov bx, 10
			mov dx, 0
			div bx
			push dx
			inc cx
		.UNTIL(ax == 0)
    
		.REPEAT
			pop dx
			mov ah, 2
			add dl, '0'
			int 21h
			dec cx
		.UNTIL(cx == 0)
		
		pop dx
		pop cx
		pop bx
		pop ax
    
		ret
    printmyScore endp
	
	resetBricks PROC
		push ax
		
		mov si, 0 																			; resetting bricks positions
		mov ax, [tempYpos+si]
		mov brick1.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick2.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick3.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick4.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick5.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick6.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick7.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick8.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick9.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick10.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick11.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick12.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick13.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick14.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick15.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick16.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick17.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick18.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick19.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick20.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick21.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick22.Y, ax
		add si, 2
		mov ax, [tempYpos+si]
		mov brick23.Y, ax
		
		pop ax
		ret
	resetBricks ENDP
	
	winScreen PROC
		push ax 
		
		call clrscreen
		changeBackground 11100001b
		mainloop6:
		mov ah, 02h         																; sets the curser position
		mov bh, 00h																			; page number
		mov dh, 03h																			; row
		mov dl, 7																			; column
		int 10h
		
		mov ah, 9h          																; sets to write string
		lea dx, win       																	; displays the win message
		int 21h
		
		mov ah, 02h         																; sets the curser position
		mov bh, 00h																			; page number
		mov dh, 05h																			; row
		mov dl, 10																			; column
		int 10h
		
		mov ah, 9h          																; sets to write string
		lea dx, gameOverMessage2       														; displays the play again option
		int 21h
		
		mov ah, 02h         																; sets the curser position
		mov bh, 00h																			; page number
		mov dh, 07h																			; row
		mov dl, 10																			; column
		int 10h
		
		mov ah, 9h          																; sets to write string
		lea dx, mainMenu5       															; displays the scorecard
		int 21h
		
		mov ah, 02h         																; sets the curser position
		mov bh, 00h																			; page number
		mov dh, 09h																			; row
		mov dl, 10																			; column
		int 10h
		
		mov ah, 9h          																; sets to write string
		lea dx, gameOverMessage3       														; displays the exit option
		int 21h
	
		mov ah, 01h                															; checks for key press
		int 16h                   															; interupt for keyboard
		
		jz mainloop6                														; no key pressed -> ZF = 1
		
		mov ah, 00h               															; determines which key is pressed
		int 16h
		
		cmp al, '1'				  															; checks for 1 key
		je winfirst

		cmp al, '2'		  		  															; checks for 2 key
		je winsecond
		
		cmp al, '3'               															; checks for 3 key
		je winthird
		jne mainloop6
		
		winfirst:                    														; play now option
			call writeFile
			mov lifecount, 3      															; reseting lives
			mov ballSpeed_X, 3 
			mov ballSpeed_Y, 2
			mov playerScore, 0000h    														; reseting score
			mov playerLevel, '1'
			call clearPlayerName  															; to clear the playerName array
			call resetBricks
			call Restart_Ball_Position
			call resetHitCountlvl1
			call resetLeverULTRA
			jmp i
			
		winsecond:
			call writeFile
			call readFile
			call scoreCardScreen
			mov lifecount, 3      															; reseting lives
			mov ballSpeed_X, 3 
			mov ballSpeed_Y, 2
			mov playerScore, 0000h    														; reseting score
			mov playerLevel, '1'
			call clearPlayerName  															; to clear the playerName array
			call resetBricks
			call Restart_Ball_Position
			call resetHitCountlvl1
			call resetLeverULTRA
			jmp i
			
		winthird:                   														; third option for exiting
			call writeFile
			call Exit
			
		pop ax
		ret
	winScreen ENDP
	
	leveloneScreen PROC
		call clrscreen
		mainloop7:
		mov ah, 02h         																; sets the curser position
		mov bh, 00h																			; page number
		mov dh, 03h																			; row
		mov dl, 7																			; column
		int 10h
		
		mov ah, 9h          																; sets to write string
		lea dx, instructionsLevel1       													; displays the Level
		int 21h
		
		mov ah, 02h         																; sets the curser position
		mov bh, 00h																			; page number
		mov dh, 05h																			; row
		mov dl, 10																			; column
		int 10h
		
		mov ah, 9h          																; sets to write string
		lea dx, instructionsLevel1a       													; displays the instruction
		int 21h
	
		mov ah, 01h                															; checks for key press
		int 16h                   															; interupt for keyboard
		
		jz mainloop7                														; no key pressed -> ZF = 1
		
		mov ah, 00h               															; determines which key is pressed
		int 16h
		
		cmp al, 13			  																; checks for Enter key
		je playlvl1

		cmp al, 32		  		  															; checks for space key
		je playlvl1
		jne mainloop7
		
		playlvl1:                   														; play now option
			call clrScreen
		ret
	leveloneScreen ENDP
	
	leveltwoScreen PROC
		call clrscreen
		mainloop8:
		mov ah, 02h         																; sets the curser position
		mov bh, 00h																			; page number
		mov dh, 03h																			; row
		mov dl, 7																			; column
		int 10h
		
		mov ah, 9h          																; sets to write string
		lea dx, instructionsLevel2       													; displays the Level
		int 21h
		
		mov ah, 02h         																; sets the curser position
		mov bh, 00h																			; page number
		mov dh, 05h																			; row
		mov dl, 10																			; column
		int 10h
		
		mov ah, 9h          																; sets to write string
		lea dx, instructionsLevel2a       													; displays the instruction
		int 21h
		
		mov ah, 02h         																; sets the curser position
		mov bh, 00h																			; page number
		mov dh, 07h																			; row
		mov dl, 10																			; column
		int 10h
		
		mov ah, 9h          																; sets to write string
		lea dx, instructionsLevel2b       													; displays the instruction
		int 21h
	
		mov ah, 00h               															; determines which key is pressed
		int 16h
		
		cmp al, 13			  																; checks for Enter key
		je playlvl2

		cmp al, 32		  		  															; checks for space key
		je playlvl2
		jne mainloop8
		
		playlvl2:                   														; play now option
			call clrScreen
		ret
	leveltwoScreen ENDP
	
	levelthreeScreen PROC
		call clrscreen
		mainloop9:
		mov ah, 02h         																; sets the curser position
		mov bh, 00h																			; page number
		mov dh, 03h																			; row
		mov dl, 7																			; column
		int 10h
		
		mov ah, 9h          																; sets to write string
		lea dx, instructionsLevel3       													; displays the Level
		int 21h
		
		mov ah, 02h         																; sets the curser position
		mov bh, 00h																			; page number
		mov dh, 05h																			; row
		mov dl, 10																			; column
		int 10h
		
		mov ah, 9h          																; sets to write string
		lea dx, instructionsLevel3a       													; displays the instruction
		int 21h
		
		mov ah, 02h         																; sets the curser position
		mov bh, 00h																			; page number
		mov dh, 07h																			; row
		mov dl, 10																			; column
		int 10h
		
		mov ah, 9h          																; sets to write string
		lea dx, instructionsLevel3b       													; displays the instruction
		int 21h
	
		mov ah, 01h                															; checks for key press
		int 16h                   															; interupt for keyboard
		
		jz mainloop9                														; no key pressed -> ZF = 1
		
		mov ah, 00h               															; determines which key is pressed
		int 16h
		
		cmp al, 13			  																; checks for Enter key
		je playlvl3

		cmp al, 32		  		  															; checks for space key
		je playlvl3
		jne mainloop9
		
		playlvl3:                   														; play now option
			call clrScreen
		ret
	levelthreeScreen ENDP
	
	scoreCardScreen PROC
		call clrScreen
		mainloop10:
		mov ah, 02h         																; sets the curser position
		mov bh, 00h																			; page number
		mov dh, 03h																			; row
		mov dl, 7																			; column
		int 10h
		
		
		mov ah, 9h          																; sets to write string
		lea dx, scoreCardInfo       														; displays the score Card
		int 21h
		
		mov ah, 01h                															; checks for key press
		int 16h                   															; interupt for keyboard
		
		jz mainloop10                														; no key pressed -> ZF = 1
		
		mov ah, 00h               															; determines which key is pressed
		int 16h
		
		cmp al, 13				  															; checks for Enter key
		je scoreCardOp1

		cmp al, 32		  		  															; checks for Space key
		je scoreCardOp2
		jne mainloop10
		
		scoreCardOp1:                    													; exits when enter or space pressed
		scoreCardOp2:
		
		call clrScreen
		ret
	scoreCardScreen ENDP
	
	levelCal PROC
		.IF(boollvl2 == 0)
			.IF(playerScore == 23)
				mov leverWidth, 40                											; lever width halfed
				mov ballSpeed_X, 4                
				mov ballSpeed_Y, 3                											; speed increased
				call leveltwoScreen
				inc playerLevel
				mov lifecount, 3                    										; reseting lives
				call resetBricks
				call Restart_Ball_Position
				call resetHitCountlvl2
				call resetLever
				mov boollvl2, 1                   											; so that it runs only once
			.ENDIF
		.ENDIF
		
		.IF(boollvl3 == 0)
			.IF(playerScore == 46)
				mov leverWidth, 40                											; lever width halfed
				mov leverSpeed, 20
				mov ballSpeed_X, 4               
				mov ballSpeed_Y, 5                 											; speed increased
				call levelthreeScreen
				inc playerLevel
				mov lifecount, 3                    										; reseting lives
				call resetBricks
				call Restart_Ball_Position
				call resetHitCountlvl3
				call resetLever
				mov boollvl3, 1                   											; so that it runs only once
			.ENDIF
		.ENDIF
		
		.IF(playerScore == 65)
			call winScreen
		.ENDIF
				
		ret
	levelCal ENDP
	
	clearPlayerName PROC
		mov si, 0
		
		.WHILE(si < lengthof playerName)
			mov [playerName + si], ' '
			inc si
		.ENDW
		mov [playerName + si], '$'
		
		ret
	clearPlayerName ENDP
	
	resetLever PROC
		push ax
		push bx
		
		mov ax, restartleverX
		mov bx, restartleverY
		mov leverXi, ax
		mov leverYi, bx
		
		pop bx
		pop ax
		ret
	resetLever ENDP
	
	resetLeverULTRA PROC
		push ax
		push bx
		
		mov ax, restartleverX
		mov bx, restartleverY
		mov leverXi, ax
		mov leverYi, bx
		mov leverWidth, 60
		mov leverSpeed, 10
		
		pop bx
		pop ax
		ret
	resetLeverULTRA ENDP
	
	resetHitCountlvl1 PROC
		mov brick1.hitCount, 1
		mov brick2.hitCount, 1
		mov brick3.hitCount, 1
		mov brick4.hitCount, 1
		mov brick5.hitCount, 1
		mov brick6.hitCount, 1
		mov brick7.hitCount, 1
		mov brick8.hitCount, 1
		mov brick9.hitCount, 1
		mov brick10.hitCount, 1
		mov brick11.hitCount, 1
		mov brick12.hitCount, 1
		mov brick13.hitCount, 1
		mov brick14.hitCount, 1
		mov brick15.hitCount, 1
		mov brick16.hitCount, 1
		mov brick17.hitCount, 1
		mov brick18.hitCount, 1
		mov brick19.hitCount, 1
		mov brick20.hitCount, 1
		mov brick21.hitCount, 1
		mov brick22.hitCount, 1
		mov brick23.hitCount, 1
		ret
	resetHitCountlvl1 ENDP
	
	resetHitCountlvl2 PROC
		mov brick1.hitCount, 2
		mov brick2.hitCount, 1
		mov brick3.hitCount, 1
		mov brick4.hitCount, 2
		mov brick5.hitCount, 1
		mov brick6.hitCount, 1
		mov brick7.hitCount, 2
		mov brick8.hitCount, 1
		
		mov brick9.hitCount, 1
		mov brick10.hitCount, 2
		mov brick11.hitCount, 1
		mov brick12.hitCount, 1
		mov brick13.hitCount, 2
		mov brick14.hitCount, 1
		mov brick15.hitCount, 1
		
		mov brick16.hitCount, 2
		mov brick17.hitCount, 1
		mov brick18.hitCount, 1
		mov brick19.hitCount, 2
		mov brick20.hitCount, 1
		mov brick21.hitCount, 1
		mov brick22.hitCount, 2
		mov brick23.hitCount, 1
		ret
	resetHitCountlvl2 ENDP
	
	resetHitCountlvl3 PROC
		; These Bricks are fixed
		; last pink row 1   -> Brick 7
	    ; middle yellow row 2   -> Brick 12
	    ; first blue row 2  -> Brick 10
	    ; last blue row 3  -> Brick 22
			   
		mov brick1.hitCount, 3
		mov brick2.hitCount, 1
		mov brick3.hitCount, 2
		mov brick4.hitCount, 3
		mov brick5.hitCount, 1
		mov brick6.hitCount, 2
		mov brick7.hitCount, 65535      ; -> fixed
		mov brick8.hitCount, 1
		
		mov brick9.hitCount, 2
		mov brick10.hitCount, 65535     ; -> fixed
		mov brick11.hitCount, 1
		mov brick12.hitCount, 65535     ; -> fixed
		mov brick13.hitCount, 3
		mov brick14.hitCount, 1
		mov brick15.hitCount, 2
		
		mov brick16.hitCount, 3
		mov brick17.hitCount, 1
		mov brick18.hitCount, 2
		mov brick19.hitCount, 3
		mov brick20.hitCount, 2
		mov brick21.hitCount, 1
		mov brick22.hitCount, 65535     ; -> fixed
		mov brick23.hitCount, 2
		ret
	resetHitCountlvl3 ENDP
	
	closeFile PROC
		mov ah, 3eh             															; service to close a file
		mov bx, handle
		int 21h
		ret
	closeFile ENDP
	
	createFile PROC
		mov ah, 3ch            																; service to create a new file
		mov cl, 2
		mov dx, offset fileName
		int 21h
		mov handle, ax
		
		call closeFile
		ret
	createFile ENDP
	
	writeFile PROC
		push ax
		push bx
		push cx
	
		mov ah, 3dh             															; service to open a file
		mov al, 2               															; opening mode (0 -> read, 1 -> write, 2 -> both)
		mov dx, offset fileName
		int 21h
		mov handle, ax
		
		mov cx, 0               															; to move file pointer to first
		mov dx, 0
		mov ah, 42h
		mov al, 1
		int 21h
		
		; Writing the Header of File
		mov ah, 40h             															; service to write in file
		mov bx, handle
		mov cx, lengthof fileIntro   														; no of bytes to write
		mov dx, offset fileIntro
		int 21h
		
		mov cx, 0               															; to move file pointer to end
		mov dx, 0
		mov ah, 42h
		mov al, 2
		int 21h
		
		;  Enters a new line
		mov ah, 40h             															; service to write in file
		mov bx, handle
		mov cx, 2  																			; no of bytes to write
		mov dx, offset putEnterinFile
		int 21h
		
		;  Aligns after Entered to new line
		mov ah, 40h             															; service to write in file
		mov bx, handle
		mov cx, 2  																			; no of bytes to write
		mov dx, offset alignAfterEnter
		int 21h
		
		;  Enters a new line
		mov ah, 40h             															; service to write in file
		mov bx, handle
		mov cx, 2  																			; no of bytes to write
		mov dx, offset putEnterinFile
		int 21h
		
		;  Aligns after Entered to new line
		mov ah, 40h             															; service to write in file
		mov bx, handle
		mov cx, 2  																			; no of bytes to write
		mov dx, offset alignAfterEnter
		int 21h
		
		;  Puts new Data in it
		; Player Name
		mov ah, 40h             															; service to write in file
		mov bx, handle
		mov cx, lengthof playerNameinFile 													; no of bytes to write
		mov dx, offset playerNameinFile
		int 21h
		
		mov ah, 40h             															; service to write in file
		mov bx, handle
		mov cx, lengthof playerName 														; no of bytes to write
		mov dx, offset playerName
		int 21h
		; Player Score
		mov ah, 40h             															; service to write in file
		mov bx, handle
		mov cx, lengthof playerScoreinFile 													; no of bytes to write
		mov dx, offset playerScoreinFile
		int 21h
		
		; Converting Score
		mov dx, 0
		mov bx, 0
		.IF(playerScore > 9)
			mov ah, 0
			mov ax, playerScore
			mov bx, 10
			div bx
			mov tenthScore, 0      															; reseting tenth Value
			mov unitScore, 0       															; reseting unit Value
			mov tenthScore, ax
			add tenthScore, '0'
			mov unitScore, dx
			add unitScore, '0'
			
		
			mov ah, 40h             														; service to write in file
			mov bx, handle
			mov cx, 1 																		; no of bytes to write
			mov dx, offset tenthScore
			int 21h
		
			mov ah, 40h             														; service to write in file
			mov bx, handle
			mov cx, 1 																		; no of bytes to write
			mov dx, offset unitScore
			int 21h
		.ELSE
			mov ax, playerScore
			mov unitScore, ax
			add unitScore, '0'
			
			mov ah, 40h             														; service to write in file
			mov bx, handle
			mov cx, 2 																		; no of bytes to write
			mov dx, offset unitScore
			int 21h
		.ENDIF
		
		; Player Level
		mov ah, 40h             															; service to write in file
		mov bx, handle
		mov cx, lengthof playerLevelinFile 													; no of bytes to write
		mov dx, offset playerLevelinFile
		int 21h
		
		mov ah, 40h             															; service to write in file
		mov bx, handle
		mov cx, lengthof playerLevel-2 														; no of bytes to write
		mov dx, offset playerLevel
		int 21h

		call closeFile
		pop cx
		pop bx
		pop ax
		ret
	writeFile ENDP
	
	readFile PROC
		mov ah, 3dh             															; service to open a file
		mov dx, offset fileName
		mov al, 2               															; opening mode (0 -> read, 1 -> write, 2 -> both)
		int 21h
		mov handle, ax
		
		mov ah, 3fh            																; service to read in file
		mov bx, handle
		mov cx, 400      																	; no of bytes to read
		mov dx, offset scoreCardInfo
		int 21h
		
		call closeFile
		ret
	readFile ENDP
	
END main

