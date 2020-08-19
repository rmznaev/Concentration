//
//  ViewController.swift
//  Concentration
//
//  Created by Ramazan Abdullayev on 8/9/20.
//  Copyright © 2020 Ramazan Abdullayev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2) 
    
    var emoji = [Int: String]()

    var emojiChoices = ["👻", "🎃", "🐒", "👟", "🤑", "🐝", "🌹", "🌙", "❄️"]
    
    var flipCount = 0 {
        didSet {
            flipCounLabel.text = "Flips: \(flipCount )"
        }
    }
    
    @IBOutlet weak var flipCounLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        if let cardNumber = cardButtons.firstIndex(of: sender) {
//            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 0) : #colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 1)
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil {
            if emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        }
        
        return emoji[card.identifier] ?? "?"
    }
}
