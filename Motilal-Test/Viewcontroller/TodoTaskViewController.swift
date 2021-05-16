//
//  TodoTaskViewController.swift
//  Motilal-Test
//
//  Created by Prathamesh Mestry on 15/05/21.
//

import UIKit

class TodoTaskViewController: UIViewController {
    
    @IBOutlet weak var addEditButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var switchReminder : UISwitch!
    var isEditable: Bool = false
    var datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        setupButtonView()
        dateTextField.inputView = datePicker
        dateTextField.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
    }
    
    func setupButtonView() {
        addEditButton.setCornerStyle()
        deleteButton.setCornerStyle()
        self.deleteButton.isHidden = isEditable ? false : true
    }
    
    @IBAction func addEditTaskButtonClicked(_ sender: Any) {
        let result = TodoTask(context: PersistentStorage.shared.context)
        result.title = titleTextField.text
        result.todoDescription = descriptionTextField.text
        result.todoDate = Utils.convertStringToDate(dateStr: dateTextField.text ?? "")
        result.isReminder = switchReminder.isOn
        PersistentStorage.shared.saveContext()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteTaskButtonClicked(_ sender: Any) {
        
    }

    @objc func doneButtonPressed() {
        if let  datePicker = self.dateTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            datePicker.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateStyle = .medium
            self.dateTextField.text = dateFormatter.string(from: datePicker.date)
        }
        self.dateTextField.resignFirstResponder()
     }
    
}
