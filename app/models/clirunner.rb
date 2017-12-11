class CliRunner < InvalidInputError

  def self.start_game
   system "clear"
   puts "Welcome to CLI Othello!!"
   sleep(0.5)
  end

  def self.mode_error
    begin
      raise InvalidInputError
    rescue InvalidInputError => error
      puts error.mode_message
    end
    sleep(1)
    system "clear"
  end

   def self.move_error
     begin
       raise InvalidInputError
     rescue InvalidInputError => error
       puts error.move_message
     end
     sleep(1)
   end

   def self.start_error
     begin
       raise InvalidInputError
     rescue InvalidInputError => error
       puts error.start_message
     end
     sleep(1)
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
     puts "For example, to place a chip on y:1 x:c enter: 1c"
     puts "\n"
     puts "To see the instructions again. Enter 'instructions' or 'help' when prompted for your move."
     puts "\n"
     puts "To exit the game after it has begun, type 'done' and hit enter."
     puts "\n"
     puts "If you are unable to make any moves, type 'pass' and hit enter."
     puts "\n"
     puts "To begin, type 'start' and hit enter. Good luck!!"
   end

   def self.mode_prompt
     puts "Would you like to play against a friend or a CPU?"
     sleep(0.5)
     puts "Type '1' or '2' and hit enter to specify the number of humans."
   end

   def self.game_mode
     input = ""
     until input == "1" || input == "2"
       self.mode_prompt
       input = self.get_input
       input == "1" ? self.one_player_mode : input == "2" ? self.two_player_mode : self.mode_error
     end
   end

   def self.get_input
     gets.chomp
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

   def self.username_prompt(player_num)
     puts "Player #{player_num} please enter your username:"
   end

   def self.get_user(input_username)
     player = Player.retrieve_player(input_username)
     if player == nil
       player = Player.add_player(input_username)
     end
     player
   end

   def self.activate_player(player_num)
     self.username_prompt(player_num)
     username = self.get_input
     until username != ""
       puts "     Invalid input. Please enter a username to continue."
       sleep(1)
       system "clear"
       self.username_prompt(player_num)
       username = self.get_input
     end
     player = self.get_user(username)
     player.current_chip = player_num - 1
     player
   end

   def self.two_player_mode
       player_one = self.activate_player(1)
       player_two = self.activate_player(2)

       system "clear"
       Board.new.to_printable_board(player_one.username, player_two.username)

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
           if input == "instructions" || input == "help"
             CliRunner.show_instructions
             i -= 1
           end

           break if input == "done" || input == "pass" || input == "skip" || input == "instructions" || input == "help"

           if input == "" || input[0].scan(/[0-7]{1}/).length != 1 || input[1].scan(/^[a-h]+${1}/).length != 1 || input.length != 2
            self.move_error
             i -= 1
             break
           end

           valid = current_player.make_move(input)

           if valid == nil
            self.move_error
             system "clear"
             Board.last.to_printable_board(player_one.username, player_two.username)
           end
         end
         system "clear"
         Board.last.to_printable_board(player_one.username, player_two.username)
         i += 1
       end
       system "clear"
   end

   def self.one_player_prompt
     system "clear"
     puts "Would you like to be Player 1 (0's) or Player 2 (1's)?"
   end

   def self.get_one_player_choice
     choice = ""
     until choice == "1" || choice == "2"
       self.one_player_prompt
       choice = self.get_input
       if choice != "1" && choice != "2"
         system "clear"
         puts "     Invalid input. Please enter '1' or '2' to continue."
         sleep(1)
         system "clear"
         self.one_player_prompt
         choice = self.get_input
       end
     end
     choice
   end

   def self.one_player_mode
     choice = self.get_one_player_choice
     if choice == "1"
       player_one = self.activate_player(1)
       cpu = CPU.new(current_chip: 1)
     elsif choice == "2"
       player_two = self.activate_player(2)
       cpu = CPU.new(current_chip: 0)
     end

     system "clear"
     choice == "1" ? Board.new.to_printable_board(player_one.username, "CPU") : nil
     choice == "2" ? Board.new.to_printable_board("CPU", player_two.username) : nil

     input = ""
     i = choice == "1" ? 1 : 2
     until input == "done"
       valid = false

       while valid != true
         if i.odd?
           current_player = choice == "1" ? player_one : player_two

           puts "#{current_player.username}, please enter your move:"
           input = self.get_input
           if input == "instructions" || input == "help"
             CliRunner.show_instructions
             i -= 1
           end

           break if input == "done" || input == "pass" || input == "skip" || input == "instructions"
           if input == "" || input[0].scan(/[0-7]{1}/).length != 1 || input[1].scan(/^[a-h]+${1}/).length != 1 || input.length != 2
            self.move_error
             i -= 1
             break
           end

           valid = current_player.make_move(input)

           if valid == nil
             self.move_error
             system "clear"
             choice == "1" ? Board.last.to_printable_board(player_one.username, "CPU") : nil
             choice == "2" ? Board.last.to_printable_board("CPU", player_two.username) : nil
           end

         else
           print "CPU is thinking"
           3.times do
             sleep(0.5)
             print "."
           end

           cpu.find_move
           system "clear"
           choice == "1" ? Board.last.to_printable_board(player_one.username, "CPU") : nil
           choice == "2" ? Board.last.to_printable_board("CPU", player_two.username) : nil

           i += 1
         end
       end
       system "clear"
       choice == "1" ? Board.last.to_printable_board(player_one.username, "CPU") : nil
       choice == "2" ? Board.last.to_printable_board("CPU", player_two.username) : nil
       i += 1
     end
     system "clear"

   end

  CliRunner.start_game
  CliRunner.show_instructions
  CliRunner.game_mode

end
