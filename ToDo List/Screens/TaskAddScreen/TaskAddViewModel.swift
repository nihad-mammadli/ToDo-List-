//
//  TaskAddViewModel.swift
//  ToDo List
//
//  Created by Nebula on 23.07.24.
//

import UIKit

protocol TaskAddViewModelInterface {
    var view: TaskAddViewInterface? {get set}
    func viewDidLoad()
    func textViewDidBeginEditing(_ textView: UITextView)
}

class TaskAddViewModel {
    weak var view: TaskAddViewInterface?
    
}

extension TaskAddViewModel: TaskAddViewModelInterface {
    func viewDidLoad() {
        self.view?.setupNavBar()
        self.view?.setupUI()
        self.view?.setupTextViews()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholderText {
            textView.text = nil
            textView.textColor = .label
        }
    }
}
