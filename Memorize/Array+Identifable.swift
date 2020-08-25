//
//  ArrayIdentifable.swift
//  Memorize
//
//  Created by Adil_SC on 8/22/20.
//  Copyright © 2020 Adil_SC. All rights reserved.
//

import Foundation

//Add a function to Array which retunrs the index of an item matching an id
//Only Arrays which are Identifiable will see this function
extension Array where Element: Identifiable{
    func firstIndex(matching: Element) -> Int?{
        for index in 0..<self.count {
            if(self[index].id == matching.id){
                return index
            }
        }
        //using the Int? optional is what allows us to return nil
        return nil
    }
}
