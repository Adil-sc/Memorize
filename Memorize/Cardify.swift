//
//  Cardify.swift
//  Memorize
//
//  Created by Adil_SC on 8/24/20.
//  Copyright © 2020 Adil_SC. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier{
    
    var rotation: Double
    
    init(isFaceUp: Bool, gradientColor: Gradient){
        rotation = isFaceUp ? 0: 180
        self.gradientColor = gradientColor
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    
    var gradientColor: Gradient
    
    var animatableData: Double {
        get {return rotation}
        set {rotation = newValue}
    }
    
    //content is always the view we are calling .modifier on
    func body(content: Content) -> some View{
        ZStack {
            
            Group{
                RoundedRectangle(cornerRadius:cornderRadius).fill(AngularGradient(gradient: gradientColor, center: .center))
                RoundedRectangle(cornerRadius:cornderRadius).stroke(lineWidth:edgeLineWidth)
                //The Zstack that was passed into content is displayed here
                content
            }.opacity(isFaceUp ? 1: 0)
            
            
            RoundedRectangle(cornerRadius:cornderRadius).fill().opacity(isFaceUp ? 0 : 1)
            
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
    
    private let cornderRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool, gradientColor: Gradient) -> some View{
        self.modifier(Cardify(isFaceUp: isFaceUp, gradientColor: gradientColor))
    }
}
