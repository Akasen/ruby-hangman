def guessLetter(chosenWord, guess, previousGuesses)

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
    chosenWord.each_char do |letter|
        if correctGuess.include? letter
            print letter
        else
            print "_"
        end
    end
end

def chooseWord(wordList)
    chosenWord = wordList[rand(wordList.length - 1)]

    if chosenWord.length >= 5 || chosenWord <= 12
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

def update()
end

def start()
    content = File.open('5desk.txt')
    wordList = loadDictionary(content)

    chosenWord = chooseWord(wordList).chomp

    incorrectGuesses = 0

    ##While statement
    previousGuesses = Array.new
    correctGuess = Array.new
    while(true)
        guessOutcome(chosenWord, correctGuess)
        puts ""
        puts "You have made #{incorrectGuesses} incorrect guesses"
        puts "Guess a letter"
        guess = gets.chomp

        #Process user choice
        guessResult = processGuess(chosenWord, guess, previousGuesses)

        case guessResult
        when 0
            puts "Correct Guess"
            correctGuess.push(guess)
        when 1
            puts "Wrong Guess"
            incorrectGuesses += 1
        when 2
            puts "You already guessed that letter"
        end

        if !previousGuesses.include? guess
            previousGuesses.push(guess)
        end
        
        
    end

end


start()