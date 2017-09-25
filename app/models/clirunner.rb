require "pry"

class CliRunner < InvalidInputError

  def self.start_game
   system "clear"
   puts "Welcome to CLI Othello!!"
   sleep(0.5)
  end

   def self.get_input
     gets.chomp
   end

   def self.start_error
     begin
       raise InvalidInputError
     rescue InvalidInputError => error
       puts error.start_message
     end
     system "clear"
   end

   def self.instructions
     puts "\n"
     puts "Instructions:"
     puts " • Player 1 is assigned the '0' chip"
     puts " • Player 2 is assigned the '1' chip"
     puts " • Players choose an empty square, placing their 'chip' on the board,"
     puts "   adjacent to an opponent's."
     puts " • The chip must flank one or several of his opponent's chips between"
     puts "   the disc played and another disc of his own colour already on the board."
     puts " • All flanked chips then change type"
     puts " • The goal of the game is to have more of your chips on the board than the opponent"
     puts "\n"
     puts "CAUTION: The move that gets you the most chips may not get you the most in the long run"
     puts "\n"
     puts "To make a move, enter an y and x coordinate when prompted."
     puts "\n"
     puts "For example, to place a chip on y:1 x:3 enter: 13"
     puts "\n"
     puts "To see the instructions again. Enter 'instructions' when prompted for your move."
     puts "\n"
     puts "To exit the game after it has begun, type 'done' and hit enter."
     puts "\n"
     puts "If you are unable to make any moves, type 'pass' and hit enter."
     puts "\n"
     puts "To begin, type 'start' and hit enter. Good luck!!"
   end

   def self.show_instructions
     input = ""
     until input == "start"
       self.instructions
       input = self.get_input
       if input != "start"
         self.start_error
       end
     end
     system "clear"
   end

   def self.username_prompt
     puts "please enter your username:"
   end

   def self.get_user(input_username)
     player = Player.retrieve_player(input_username) #Player.retireve_player(input_username)
     if player == nil
       player = Player.add_player(input_username)
     end
     player
   end

   def self.two_player_mode
       print "Player 1 "
       self.username_prompt
       username1 = self.get_input
       player_one = self.get_user(username1)
       player_one.current_chip = 0
       print "Player 2 "
       self.username_prompt
       username2 = self.get_input
       player_two = self.get_user(username2)
       player_two.current_chip = 1
       system "clear"
       Board.new.to_printable_board

       input = ""
       i = 1
       until input == "done"
         valid = false

         while valid != true
           if i.odd?
             current_player = player_one
             puts "#{current_player.username}, please enter your move:"
           else
             current_player = player_two
             puts "#{current_player.username}, please enter your move:"
           end

           input = self.get_input
           if input == "instructions"
             CliRunner.show_instructions
             i -= 1
           end

           break if input == "done" || input == "pass" || input == "skip" || input == "instructions"

           if input[0].scan(/[0-7]{1}/).length != 1 || input[1].scan(/^[a-h]+${1}/).length != 1 || input.length != 2

             begin
               raise InvalidInputError
             rescue InvalidInputError => error
               puts error.move_message
             end
             sleep(1)
             i -= 1
             break
           end

           valid = current_player.make_move(input)

           if valid == nil
             begin
               raise InvalidInputError
             rescue InvalidInputError => error
               puts error.move_message
             end
             sleep(1)
             system "clear"
             Board.last.to_printable_board
           end
         end
         system "clear"
         Board.last.to_printable_board
         i += 1
       end
       system "clear"
   end

   def self.one_player_prompt
     puts "Would you like to be Player 1 (0's) or Player 2 (1's)?"
   end

   def self.one_player_mode #################################################
     choice = ""
     until choice == "1" || choice == "2"
       if choice != "1" && choice != "2"
         self.one_player_prompt
         choice = self.get_input
       else
         choice = choice
       end
     end

     if choice == "1"
       print "Player 1 "
       self.username_prompt
       username1 = self.get_input
       player_one = self.get_user(username1)
       player_one.current_chip = 0

       ### set CPU attribtue
       cpu = CPU.new(current_chip: 1)
     elsif choice == "2"
       print "Player 2 "
       self.username_prompt
       username2 = self.get_input
       player_two = self.get_user(username2)
       player_two.current_chip = 1

       ### set CPU attribute
       cpu = CPU.new(current_chip: 0)
     end

     system "clear"

     Board.new.to_printable_board


     input = ""
     i = 1
     until input == "done"
       valid = false

       while valid != true
         if i.odd?
           current_player = player_one
           puts "#{current_player.username}, please enter your move:"

           input = self.get_input

           if input == "instructions"
             CliRunner.show_instructions
             i -= 1
           end

           break if input == "done" || input == "pass" || input == "skip" || input == "instructions"

           if input[0].scan(/[0-7]{1}/).length != 1 || input[1].scan(/^[a-h]+${1}/).length != 1 || input.length != 2
             begin
               raise InvalidInputError
             rescue InvalidInputError => error
               puts error.input_message
             end
             sleep(1)
             i -= 1
             break
           end

           valid = current_player.make_move(input)

           if valid == nil
             begin
               raise InvalidInputError
             rescue InvalidInputError => error
               puts error.move_message
             end
             sleep(1)
             system "clear"
             Board.last.to_printable_board

           end

         else
           print "CPU is thinking"
           3.times do
             sleep(0.5)
             print "."
           end
           puts "."

           cpu.make_move
           system "clear"
           Board.last.to_printable_board

           i += 1
         end
       end
       system "clear"
       Board.last.to_printable_board
       i += 1
     end
     system "clear"

   end

   def self.mode_prompt
     puts "Would you like to play against a friend or a CPU?"
     sleep(0.5)
     puts "Type '1' or '2' and hit enter to specify the number of humans."
   end

   def self.mode_error
     begin
       raise InvalidInputError
     rescue InvalidInputError => error
       puts error.mode_message
     end
   end

   def self.game_mode
     input = ""
     until input == "1" || input == "2" || input == "old"
       self.mode_prompt
       input = self.get_input
       if input == "1"
         self.one_player_mode
       elsif input == "2"
         self.two_player_mode
       else
         self.mode_error
       end
     end
   end

  CliRunner.start_game
  CliRunner.show_instructions
  CliRunner.game_mode

end
