//
//  ListViewController.swift
//  ToDo
//
//  Created by Albert on 09.05.2020.
//  Copyright © 2020 Albert Mykola. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var myTableView: UITableView!
    
    //MARK: - Variable
    let date = Date()
    let dateFormater = DateFormatter()
    var dates = ""
    
    
    //MARK: - Live cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormater.dateFormat = "EEEE, \nMMM d, yyyy"
        dateLabel.text = dateFormater.string(from: date)
        dateLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        myTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        myTableView.sectionHeaderHeight = 70
        addTableView()
        setup()
        sort()
        myTableView.reloadData()
        editing = false
    }
    
    //MARK - Actions
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        info.descriptionName = ""
        info.name = ""
        info.executionTime = nil
        info.timeTask = Date()
        info.status = 0
        nextViewController()
    }
    
    //MARK: - Private functions
    private func nextViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "CreatedViewController") as! CreatedViewController
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    private func setup() {
        for (index, value) in AllTask.shared.notPerformed.enumerated() {
            if value.done == true {
                AllTask.shared.tasksCompleted.append(value)
                AllTask.shared.notPerformed.remove(at: index)
            }
        }
    }
    
    private func sort() {
        let date = Date()
        AllTask.shared.tasksCompleted.sort(by: { $0.timeTask ?? date < $1.timeTask ?? date })
        AllTask.shared.notPerformed.sort(by: { $0.timeTask ?? date < $1.timeTask ?? date })
    }
    
    private func addTableView() {
        myTableView.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        myTableView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.reloadData()
        myTableView.rowHeight = UITableView.automaticDimension
    }
}

//MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
    
        if section == 0 && AllTask.shared.notPerformed.count != 0 {
            header.headerLabel.text = "Not performed"
        } else {
            header.headerLabel.text = "Done tasks"
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "Delate") { (action, view, success) in
            if indexPath.section == 0 && AllTask.shared.notPerformed.count != 0 {
                AllTask.shared.notPerformed.remove(at: indexPath.row)
                self.myTableView.reloadData()
            } else {
                AllTask.shared.tasksCompleted.remove(at: indexPath.row)
                self.myTableView.reloadData()
            }
        }
        
        let done = UIContextualAction(style: .normal, title: "Done") { (action, view, success) in
            AllTask.shared.notPerformed[indexPath.row].done = true
             AllTask.shared.tasksCompleted.append(AllTask.shared.notPerformed[indexPath.row])
            AllTask.shared.notPerformed.remove(at: indexPath.row)
            self.myTableView.reloadData()
        }
        
        delete.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        done.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        if indexPath.section == 0 && AllTask.shared.notPerformed.count != 0 {
            let conf = UISwipeActionsConfiguration(actions: [delete , done])
            return conf
        } else {
            let conf = UISwipeActionsConfiguration(actions: [delete])
            return conf
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeLeft = UIContextualAction(style: .normal, title: "Edit") { (action, view, success) in
            let arrayInfo = AllTask.shared.notPerformed[indexPath.row]
            info.name = arrayInfo.name
            info.descriptionName = arrayInfo.descriptionName
            info.executionTime = arrayInfo.executionTime
            info.timeTask = arrayInfo.timeTask
            info.status = arrayInfo.status
            editing = true
            AllTask.shared.notPerformed.remove(at: indexPath.row)
            
            self.nextViewController()
        }
        
        swipeLeft.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        if AllTask.shared.notPerformed.count != 0 && indexPath.section == 0 {
        
            return UISwipeActionsConfiguration(actions: [swipeLeft])
        }
        return UISwipeActionsConfiguration()
    }
}

//MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var num = 0
        if AllTask.shared.notPerformed.count != 0 {
            num += 1
        }
        
        if AllTask.shared.tasksCompleted.count != 0 {
            num += 1
        }
        
        if num == 0 {
            myTableView.isHidden = true
        } else {
            myTableView.isHidden = false
        }
        return num
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && AllTask.shared.notPerformed.count != 0 {
            return AllTask.shared.notPerformed.count
        } else {
            return AllTask.shared.tasksCompleted.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        
        if indexPath.section == 0 && AllTask.shared.notPerformed.count != 0 {
            let info = AllTask.shared.notPerformed[indexPath.row]
            cell.createdCell(param: info)
            return cell
        } else {
            let info = AllTask.shared.tasksCompleted[indexPath.row]
            cell.createdCell(param: info)
            cell.myView.backgroundColor = #colorLiteral(red: 0.327170295, green: 0.6906169041, blue: 0.1473408212, alpha: 1)
            return cell
        }
    }
}





