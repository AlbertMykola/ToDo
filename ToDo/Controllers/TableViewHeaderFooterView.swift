//
//  TableViewHeaderFooterView.swift
//  ToDo
//
//  Created by Albert on 11.05.2020.
//  Copyright © 2020 Albert Mykola. All rights reserved.
//

import UIKit

protocol ExpendableHeaderViewDelegate {
    func togleSections(header: TableViewHeaderFooterView, section: Int)
}

class TableViewHeaderFooterView: UITableViewHeaderFooterView {
    var delegate: ExpendableHeaderViewDelegate?
    var section: Int?
    
    func setup(withTitle title: String, section: Int, delegate: ExpendableHeaderViewDelegate){
        self.delegate = delegate
        self.section = section
        self.textLabel?.text = title
    }
    
    override func layoutSubviews() {
        layoutSubviews()
        
        textLabel?.textColor = #colorLiteral(red: 0.9263228062, green: 0.9305439991, blue: 0.9432075777, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selecttHeaderAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selecttHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! TableViewHeaderFooterView
        delegate?.togleSections(header: self, section: cell.section!)
    }
}
