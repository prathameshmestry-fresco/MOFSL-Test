//
//  TaskListTableViewCell.swift
//  Motilal-Test
//
//  Created by Prathamesh Mestry on 15/05/21.
//

import UIKit

class TaskListTableViewCell: UITableViewCell {

    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reminderLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
        taskView.setAsRounded(cornerRadius: 10.0)
    }
    
    func setupData(taskDetail: TodoTaskModel) {
        titleLabel.text = taskDetail.title
        descriptionLabel.text = taskDetail.description
    }
    
}
