# Ruby code file - All your code should be located between the comments provided.

# Add any additional gems and global variables here
require 'sinatra'		

# The file where you are to write code to pass the tests must be present in the same folder.
# See http://rspec.codeschool.com/levels/1 for help about RSpec
require "#{File.dirname(__FILE__)}/wad_mastermind_gen_01"

# Main program
module OXs_Game
	@input = STDIN
	@output = STDOUT
	g = Game.new(@input, @output)
	g.cleartable
	playing = true
	input = ""
	menu = ""
	guess = ""
	secret = "XXXX"
	turn = 0
	win = 0
	game = ""

	g.start
	game = @input.gets.chomp
	if game == "1"
		puts "Command line game"
	elsif game == "2"
		puts "Web-based game"
		%`ruby wad_mastermind_gen_01.rb -p $4567 -o $localhost`
	else
		puts "Invalid input! No game selected."
		exit
	end
		
	if game == "1"
		
	# Any code added to command line game should be added below.
	while true do
		g.displaymenu
		choice = @input.gets.chomp
		case choice
		when "1"
			if g.turn == nil || g.turn == 0
				g.turn = 0
				g.cleartable
				g.clearwinner
				newSecret = g.gensecret("RGBP")
				g.setsecret(newSecret)
			end
			while true do
				puts "What is your guess?"
				guess = @input.gets.chomp
				if guess == ""
					break
				end
				g.settableturnvalue(turn, guess)
				g.checkresult(turn)
				if g.resulta[turn] == 4
					puts "Correct, you win!"
					g.finish
					break
				end
				g.turn = g.turn + 1
			end
		when "2"
			g.turn = 0
			g.cleartable
			g.clearwinner
			newSecret = g.gensecret("RGBP")
			g.setsecret(newSecret)
			while true do
				puts "What is your guess?"
				guess = @input.gets.chomp
				if guess == ""
					break
				end
				guess.upcase!
				g.settableturnvalue(g.turn, guess)
				g.checkresult(g.turn)
				@output.puts("\n")
				if g.resulta[g.turn] == 4
					puts "Correct, you win!"
					g.finish
					g.turn = 0
					break
				end
				g.turn = g.turn + 1
				if g.turn == 12
					@output.puts("Turn limit reached, you lose!")
					g.finish
					break
				end
			end
		when "3"
			g.displayanalysis
		when "9"
			puts "Are you sure you want to exit? Y/N"
			input = gets.chomp
			if input.downcase == "y"
				g.revealtable
				exit
			elsif input.downcase == "n"
				next
			else
				puts "Invalid, please type 'Y' for 'Yes' or 'N' for 'No'"
			end
		else
			puts "Invalid input, try again."
		end
	end

		
	# Any code added to command line game should be added above.
		exit
	end
end
	# Does not allow command-line game to run code below relating to web-based version

# End modules

# Sinatra routes

	# Any code added to web-based game should be added below.
	helpers OXs_Game


	get '/' do
		erb :index
	end

	post '/newgame' do
		erb :index
	end

	# Any code added to web-based game should be added above.

# End program