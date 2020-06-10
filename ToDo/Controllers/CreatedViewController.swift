//
//  CreatedViewController.swift
//  ToDo
//
//  Created by Albert on 11.05.2020.
//  Copyright © 2020 Albert Mykola. All rights reserved.
//

import UIKit
import UserNotifications

final class CreatedViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak private var myTableView: UITableView!
    @IBOutlet weak private var createdButton: UIButton!
    
    // MARK: - Variable
    private var modelCell = Model()
    private var newTask = Info()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        for i in 0...modelCell.modelArray.count - 1 {
            modelCell.modelArray[i].expended = false
        }
    }
    
    // MARK: - Private func
    private func addTableView() {
        myTableView.register(UINib(nibName: "NameCellCreated", bundle: nil), forCellReuseIdentifier: "NameCellCreated")
        myTableView.register(UINib(nibName: "DiscriptionCell", bundle: nil), forCellReuseIdentifier: "DiscriptionCell")
        myTableView.register(UINib(nibName: "TimeCell", bundle: nil), forCellReuseIdentifier: "TimeCell")
        myTableView.register(UINib(nibName: "StatusCell", bundle: nil), forCellReuseIdentifier: "StatusCell")
        myTableView.register(UINib(nibName: "ExecutionTimeCell", bundle: nil), forCellReuseIdentifier: "ExecutionTimeCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func saveNewTask() {
        if info.name != "" && info.descriptionName != "" && info.timeTask != nil {
            notificationPush(InTime: info.timeTask!, identifier: info.name ?? "", text: info.descriptionName ?? "") { (success) in }
            
            newTask = Info(name: info.name, descriptionName: info.descriptionName, timeTask: info.timeTask, executionTime: info.executionTime, status: info.status, done: info.done)
            
            AllTask.shared.notPerformed.append(newTask)
            info.descriptionName = ""
            info.name = ""
            info.executionTime = nil
            info.timeTask = Date()
            info.status = 0
            
            for i in 0...modelCell.modelArray.count - 1 {
                modelCell.modelArray[i].expended = false
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func saveTask(_ sender: UIButton) {
        saveNewTask()
        navigationController?.popToRootViewController(animated: true)
    }
}

//MARK: - UITableViewDelegate
extension CreatedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? NameCellCreated {
            Model.shared.modelArray[indexPath.row].expended = !Model.shared.modelArray[indexPath.row].expended
            let param = Model.shared.modelArray[indexPath.row]
            myTableView.beginUpdates()
            cell.changeHeight(param: param)
            myTableView.endUpdates()
        } else if let cell = tableView.cellForRow(at: indexPath) as? DescriptionCell {
            myTableView.beginUpdates()
            Model.shared.modelArray[indexPath.row].expended = !Model.shared.modelArray[indexPath.row].expended
            let param = Model.shared.modelArray[indexPath.row]
            cell.changeHeight(param: param)
            myTableView.endUpdates()
        } else if let cell = tableView.cellForRow(at: indexPath) as? TimeCell {
            myTableView.beginUpdates()
            Model.shared.modelArray[indexPath.row].expended = !Model.shared.modelArray[indexPath.row].expended
            let param = Model.shared.modelArray[indexPath.row]
            
            cell.changeHeight(param: param)
            myTableView.endUpdates()
        } else if let cell = tableView.cellForRow(at: indexPath) as? StatusCell {
            myTableView.beginUpdates()
            Model.shared.modelArray[indexPath.row].expended = !Model.shared.modelArray[indexPath.row].expended
            let param = Model.shared.modelArray[indexPath.row]
            cell.changeHeight(param: param)
            myTableView.endUpdates()
        }
    }
}

//MARK: - UITableViewDataSource
extension CreatedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelCell.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameCellCreated", for: indexPath) as! NameCellCreated
            cell.textField.delegate = self
            cell.textField.text = info.name
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiscriptionCell", for: indexPath) as! DescriptionCell
            cell.textField.delegate = self
            cell.textField.text = info.descriptionName
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as! TimeCell
            if let date = info.timeTask {
                cell.datePicker.date = date
                return cell
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatusCell", for: indexPath) as! StatusCell
                cell.segmentControl.selectedSegmentIndex = info.status
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
}

extension CreatedViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            textField.resignFirstResponder()
            info.name = textField.text
        } else if textField.tag == 1 {
            textField.resignFirstResponder()
            info.descriptionName = textField.text
        }
        return true
    }
}
