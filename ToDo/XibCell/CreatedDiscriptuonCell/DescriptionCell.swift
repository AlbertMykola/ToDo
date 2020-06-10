//
//  DiscriptionCell.swift
//  ToDo
//
//  Created by Albert on 11.05.2020.
//  Copyright © 2020 Albert Mykola. All rights reserved.
//

import UIKit

final class DescriptionCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak private var heightConstraint: NSLayoutConstraint!
    
    //MARK: - Live cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        heightConstraint.constant = 0.0
    }
    
    //MARK - Functions
    func changeHeight(param: ExpendedCell) {
        if param.expended == false {
            heightConstraint.constant = 0.0
            UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.layoutIfNeeded()
                }
        } else {
            heightConstraint.constant = 34.0
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.layoutIfNeeded()
                }
            textField.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            textField.layer.shadowRadius = 2.0
            textField.layer.shadowOpacity = 0.6
            textField.layer.shadowOffset = CGSize(width: 5.0, height: 2.0)
        }
    }
}
