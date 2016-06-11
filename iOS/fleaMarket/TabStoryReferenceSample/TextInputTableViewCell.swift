//
//  TextInputTableViewCell.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/11.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

class TextInputTableViewCell: UITableViewCell {
   
    @IBOutlet weak var InputTextField: UITextField!
    
    internal func configure( text: String?, placeholder: String) {
        InputTextField.text = text
        InputTextField.placeholder = placeholder
        
        InputTextField.accessibilityValue = text
        InputTextField.accessibilityLabel = placeholder
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
