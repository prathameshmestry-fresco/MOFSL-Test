//
//  ViewController.swift
//  Motilal-Test
//
//  Created by Prathamesh Mestry on 14/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModelTask = TaskViewModel()

    enum CellNames: String {
        case taskListTableViewCell = "TaskListTableViewCell"
    }
    
    let cellIdentifiers: [String] = [CellNames.taskListTableViewCell.rawValue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelTask.getTaskData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.registerNibs(cellIdentifiers)
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc func addTapped() {
        openActionSheet()
    }
    
    func openActionSheet() {
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Add Task", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TodoTaskViewController") as? TodoTaskViewController
            vc?.title = "Task"
            self.navigationController?.pushViewController(vc!, animated: true)
        }))
        
        actionsheet.addAction(UIAlertAction(title: "View Task from JSON", style: UIAlertAction.Style.default, handler: { (action) -> Void in
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) -> Void in
        }))
        self.present(actionsheet, animated: true, completion: nil)
    }
}



extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.taskListTableViewCell.rawValue) as? TaskListTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.layoutIfNeeded()
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
}
