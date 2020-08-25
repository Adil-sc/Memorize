//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Adil_SC on 8/16/20.
//  Copyright © 2020 Adil_SC. All rights reserved.
//

import Foundation

//This is the ViewModel in MVVM
//Think of the ViewModel as portal to the Model that other Views can look through
class EmojiMemoryGame:ObservableObject {
    var gameTheme = themes.randomElement()!
    
    //This represents the Model. This is what lets the ViewModel talk to the Model. Views can use this like a "Doorway"
    //Published is a property wrapper, which adds additional functionality around property. It calles objectWillChange.send() anytime model changes
    @Published private var model: MemoryGame<String> //= EmojiMemoryGame.createMemoryGame(theme:gameTheme)
    
    init(){
        model = EmojiMemoryGame.createMemoryGame(theme: gameTheme)
    }
    
    //Returns MemoryGame<String> Card with either the Ghost or Pumpkin emoji as the content (string)
    private static func createMemoryGame(theme:Theme) ->MemoryGame<String>{
        //Array is shuffled becase we want a random set of emojies every time we run our game
        let emojis = theme.emojiSet.shuffled()
        
        return MemoryGame<String>(numberOfPairsOfCards: theme.numOfCards!) {(pairIndex: Int) -> String in
            return emojis[pairIndex]
        }
    }
    
    
    //MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func getScore() -> Int{
        return model.score
    }
    
    //MARK: Intents(s)
    func choose(card:MemoryGame<String>.Card){
        model.choose(card:card)
    }
    
    func runGame(){
        gameTheme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: gameTheme)
    }
}
