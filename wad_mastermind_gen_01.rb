# Ruby code file - All your code should be located between the comments provided.

# Main class module
module OXs_Game
	# Input and output constants processed by subprocesses. MUST NOT change.
	GOES = 12
	COLOURS = "RGBP"

	class Game
		attr_reader :table, :input, :output, :turn, :turnsleft, :winner, :secret, :score, :resulta, :resultb, :guess
		attr_writer :table, :input, :output, :turn, :turnsleft, :winner, :secret, :score, :resulta, :resultb, :guess
		
		def initialize(input, output)
			@input = input
			@output = output
		end
		
		def getguess
			guess = @input.gets.chomp.upcase
		end
		
		# Any code/methods aimed at passing the RSpect tests should be added below.
	
		def start
			@output.puts("Welcome to Mastermind!")
			@output.puts("Created by: #{self.created_by} (#{self.student_id})")
			@output.puts("Starting game...")
			@output.puts('Enter "1" to run the game in the command-line window or "2" to run it in a web browser')
		end
		
		def created_by
			return "Cameron MacDonald"
		end

		def student_id
			return 51663839
		end

		def displaymenu
			@output.puts("Menu: (1) Start | (2) New | (3) Analysis | (9) Exit")
		end

		def clearwinner
			self.winner = 0
		end

		def setturn(turn)
			self.turn = turn
		end

		def setturnsleft(goes)
			self.turnsleft = 12
		end

		def checksecret(secret)
			chars = secret.split("")
			chars.each do |c|
				match = /[[:upper]]/.match(c)
				if !match
					return 0
				end
			end
			return 1
		end

		def gensecret(secret)
			arr = ["R", "G", "B", "P"]
			newS = []
			i = 0
			while i < 4 do
				newS.push(arr[rand(4)])
				i=i+1
			end
			return newS.join
		end

		def setsecret(secret)
			self.secret = secret
		end

		def getsecret
			return self.secret
		end

		def displaysecret
			@output.puts("Secret state: #{self.secret}")
		end

		def cleartable
			self.table = ["____","____","____","____","____","____","____","____","____","____","____","____"]
			self.resulta = []
			self.resultb = []
			self.turn = 0
			self.clearwinner
		end

		def gettableturnvalue(turn)
			return self.table[turn]
		end

		def settableturnvalue(turn, value)
			self.table[turn] = value
			# self.turn = turn
		end

		def displaytable
			@output.puts("TURN | XXXX | SCORE\n===================\n  1. | #{self.table[self.turn]} |\n  2. | ____ |\n  3. | ____ |\n  4. | ____ |\n  5. | ____ |\n  6. | ____ |\n  7. | ____ |\n  8. | ____ |\n  9. | ____ |\n 10. | ____ |\n 11. | ____ |\n 12. | ____ |\n\n")
		end

		def finish
			@output.puts("...finished game")
		end

		def checkresult(turn)
			guess = self.table[turn]
			sArr = self.secret.split("")
			gArr = guess.split("")
			pMatches = 0
			mMatches = 0
			i = 0

			while i < 4 do
				if sArr[i] == gArr[i]
					pMatches = pMatches + 1
					sArr[i] = "-"
					gArr[i] = "-"
				end

				i = i + 1
			end

			i = 0
			j = 0
			if pMatches < 4
				while i < 4 do
					while j < 4 do
						if gArr[i] == sArr[j] && !(gArr[i] == "-" || sArr[j] == "-")
							mMatches = mMatches + 1
							gArr[j] = "-"
							sArr[j] = "-"
						end
						j = j + 1
					end
					i = i + 1
				end
			end

			self.resulta[turn] = pMatches
			self.resultb[turn] = mMatches

			@output.puts("Result #{pMatches}:#{mMatches}")
		end

		def displayanalysis
			turnGuess = Array.new(12, "____")
			turnInfoA = Array.new(12, "")
			turnInfoB = Array.new(12, "")
			(0..11).each do |i|
				if self.table[i] == nil
					break
				end
				turnGuess[i] = self.table[i]
				turnInfoA[i] = self.resulta[i]
				turnInfoB[i] = self.resultb[i]
			end
			@output.puts("TURN | XXXX | SCORE\n===================\n  1. | #{turnGuess[0]} | #{turnInfoA[0]}:#{turnInfoB[0]}\n  2. | #{turnGuess[1]} | #{turnInfoA[1]}:#{turnInfoB[1]}\n  3. | #{turnGuess[2]} | #{turnInfoA[2]}:#{turnInfoB[2]}\n  4. | #{turnGuess[3]} | #{turnInfoA[3]}:#{turnInfoB[3]}\n  5. | #{turnGuess[4]} | #{turnInfoA[4]}:#{turnInfoB[4]}\n  6. | #{turnGuess[5]} | #{turnInfoA[5]}:#{turnInfoB[5]}\n  7. | #{turnGuess[6]} | #{turnInfoA[6]}:#{turnInfoB[6]}\n  8. | #{turnGuess[7]} | #{turnInfoA[7]}:#{turnInfoB[7]}\n  9. | #{turnGuess[8]} | #{turnInfoA[8]}:#{turnInfoB[8]}\n 10. | #{turnGuess[9]} | #{turnInfoA[9]}:#{turnInfoB[9]}\n 11. | #{turnGuess[10]} | #{turnInfoA[10]}:#{turnInfoB[10]}\n 12. | #{turnGuess[11]} | #{turnInfoA[11]}:#{turnInfoB[11]}\n\n")
		end

		def revealtable
			turnGuess = Array.new(12, "____")
			turnInfoA = Array.new(12, "")
			turnInfoB = Array.new(12, "")
			(0..11).each do |i|
				if self.table[i] == nil
					break
				end
				turnGuess[i] = self.table[i]
				turnInfoA[i] = self.resulta[i]
				turnInfoB[i] = self.resultb[i]
			end
			@output.puts("TURN | #{self.secret} | SCORE\n===================\n  1. | #{turnGuess[0]} | #{turnInfoA[0]}:#{turnInfoB[0]}\n  2. | #{turnGuess[1]} | #{turnInfoA[1]}:#{turnInfoB[1]}\n  3. | #{turnGuess[2]} | #{turnInfoA[2]}:#{turnInfoB[2]}\n  4. | #{turnGuess[3]} | #{turnInfoA[3]}:#{turnInfoB[3]}\n  5. | #{turnGuess[4]} | #{turnInfoA[4]}:#{turnInfoB[4]}\n  6. | #{turnGuess[5]} | #{turnInfoA[5]}:#{turnInfoB[5]}\n  7. | #{turnGuess[6]} | #{turnInfoA[6]}:#{turnInfoB[6]}\n  8. | #{turnGuess[7]} | #{turnInfoA[7]}:#{turnInfoB[7]}\n  9. | #{turnGuess[8]} | #{turnInfoA[8]}:#{turnInfoB[8]}\n 10. | #{turnGuess[9]} | #{turnInfoA[9]}:#{turnInfoB[9]}\n 11. | #{turnGuess[10]} | #{turnInfoA[10]}:#{turnInfoB[10]}\n 12. | #{turnGuess[11]} | #{turnInfoA[11]}:#{turnInfoB[11]}\n\n")
		end
		# Any code/methods aimed at passing the RSpect tests should be added above.

	end
end


