//
//  YOUCGoingButton.swift
//  YOUCEvent
//
//  Created by Richard Absin on 3/10/19.
//  Copyright © 2019 richard.absin24@outlook.com. All rights reserved.
//

import UIKit

class YOUCGoingButton: UIButton {
    var isOn = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        layer.borderWidth = 2.0
        layer.borderColor = Colors.twitterBlue.cgColor
        layer.cornerRadius = frame.size.height / 2
        
        setTitleColor(Colors.twitterBlue, for: .normal)
        addTarget(self, action: #selector(YOUCGoingButton.buttonPressed), for: .touchUpInside)
    }
    
    
    @objc func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    
    func activateButton(bool: Bool) {
        isOn = bool
        
        let color = bool ? Colors.twitterBlue : .clear
        let title = bool ? "Going" : "Go"
        let titleColor = bool ? .white : Colors.twitterBlue
    
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = color
    }

}
