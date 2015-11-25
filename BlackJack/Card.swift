//
//  Card.swift
//  BlackJack
//
//  Created by 20063321 on 25/11/2015.
//  Copyright © 2015 20063321. All rights reserved.
//

import Foundation

struct Card {
    var suit = "";
    var value = 0;
    init(suitName: String, cardValue : Int){
        suit = suitName
        value = cardValue
    }
}