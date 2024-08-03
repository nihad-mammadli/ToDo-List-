//
//  TaskEditView.swift
//  ToDo List
//
//  Created by Nebula on 24.07.24.
//

import UIKit

protocol TaskEditViewInterface: AnyObject {
    func setupNavBar()
    func setupUI()
    func setupTextViews()
}

final class TaskEditView: UIViewController {
    
    lazy var viewModel = TaskEditViewModel()
    let task: Task
    
    init(task: Task) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Title:"
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Description:"
        return label
    }()
    
    private let titleInput: UITextView = {
        let text = UITextView()
        text.backgroundColor = .secondarySystemFill
        text.layer.cornerRadius = 8
        text.font = UIFont.systemFont(ofSize: 22)
        text.textColor = .label
        return text
    }()
    
    private let descInput: UITextView = {
        let text = UITextView()
        text.backgroundColor = .secondarySystemFill
        text.layer.cornerRadius = 8
        text.font = UIFont.systemFont(ofSize: 22)
        text.textColor = .label
        return text
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupNavBar()
        setupTextViews()
    }
    
}

extension TaskEditView {
    @objc func deleteTask() {
        viewModel.deleteTask(task: task)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func saveEditedTask() {
        if let newTitle = titleInput.text, let newDesc = descInput.text {
            viewModel.saveEditedTask(task: task, newTitle: newTitle, newDesc: newDesc)
            navigationController?.popToRootViewController(animated: true)
        } else {
            return
        }
    }
}

extension TaskEditView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        viewModel.textViewDidBeginEditing(textView)
    }
}



extension TaskEditView: TaskEditViewInterface {
    func setupUI() {
        view.addSubviews(titleLabel, titleInput, descLabel, descInput)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        titleInput.translatesAutoresizingMaskIntoConstraints = false
        descInput.translatesAutoresizingMaskIntoConstraints = false
        
        let padding = 20.0
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            titleInput.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            titleInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleInput.heightAnchor.constraint(equalToConstant: .dWidth / 4),
            
            descLabel.topAnchor.constraint(equalTo: titleInput.bottomAnchor, constant: padding),
            descLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            descLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            descInput.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: padding),
            descInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            descInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            descInput.heightAnchor.constraint(equalToConstant: .dHeight / 2)
        ])
    }
    
    func setupNavBar() {
        self.navigationItem.title = dateFormatter.shared.formatDate(date: task.date)
        
        let saveBtn = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveEditedTask))
        let deleteBtn = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(deleteTask))
        deleteBtn.tintColor = .red
        self.navigationItem.rightBarButtonItems = [saveBtn, deleteBtn]
    }
    
    func setupTextViews() {
        titleInput.text = task.title
        descInput.text = task.desc
        titleInput.delegate = self
        descInput.delegate = self
    }
}
