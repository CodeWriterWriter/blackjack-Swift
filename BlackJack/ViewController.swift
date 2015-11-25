//
//  ViewController.swift
//  BlackJack
//
//  Created by 20063321 on 25/11/2015.
//  Copyright © 2015 20063321. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var playerValueString: UILabel!
    @IBOutlet weak var dealerValueString: UILabel!
    @IBOutlet weak var dealerCardString: UITextField!
    @IBOutlet weak var stayButton: UIButton!
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var playerCardString: UITextField!
    enum turn {
        case PlayerTurn
        case DealerTurn
    }
    let suits = ["Hearts","Clubs","Spades","Diamonds"]
    var deck: [Card] = []
    var playerHand: [Card] = []
    var dealerHand: [Card] = []
    var currentTurn = turn.PlayerTurn
    
    func shuffle (var array: [Card]) ->  [Card]{
            for var i = array.count-1; i > 0 ; i-- {
                let j = Int(arc4random_uniform(UInt32(i-1)))
                swap(&array[i], &array[j])
            }
        return array
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        deckSetUp()
        gameSetUp()
    }
    
    func deckSetUp(){
        for suit in suits{
            for var i = 1; i < 14; i++ {
                deck.append(Card(suitName: suit, cardValue: i))
            }
        }
        deck = shuffle(deck)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func draw() -> Card {
        return deck.removeLast()
    }
    
    func updatePlayerInfo(){
        var value = 0
        var hand = ""
        for card in playerHand {
            if (card.value > 10){
                value += 10
            }
            else {
                value += card.value
            }
            var temp = ""
            if (card.value > 10)
            {
                if (card.value == 11){
                    temp = "Jack"
                }
                else if (card.value == 12){
                    temp = "Queen"
                }
                else if (card.value == 13){
                    temp = "King"
                }
                hand += card.suit + ": " + temp + " "
            }
            else {
                hand += card.suit + ": " + String(card.value) + " "
            }
        }
        playerValueString.text = "Player Value:" + String(value)
        playerCardString.text = hand
    }
    
    func updateDealerInfo(){
        var value = 0
        var hand = ""
        for card in dealerHand {
            if (card.value > 10){
                value += 10
            }
            else {
                value += card.value
            }
            var temp = ""
            if (card.value > 10)
            {
                if (card.value == 11){
                    temp = "Jack"
                }
                else if (card.value == 12){
                    temp = "Queen"
                }
                else if (card.value == 13){
                    temp = "King"
                }
                hand += card.suit + ": " + temp + " "
            }
            else {
                hand += card.suit + ": " + String(card.value) + " "
            }
        }
        dealerValueString.text = "Dealer Value:" + String(value)
        dealerCardString.text = hand
    }
    func gameSetUp(){
        playerHand.append(draw())
        updatePlayerInfo()
        dealerHand.append(draw())
        updateDealerInfo()
        
    }

}

