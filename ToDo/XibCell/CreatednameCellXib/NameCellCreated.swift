//
//  NameCellCreated.swift
//  ToDo
//
//  Created by Albert on 11.05.2020.
//  Copyright © 2020 Albert Mykola. All rights reserved.
//

import UIKit

class NameCellCreated: UITableViewCell {
    //MARK: - Outlet
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak private var heightConstraint: NSLayoutConstraint!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heightConstraint.constant = 0.0
    }
    
    // MARK: - Func
    func changeHeight(param: ExpendedCell) {
        if param.expended == false {
            self.heightConstraint.constant = 0.0
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.layoutIfNeeded()
            }
        } else {
            self.heightConstraint.constant = 30.0
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.layoutIfNeeded()
            }
        }
        self.textField.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.textField.layer.shadowRadius = 2.0
        self.textField.layer.shadowOpacity = 0.6
        self.textField.layer.shadowOffset = CGSize(width: 5.0, height: 2.0)
    }
}

