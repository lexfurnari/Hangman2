//
//  ViewController.swift
//  Hangman
//
//  Created by Alexa Furnari, Jacob McDonal and Grace Ebel.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var displayWordLabel: UILabel!
    @IBOutlet weak var wrongLetters: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var hangmanImage: UIImageView!
    
    //Dictionary of words people will try to guess
    // Need to change this to the swift dictionary
    var wordArray = ["RHYTHM", "LUNATIC", "JUICE"]
    
    //Word user is trying to guess
     var targetWord = ""
    
    //Store list of incorrectly guessed letters
    var wrongLettersArray = [Character]()
    
    //Store the letters used in the word. Ex. cat = c, a, t
    var usedLetters = [Character]()
    
    //Originally stores blank lines, lines get replaced with correct guesses
    var displayWordArray = [Character]()
    
    //String displayed for the user to guess
    var displayWord = ""
    
    //Character the user guesses
    var guess: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Randomly choose word from the dictionary to assign to targetWord
        targetWord = wordArray.randomElement()!
        usedLetters = Array(targetWord)
        
        //set displayWord to the right number of blank lines and put into display word label
        //targetWord.count = length of target word
        for letters in 1...targetWord.count {
            displayWord += "_ "
            
            displayWordLabel.text = displayWord     //write in the blank lines where the label is on the screen
            displayWordArray = Array(displayWord)    // turn blank lines into an array, so lines can be replaced
        }
    }
    

    @IBAction func guessButton(_ sender: UIButton) {
        //when user types in guess field the first responder = keyboard
        //when user hits guess button, get rid of keyboard
        guessTextField.resignFirstResponder()
        
        //Make sure the user has entered a character
        // if user types more or less than one character, prompt for a single letter
        
        // make user's guess a constant
        let guess1 = guessTextField.text
        
        if guess1 == "" {
            guessTextField.placeholder = "Enter one character"
        }
        else if guess1!.count > 1 {
            guessTextField.placeholder = "Enter one character"
        }
        else {
            guess = Character(guessTextField.text!.capitalized)
            displayWord = String(displayWordArray) // convert array into string variable
            displayWordLabel.text = displayWord
            guessTextField.text = ""
            checkForWin()
        }
        // Call check
        checkForChar()
    } // end of guessButton function
    
    
    @IBAction func resetButton(_ sender: UIButton) {
        // make everything blank when the game starts
        //Reset the variables, the labels, the images
        guessTextField.text = ""                                         // make text field blank
        hangmanImage.image = UIImage(contentsOfFile:"")                 // make this image empty
        gameImage.image = UIImage(named:"background")              // make this image empty
        wrongLettersArray = []                                        // set wrong letters array to be empty
        wrongLetters.text = ""                                       // make wrongLetters label to be blank
        displayWord = ""                                            //  make displayWord blank
        
        
        //Pick a new random word and display it in the label
        targetWord = wordArray.randomElement()!
        targetWord.forEach{char in
            usedLetters = [Character](arrayLiteral: char)
        }
        
        // calculate the correct number of blank lines needed for the targetWord
        for characters in 1...targetWord.count {
            displayWord += "_"
            displayWordLabel.text = displayWord
            displayWordArray = Array(displayWord) // make displayWord an array of characters 
        }
    } // end reset Button
    
    // Check to see if user's guess is in the word
    func checkForChar() {
        if usedLetters.contains(guess) {
        // place correct guess in the correct position
            for i in 0...targetWord.count - 1 {
                if guess == usedLetters[i] {
                    displayWordArray[i] = guess // put guess in correct position and replace the old blank line
                }
            }
        }
        else {
            // if the guess is wrong, add it to the wrong letters array
            wrongLettersArray.append(guess)
            // Display wrong guesses in wrongLetters label
            wrongLetters.text = String(wrongLettersArray) // converts to string
            
            //start drawing the hangman
            placeImage()
        }
    } // end of checkForChar
        
    func placeImage() {
        let p1 = UIImage(named: "start")
        let p2 = UIImage(named: "pic1")
        let p3 = UIImage(named: "pic2")
        let p4 = UIImage(named: "pic3")
        let p5 = UIImage(named: "pic4")
        let p6 = UIImage(named: "pic5")
        let p7 = UIImage(named: "pic6")
        let p8 = UIImage(named: "pic7")
        
        let imageArray = [p1, p2, p3, p4, p5, p6, p7, p8]
        
        hangmanImage.image = imageArray[wrongLettersArray.count - 1]
    } // end of placeImage
        
    func checkForWin() {
        if displayWord.contains("_") {
            // if there are still blanks, user has not finished guessing all the letters
            guessTextField.text = ""
        }
        else if wrongLettersArray.count == 6 {
            gameImage.image = UIImage(named:"pic7") // game over image goes in quotes after :
        }
        else {
            // User won
            gameImage.image = UIImage(named:"start") // winner image goes in quotes after :
            }
    } // end of checkForWin
                

}
