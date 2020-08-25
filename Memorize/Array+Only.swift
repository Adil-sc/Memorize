//
//  Array+Only.swift
//  Memorize
//
//  Created by Adil_SC on 8/22/20.
//  Copyright © 2020 Adil_SC. All rights reserved.
//

import Foundation

extension Array {
    var only: Element?{
        count == 1 ? first : nil
    }
}
