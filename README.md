# cli-othello-ruby
Classic Othello built in Ruby using Object-Oriented Design. One- and two-player versions played in the command line.

GitHub: https://github.com/mattgellert/cli-othello-ruby

## Two player version
Players enter coordinates to place their chip (1 or 0). If no chip exists at the respective place in the game board matrix, and then each valid cell surrounding the chosen spot is checked for opposite chips. If opposite chips are flanked in any direction, they change type. Originally, made at Flatiron as a part of our week 3 group project with classmates David Goodman (gooddb67) and Elbin Keeppanasseril (elbincodes).
<img src="https://media.giphy.com/media/3ohs7ZNIMe5FU31s6Q/giphy.gif" height="600px"/>

## One player version
Personal addition with a basic computer player that makes whatever move would give it the greatest lead after two moves, assuming that the human and itself chooses moves that give it the greatest lead.
<img src="https://media.giphy.com/media/xT0xeIf5lXIlgvV4Y0/giphy.gif" height="600px"/>
