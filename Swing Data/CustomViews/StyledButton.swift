//
//  StyledButton.swift
//  Swing Data
//
//  Created by Bryan Malumphy on 9/10/19.
//  Copyright © 2019 Math and Coffee. All rights reserved.
//

import UIKit

class StyledButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        backgroundColor = UIColor(red: 64/255, green: 224/255, blue: 208/255, alpha: 1.0)
        layer.cornerRadius = frame.size.height/2
        setTitleColor(.white, for: .normal)
    }
}
