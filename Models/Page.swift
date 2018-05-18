//
//  Page.swift
//  WhatWatch
//
//  Created by Angel Rodriguez on 4/1/18.
//  Copyright © 2018 Angel Rodriguez. All rights reserved.
//

import Foundation

class Page {
    
    var index = 1
    
    // Increases value of index to let us get other page items.
    func up() {
        index += 1
    }
    
    // Decreases value of index let us go to previous page
    func down() {
        
        index -= 1
    }
    
    // Resets index value to 1
    func reset() {
        index = 1
    }
    
}
