//
//  uiButtonExtension.swift
//  iOS-CalculatorLC
//
//  Created by u633168 on 25/01/2023.
//

import Foundation
import UIKit
extension UIButton{
    //Brilla
    
    func shine() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5
        }) { (completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1
            })
            
        }
    }
}
