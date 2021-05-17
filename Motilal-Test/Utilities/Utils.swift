//
//  Utils.swift
//  Motilal-Test
//
//  Created by Prathamesh Mestry on 14/05/21.
//

import UIKit
import CoreData

class Utils {
    
    class func convertStringToDate(dateStr : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let date = dateFormatter.date(from: dateStr) {
            return date
        }
        return Date()
    }
    
    class func convertDateToString(taskDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let date = dateFormatter.string(from: taskDate as Date)
        return date
    }
    
}

extension UIViewController {
    
    class func loadNib<T: UIViewController>(_ viewType: T.Type) -> T {
        let className = String.className(viewType)
        return T(nibName: className, bundle: nil)
    }
    
    class func loadNib() -> Self {
        return loadNib(self)
    }
    
}



extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}


extension UIView {
    
    @discardableResult
    
    func fromNib<T : UIView>() -> T? {
        //https://stackoverflow.com/questions/24857986/load-a-uiview-from-nib-in-swift
        guard let contentView = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            // xib not loaded, or it's top view is of the wrong type
            return nil
        }
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        return contentView
    }
    
    func setAsRounded(cornerRadius: CGFloat = 5.0) {
        self.layoutIfNeeded()
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func setBorderToView(borderColor: UIColor = UIColor.gray, borderWidth: CGFloat = 1.0) {
        self.layoutIfNeeded()
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
    }
}


extension UITableView {
    
    func registerNibs(_ cellIdentifiers: [String]) {
        
        for identifier in cellIdentifiers {
            self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
}


extension UIButton {
    func setCornerStyle() {
        self.layer.cornerRadius = 15.0
    }
}


extension UITextField {
    
    func addInputViewDatePicker(target: Any, selector: Selector) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        self.inputView = datePicker
        
        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        
        self.inputAccessoryView = toolBar
    }
    
    @objc func cancelPressed() {
        self.resignFirstResponder()
    }
    
}
