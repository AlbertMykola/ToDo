//
//  ListCell.swift
//  ToDo
//
//  Created by Albert on 12.05.2020.
//  Copyright © 2020 Albert Mykola. All rights reserved.
//

import UIKit

final class ListCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var dataLabel: UILabel!
    @IBOutlet weak private var statusLabel: UILabel!
    @IBOutlet weak  var myView: UIView!
    
    // MARK: - Functions
     func createdCell(param: Info) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "EEEE, MMM d, yyyy HH:mm"
        let timerFormatter = DateFormatter()
        timerFormatter.dateFormat = "HH:mm"
        nameLabel.text = " \(param.name ?? "")"
        descriptionLabel.text = " \(param.descriptionName ?? "")"
        
        if let date = param.timeTask {
            dataLabel.text = " \(dateFormater.string(from: date))"
        } else {
            dataLabel.text =  "Start of execution: "
        }
        
        if param.status == 0 {
            myView.backgroundColor = #colorLiteral(red: 1, green: 0.3560916472, blue: 0.1288883399, alpha: 1)
            statusLabel.text = "Urgently"
        } else {
            myView.backgroundColor = #colorLiteral(red: 0.4631572478, green: 0.4724809922, blue: 1, alpha: 1)
            statusLabel.text = "Not necessarily"
        }
    }
}
