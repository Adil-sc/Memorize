//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Adil_SC on 8/15/20.
//  Copyright © 2020 Adil_SC. All rights reserved.
//

import SwiftUI

//This is the View in MVVM
struct EmojiMemoryGameView: View {
    //ObservedObject tells app that var viewModel has an ObbervableObject in it. Anytime we call objectWillChange.send(), it redraws view
    @ObservedObject var viewModel: EmojiMemoryGame
    
    //The code below sets up what the view should look like
    var body: some View {
        NavigationView{
            return VStack(content:{
                //Returns another view, but organizes contetns horizontally. Its anoter combiner
                return Grid(items:viewModel.cards,viewForItem: { card in
                    CardView(card:card, gradientColor: self.viewModel.gameTheme.gradient).onTapGesture {
                        withAnimation(.linear(duration: 0.75)){
                            self.viewModel.choose(card: card)
                        }
                        
                    }
                    .padding(5)
                })
                    .padding()
                    .foregroundColor(Color.orange)
                    .aspectRatio(2/3, contentMode: .fit)
            })
                .navigationBarTitle(Text("Score: \(viewModel.getScore())"))
                .navigationBarItems(trailing:
                    
                    
                    Button("New Game"){
                        //explicit animation
                        withAnimation(Animation.easeInOut) {
                            self.viewModel.runGame()
                        }
                        
                    }
            )
        }
        
    }
}

struct CardView: View{
    var card: MemoryGame<String>.Card
    
    let gradientColor: Gradient
    
    var body: some View {
        
        GeometryReader(content:{ geometry in
            self.body(for: geometry.size)
        })
    }
    
    
    //By using ViewBuilder, we return a list of views. It will either be the Zstack, or an empty view
    @ViewBuilder
    private func body(for size:CGSize) -> some View {
        
        if card.isFaceUp || !card.isMatched{
            //A Zstack is a struct whcih behaves liek a view. Its a combiner view
            ZStack(content:{
                Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(110 - 90), clockwise: true).padding(5).opacity(0.4)
                Text(self.card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false): .default)
            })
                .cardify(isFaceUp: card.isFaceUp, gradientColor: gradientColor)
                .transition(AnyTransition.scale)
        }
        
    }
    
    //MARK: - Drawing constatns
    
    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.70
    }
}






































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel:EmojiMemoryGame())
    }
}
