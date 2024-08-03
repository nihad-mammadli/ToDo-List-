//
//  TaskEditViewModel.swift
//  ToDo List
//
//  Created by Nebula on 24.07.24.
//

import UIKit

protocol TaskEditViewModelInterface {
    var view: TaskEditViewInterface? {get set}
    func viewDidLoad()
}

class TaskEditViewModel {
    weak var view: TaskEditViewInterface?
    
    var title: String?
    var desc: String?
    
    init(title: String? = nil, desc: String? = nil) {
        self.title = title
        self.desc = desc
    }
    
}

extension TaskEditViewModel: TaskEditViewModelInterface {
    func viewDidLoad() {
        self.view?.setupUI()
        self.view?.setupNavBar()
        self.view?.setupTextViews()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholderText {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func deleteTask(task: Task) {
        CoreDataHelper.shared.deleteTask(task: task)
    }
    
    func saveEditedTask(task: Task, newTitle: String, newDesc: String) {
        CoreDataHelper.shared.updateTask(task: task, newTitle: newTitle, newDesc: newDesc)
    }
    
}
