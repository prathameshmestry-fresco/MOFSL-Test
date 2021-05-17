//
//  TodoTaskViewController.swift
//  Motilal-Test
//
//  Created by Prathamesh Mestry on 15/05/21.
//

import UIKit
import CoreData

protocol TodoTaskActionDelegate: class {
    func addEditTask()
}

class TodoTaskViewController: UIViewController {
    
    @IBOutlet weak var addEditButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var switchReminder : UISwitch!
    var isEditable: Bool = false
    var taskId: Int = 0
    var datePicker = UIDatePicker()
    var userData: [String: Any]?
    var selectedTask: TodoTaskModel?
    weak var taskDelegate: TodoTaskActionDelegate?
    var dbOperation = DatabaseOperation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        isEditable = ((userData?["isEdit"]) != nil)
        selectedTask = userData?["selectedTask"] as? TodoTaskModel
        taskId = isEditable ? selectedTask?.id ?? 0 : taskId
        setupButtonView()
        dateTextField.inputView = datePicker
        dateTextField.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        setupData()
    }
    
    func setupData() {
        titleTextField.text = selectedTask?.title
        descriptionTextField.text = selectedTask?.description
        dateTextField.text = Utils.convertDateToString(taskDate: selectedTask?.taskDate ?? Date())
        switchReminder.setOn(selectedTask?.isReminder ?? false, animated: true)
    }
    
    func setupButtonView() {
        addEditButton.setCornerStyle()
        deleteButton.setCornerStyle()
        self.addEditButton.setTitle(isEditable ? "Edit Task" : "Add Task", for: .normal)
        self.deleteButton.isHidden = isEditable ? false : true
    }
    
    @IBAction func addEditTaskButtonClicked(_ sender: Any) {
        
        if validationCheck() {
            if isEditable {
                dbOperation.updateRecordData(taskId: taskId, title: titleTextField.text ?? "", taskDescription: descriptionTextField.text ?? "", todoDate: Utils.convertStringToDate(dateStr: dateTextField.text ?? ""), isReminderCheck: switchReminder.isOn)
            } else {
                dbOperation.addRecordData(taskId: taskId, title: titleTextField.text ?? "", taskDescription: descriptionTextField.text ?? "", todoDate: Utils.convertStringToDate(dateStr: dateTextField.text ?? ""), isReminderCheck: switchReminder.isOn)
            }
            self.taskDelegate?.addEditTask()
            self.navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Validation Error", message: "Todo Task Title and Description can't be empty.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func validationCheck() -> Bool {
        
        if let title = titleTextField.text, !title.isEmpty, let descriptionText = descriptionTextField.text, !descriptionText.isEmpty {
            return true
        }
        return false
    }
    
    @IBAction func deleteTaskButtonClicked(_ sender: Any) {
        dbOperation.delete(id: taskId)
        self.taskDelegate?.addEditTask()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func doneButtonPressed() {
        if let datePicker = self.dateTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy"
            datePicker.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateStyle = .medium
            self.dateTextField.text = dateFormatter.string(from: datePicker.date)
        }
        self.dateTextField.resignFirstResponder()
    }
    
}
