//
//  MemoryGame.swift
//  Memorize
//
//  Created by Adil_SC on 8/16/20.
//  Copyright © 2020 Adil_SC. All rights reserved.
//

import Foundation

//This is the Modle in MVVM
//Declare a generic type with <>
struct MemoryGame<CardContent> where CardContent: Equatable {
    
    //(set) still allows for read access
    private(set) var cards: Array<Card>
    var score = 0
    
    
    //Make use of computed optional variable to calculate which cards are faceup
    //On get, return the index of the second faceup card
    //On set, turn all cards facedown
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            //Check array of indecies for face up cards and return first face up index if it exists
            return cards.indices.filter({index in cards[index].isFaceUp}).only
        }
        set{
            for index in cards.indices {
                //newValue is special var whcih appears inside set for computed property
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    
    //All functions that modify self, have to be mutating in a struct
    mutating func choose(card:Card){
        //Unwrap the Optional using if let. Will only execute code if cards.firstIndex returns non nil
        //The "," comma is like a sequential && and is used in the case of a if let
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{
            //compare the only face up card, with the next card the user chooses (chosenIndex) to see if its a match
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                
                cards[chosenIndex].seenBefore += 1
                cards[potentialMatchIndex].seenBefore += 1
                
                //This comparison only works becase we make CardContent be Equatable, otherwise, swift would have no way to compare generics
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                }else {
                    //If the card has been flipped before, subtract 1 from the score
                    if cards[chosenIndex].seenBefore > 1 || cards[potentialMatchIndex].seenBefore > 1 {
                        score -= 1
                    }
                    
                }
                //                indexOfTheOneAndOnlyFaceUpCard = nil
                self.cards[chosenIndex].isFaceUp = true
                
                
            }else{
                //                for index in cards.indices {
                //                    cards[index].isFaceUp = false
                //                }
                //This will autoatically set rest of the cards to be facedown by using set()
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            //            self.cards[chosenIndex].isFaceUp = true
        }
        
    }
    
    //Initalize and create the memory game
    //cardContentFactory will return what the type CardContent will be
    init(numberOfPairsOfCards:Int, cardContentFactory:(Int)->CardContent){
        //Calling the Init of Card, to create an empty array of cards
        cards = Array<Card>()
        
        //Create a user defined pair of cards and add them to the cards array
        for pairIndex in 0..<numberOfPairsOfCards{
            //Will use the cardContentFactory param, which is a function, to generate content from the ViewModel
            let content = cardContentFactory(pairIndex)
            cards.append(Card(isFaceUp: false, isMatched: false, content: content, id:pairIndex*2, seenBefore: 0))
            cards.append(Card(isFaceUp: false, isMatched: false, content: content, id:pairIndex*2+1, seenBefore: 0))
            
        }
        
        //shuffle the cards so that they don't appear side by side
        cards = cards.shuffled()
        
    }
    
    //Identifable is called a proptocal. The constraint is that you have to have a var called id
    struct Card:Identifiable {
        var isFaceUp:Bool
        var isMatched:Bool
        //Generic type?
        var content: CardContent
        var id: Int
        var seenBefore:Int
    }
}
