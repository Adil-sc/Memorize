//
//  Grid.swift
//  Memorize
//
//  Created by Adil_SC on 8/22/20.
//  Copyright © 2020 Adil_SC. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView:View {
    
    private var items:[Item]
    private var viewForItem: (Item) ->ItemView
    
    //We use @escaping to indicat that the (item)->ItemView function
    //is going to escap from this init without being called. This is becase
    //we are going to call it later and are just storing it in viewForItem right now
    init( items:[Item], viewForItem: @escaping (Item)->ItemView){
        self.items = items
        self.viewForItem = viewForItem
    }
    
    
    var body: some View {
        //Find out how much space has beel allocated to us for the grid
        //We will then hand off that info to viewForItem for loop for positioning
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
        
    }
    
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    private func body(for item:Item, in layout: GridLayout) -> some View{
        let index = items.firstIndex(matching: item)
        //Group takes a viewbuilder, its like a Zstack. It will return a Group, which is some View, with empty content
        //We do this becase body expects to return a view, but we have a contitional "if index != nil" statement
        //which would not have retunred a view at all times
        return Group {
            if index != nil {
                viewForItem(item)
                    .frame(width:layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index!))
            }
        }
    }
}
