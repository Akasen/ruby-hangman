require 'yaml'

class GameStats
    attr_accessor :chosenWord, :incorrectGuessTally, :previousGuesses, :correctGuess
    def initialize(chosenWord, incorrectGuessTally, previousGuesses, correctGuess)
        @chosenWord = chosenWord
        @incorrectGuessTally = incorrectGuessTally
        @previousGuesses = previousGuesses
        @correctGuess = correctGuess
    end

    def to_yaml
        YAML.dump ({
          :chosenWord => @chosenWord,
          :incorrectGuessTally => @incorrectGuessTally,
          :previousGuesses => previousGuesses,
          :correctGuess => @correctGuess
        })
    end
end

def processGuess(chosenWord, guess, previousGuesses)

    if previousGuesses.include? guess
        return 2
    end

    if chosenWord.include? guess
        return 0
    else
        return 1
    end
end

def guessOutcome(chosenWord, correctGuess)
    winCheck = Array.new
    chosenWord.each_char do |letter|
        if correctGuess.include? letter
            print letter
            winCheck.push(true)
        else
            print "_"
            winCheck.push(false)
        end
    end
    #puts winCheck.include? false
    return (winCheck.include? false)
end

def chooseWord(wordList)
    chosenWord = wordList[rand(wordList.length - 1)]

    puts "The word chosen was #{chosenWord}"
    if(chosenWord.length > 6 && chosenWord.length < 12)
        return chosenWord
    else
        chooseWord(wordList)
    end
end

def loadDictionary(txtContent)
    wordList = Array.new
    txtContent.each {|dictionaryTerms| wordList.push(dictionaryTerms)}
    return wordList
end

=begin
def getUserInput()
    userInput = gets.chomp.downcase

    if userInput.length == 1
        return userInput
    elsif userInput == "help"
        puts "You are playing Hangman"
        return 
    elsif userInput == "save"
        puts "save not functioning"
    elsif userInput == "load"
        puts "load not functioning"
    elsif userInput.length > 1
        puts "You have put an invalid input"
    end
end
=end

def start()
    puts "\e[H\e[2J"
    content = File.open('5desk.txt')
    wordList = loadDictionary(content)

    stats = GameStats.new(chooseWord(wordList).chomp.downcase, 0, Array.new, Array.new)
    
    winCheck = guessOutcome(stats.chosenWord, stats.correctGuess)
    
    while(stats.incorrectGuessTally < 8 && winCheck != false )
        puts "\n\nYou have made #{stats.incorrectGuessTally} incorrect guesses"
        puts "\n\nGuess a letter"
        
        guess = gets.chomp.downcase
        #guess = getUserInput()

        #Process user choice
        guessResult = processGuess(stats.chosenWord, guess, stats.previousGuesses)

        puts "\e[H\e[2J"
        case guessResult
        when 0
            puts "\nCorrect Guess"
            stats.correctGuess.push(guess)
        when 1
            puts "\nWrong Guess"
            stats.incorrectGuessTally += 1
        when 2
            puts "\nYou already guessed that letter"
        end

        if !stats.previousGuesses.include? guess
            stats.previousGuesses.push(guess)
        end
        
        winCheck = guessOutcome(stats.chosenWord, stats.correctGuess)
        
    end
    
    if stats.incorrectGuessTally >= 8
        puts "\n\nThe word was #{stats.chosenWord}"
    elsif winCheck === false
        puts "\n\nYou won!"
    end
    ##TST
end

start()