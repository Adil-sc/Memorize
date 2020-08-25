//
//  Themes.swift
//  Memorize
//
//  Created by Adil_SC on 8/23/20.
//  Copyright © 2020 Adil_SC. All rights reserved.
//

import SwiftUI

struct Theme {
    var name: String
    var emojiSet: Array<String>
    var color: Color
    var gradient: Gradient
    var numOfCards: Int?
}

let themes: [Theme] = [
    Theme(name:"Sports",emojiSet: ["⚽️","🏀","🏸","🏎","🏈","🎾"], color:Color.orange,gradient:Gradient(colors:[.white,.orange, .yellow]),  numOfCards: 6 ),
    Theme(name:"Numbers",emojiSet: ["1️⃣","2️⃣","3️⃣","4️⃣","5️⃣","6️⃣","7️⃣","8️⃣"], color:Color.orange,gradient: Gradient(colors:[.white,.blue,.gray]), numOfCards: 8 ),
    Theme(name:"Numbers",emojiSet: ["👻","🎃", "🎩", "🔥", "🧙‍♂️","🥳","🤖","🦁","🎮","🌓","🐳","☄️"], color:Color.orange,gradient:  Gradient(colors:[.white,.orange,.yellow]), numOfCards: 12 )
]

