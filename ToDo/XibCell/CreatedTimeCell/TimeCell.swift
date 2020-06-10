//
//  TimeCell.swift
//  ToDo
//
//  Created by Albert on 11.05.2020.
//  Copyright © 2020 Albert Mykola. All rights reserved.
//

import UIKit

final class TimeCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak public var datePicker: UIDatePicker!
    @IBOutlet weak fileprivate var heightConstraint: NSLayoutConstraint!

    //MARK: - Live cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.minimumDate = Date()
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        datePicker.addTarget(self, action: #selector(changedData(param:)), for: .valueChanged)
        heightConstraint.constant = 0.0
    }
    
    //MARK: - Func
    func changeHeight(param: ExpendedCell) {
        if param.expended == false {
            heightConstraint.constant = 0.0
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.layoutIfNeeded()
                }
        } else {
            heightConstraint.constant = 120.0
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.layoutIfNeeded()
            }
        }
    }
    
    @objc func changedData(param: UIDatePicker) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "EEEE, MMM d, yyyy, HH:mm"
        let date = param.date
        info.timeTask =  date
    }
}
