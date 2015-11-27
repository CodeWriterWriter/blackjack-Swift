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
    enum gameState {
        case Ongoing
        case Finished
    }
    let suits = ["Hearts","Clubs","Spades","Diamonds"]
    var deck: [Card] = []
    var playerHand: [Card] = []
    var playerValue = 0
    var dealerHand: [Card] = []
    var dealerValue = 0
    var currentTurn = turn.PlayerTurn
    var currentGameState = gameState.Ongoing
    
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
        deck.removeAll()
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
        playerValue = value
        playerValueString.text = "Player Value:" + String(value)
        playerCardString.text = hand
    }
    @IBAction func Hit(sender: UIButton) {
        if (currentGameState == gameState.Ongoing){
            if (currentTurn == turn.DealerTurn) {}
            else{
                playerHand.append(draw())
                updatePlayerInfo()
            }
            if (playerValue > 21)
            {
                currentGameState = gameState.Finished
                playerValueString.text = "You lose"
                
            }
        }
        else {
            deckSetUp();
            gameSetUp()
        }
    }
    
    @IBAction func Stay(sender: UIButton) {
        if (currentGameState == gameState.Ongoing){
            if (currentTurn == turn.DealerTurn) {}
            else {
                currentTurn = turn.DealerTurn
                while (dealerValue < 16){
                    dealerHand.append(draw())
                    updateDealerInfo()
                }
                currentGameState = gameState.Finished
                if (((dealerValue > playerValue) && !(dealerValue > 21)) || (playerValue > 21))
                {
                    playerValueString.text = "You lose"
                }
                else if (dealerValue == playerValue)
                {
                    playerValueString.text = "Tied"
                }
                else
                {
                    playerValueString.text = "You win"
                }
            }
        }
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
        dealerValue = value
        dealerValueString.text = "Dealer Value:" + String(value)
        dealerCardString.text = hand
    }
    func gameSetUp(){
        playerValue = 0
        playerHand.removeAll()
        dealerValue = 0
        dealerHand.removeAll()
        currentTurn = turn.PlayerTurn
        currentGameState = gameState.Ongoing
        playerHand.append(draw())
        updatePlayerInfo()
        dealerHand.append(draw())
        updateDealerInfo()
        
    }

}

