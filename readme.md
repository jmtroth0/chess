## Ruby Chess

Command line version of the game written in Ruby

### Computer player AI
  - Customizable level
  - Determines moves based on a search of a tree of potential moves
  - Best move adjudicated by assigned points for piece taking or game goals

  > [Computer Player][computer-player]


### Class Inheritance
  - Utilizes multiple levels to describe piece movement
  - Keeps code DRY

  > [Piece Inheritance][piece-inheritance]

## To Play
  > Clone the repository
  > Navigate to the folder
  > Bundle install to make sure you have the gems necessary
  > Run 'ruby lib/game.rb' to start the game.
  > First choose if you will play as white.
  > Then determine the skill level of the computer.
  > Finally, input plays in the format 'a1 b2'.

[computer-player]: ./lib/players/computer_player.rb
[piece-inheritance]: ./lib/pieces
