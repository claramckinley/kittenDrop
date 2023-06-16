//
//  ViewController.swift
//  KittenDrop
//
//  Created by Clara McKinley on 6/13/23.
//

import UIKit

class ViewController: UIViewController {
    
    var playerKitten: Kitten?

    @IBOutlet weak var orientationLabel: UILabel!

    @IBOutlet weak var whichDirection: UIImageView!
    
    @IBAction func goLeft(_ sender: Any) {
        playerKitten!.spinLeft()
        whichDirection.transform = whichDirection.transform.rotated(by: CGFloat(-(Double.pi / 2)))
        updateDisplay()
    }
    
    @IBAction func goRight(_ sender: Any) {
        playerKitten!.spinRight()
        whichDirection.transform = whichDirection.transform.rotated(by: CGFloat(Double.pi / 2))
        updateDisplay()
        
    }
    
    func updateDisplay() {
        orientationLabel.text = playerKitten!.orientation.rawValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playerKitten = Kitten(color: Kitten.CatColor.grey, size: 1, name: "Momo", orientation: Kitten.Direction.up)
    }


}

