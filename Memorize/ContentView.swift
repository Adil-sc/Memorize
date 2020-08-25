//
//  ContentView.swift
//  Memorize
//
//  Created by Adil_SC on 8/15/20.
//  Copyright © 2020 Adil_SC. All rights reserved.
//

import SwiftUI

//This is the View in MVVM


struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame
    
    //The code below sets up what the view should look like
    var body: some View {
        //Returns another view, but organizes contetns horizontally. Its anoter combiner
        return HStack(content:{
            return ForEach(viewModel.cards, content:{ card in
                CardView(card:card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            })
        })
             .padding()
             .foregroundColor(Color.orange)
            .font( (viewModel.cards.count > 4) ? Font.body : Font.largeTitle)
            .aspectRatio(2/3, contentMode: .fit)
    }
}

struct CardView: View{
    var card: MemoryGame<String>.Card
    
    var body: some View {
         //A Zstack is a struct whcih behaves liek a view. Its a combiner view
       return ZStack(content:{
            if card.isFaceUp{
                RoundedRectangle(cornerRadius:10.0).fill(Color.white)
                RoundedRectangle(cornerRadius:10.0).stroke(lineWidth:3)
                Text(card.content)
            }else{
                RoundedRectangle(cornerRadius:10.0).fill()
            }
                        
        })
    }
}






































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel:EmojiMemoryGame())
    }
}
