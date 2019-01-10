//
//  ViewController.swift
//  pocopoco
//
//  Created by Naoki Muroya on 2019/01/09.
//  Copyright © 2019 Naoki. All rights reserved.
//

import UIKit
import GoogleMobileAds

class QuizViewController: UIViewController {
    
    var bannerView: GADBannerView!
    
    private var index : Int?
    private var first : String?
    private var second : String?
    private var third : String?
    private var answer : String?
    private var array = ["a", "b", "c"]
    private var answerButtonTag : Int?
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet var answerButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        for button in answerButtons {
            button.isHidden = true
        }
        numberLabel.text = "集中してね！"
        startButton.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        startButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 20.0, bottom: 5.0, right: 20.0)
        startButton.layer.borderWidth = 0.5
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.layer.cornerRadius = 30.0
        startButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        
        
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        startButton.isHidden = true
        for button in answerButtons {
            button.isEnabled = true
        }
        numberLabel.text = "1番目の振動"
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.index = Int.random(in: 0 ..< self.array.count)
            self.generateVibration(self.array[self.index!])
            self.first = self.array[self.index!]
            self.array.remove(at: self.index!)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            self.numberLabel.text = "2番目の振動"
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            self.index = Int.random(in: 0 ..< self.array.count)
            self.generateVibration(self.array[self.index!])
            self.second = self.array[self.index!]
            self.array.remove(at: self.index!)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.0) {
            self.numberLabel.text = "3番目の振動"
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5.0) {
            self.index = Int.random(in: 0 ..< self.array.count)
            self.generateVibration(self.array[self.index!])
            self.third = self.array[self.index!]
            self.array = ["a", "b", "c"]
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6.0) {
            self.numberLabel.text = "この振動は\n何番目の振動でしょう？"
            self.numberLabel.sizeToFit()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 7.0) {
            self.index = Int.random(in: 0 ..< self.array.count)
            self.generateVibration(self.array[self.index!])
            self.answer = self.array[self.index!]
            
            if self.answer == self.first {
                self.answerButtonTag = 0
            } else if self.answer == self.second {
                self.answerButtonTag = 1
            } else if self.answer == self.third {
                self.answerButtonTag = 2
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 8.0) {
            
            for button in self.answerButtons {
                button.isHidden = false
            }
            
        }
    }
    
    @IBAction func answerButtonPressed(_ sender: Any) {
        
        let button : UIButton = sender as! UIButton
        if button.tag == answerButtonTag {
            numberLabel.text = "正解！"
        } else {
            numberLabel.text = "不正解！"
        }
        
        for button in answerButtons {
            button.isHidden = true
        }
        startButton.isHidden = false
        startButton.titleLabel?.text = "もう一度"
        
    }
    
    
    func generateVibration(_ answer : String) {
        
        let generator = UINotificationFeedbackGenerator()
        
        if answer == "a" {
            generator.notificationOccurred(.error)
        } else if answer == "b" {
            generator.notificationOccurred(.success)
        } else if answer == "c" {
            generator.notificationOccurred(.warning)
        }
        
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
}



