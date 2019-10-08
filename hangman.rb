class GameStats
    attr_accessor :chosenWord, :incorrectGuessTally, :previousGuesses, :correctGuess
    def initialize(chosenWord, incorrectGuessTally, previousGuesses, correctGuess)
        @chosenWord = chosenWord
        @incorrectGuessTally = incorrectGuessTally
        @previousGuesses = previousGuesses
        @correctGuess = correctGuess
        puts "Game Start!!"
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

    if chosenWord.length >= 5 && chosenWord.length <= 12
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

def start()
    content = File.open('5desk.txt')
    wordList = loadDictionary(content)

    #chosenWord = chooseWord(wordList).chomp

    stats = GameStats.new(chooseWord(wordList).chomp.downcase, 0, Array.new, Array.new)

    puts stats.chosenWord
    #incorrectGuessTally = 0

    ##While statement
    #previousGuesses = Array.new
    #correctGuess = Array.new
    winCheck = guessOutcome(stats.chosenWord, stats.correctGuess)

    while(stats.incorrectGuessTally <= 8 && winCheck != false )

        if stats.incorrectGuessTally >= 8
            puts "The word was #{stats.chosenWord}"
        elsif winCheck === false
            puts "You won!"
        end

        puts winCheck

        puts "\nYou have made #{stats.incorrectGuessTally} incorrect guesses"
        puts "Guess a letter"
        guess = gets.chomp.downcase

        #Process user choice
        guessResult = processGuess(stats.chosenWord, guess, stats.previousGuesses)

        case guessResult
        when 0
            puts "Correct Guess"
            stats.correctGuess.push(guess)
        when 1
            puts "Wrong Guess"
            stats.incorrectGuessTally += 1
        when 2
            puts "You already guessed that letter"
        end

        if !stats.previousGuesses.include? guess
            stats.previousGuesses.push(guess)
        end
        
        winCheck = guessOutcome(stats.chosenWord, stats.correctGuess)
        
    end

end

start()