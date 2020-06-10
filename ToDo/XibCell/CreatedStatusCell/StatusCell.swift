//
//  StatusCell.swift
//  ToDo
//
//  Created by Albert on 11.05.2020.
//  Copyright © 2020 Albert Mykola. All rights reserved.
//

import UIKit

final class StatusCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak public var segmentControl: UISegmentedControl!
    @IBOutlet weak fileprivate var heightConstraint: NSLayoutConstraint!

    override func prepareForReuse() {
        super.prepareForReuse()
        heightConstraint.constant = 0.0
        segmentControl.isHidden = true
    }
    
    // MARK: public function
    public func changeHeight(param: ExpendedCell) {
         if param.expended == false {
             heightConstraint.constant = 0.0
            segmentControl.isHidden = true
            UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.layoutIfNeeded()
                }
         } else {
             heightConstraint.constant = 30.0
            segmentControl.isHidden = false
            UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.layoutIfNeeded()
                }
         }
     }
    
    //MARK: - Action
    @IBAction public func statusAction(_ sender: UISegmentedControl) {
        info.status = sender.selectedSegmentIndex
    }
}


