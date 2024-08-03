//
//  TaskAddView.swift
//  ToDo List
//
//  Created by Nebula on 14.07.24.
//

import UIKit

protocol TaskAddViewInterface: AnyObject{
    func setupNavBar()
    func setupUI()
    func setupTextViews()
}

final class TaskAddView: UIViewController {

    lazy var viewModel = TaskAddViewModel()
    
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
        text.text = "enter title..."
        text.textColor = .placeholderText
        return text
    }()
    
    private let descInput: UITextView = {
        let text = UITextView()
        text.backgroundColor = .secondarySystemFill
        text.layer.cornerRadius = 8
        text.font = UIFont.systemFont(ofSize: 22)
        text.text = "enter description..."
        text.textColor = .placeholderText
        return text
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
}

extension TaskAddView {
    @objc func newTaskAdd() {
        self.navigationController?.popToRootViewController(animated: true)
        guard let title = titleInput.text, let desc = descInput.text,title != "",desc != "" else {
            return
        }
        CoreDataHelper.shared.createTask(title: title, description: desc)
    }
}

extension TaskAddView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        viewModel.textViewDidBeginEditing(textView)
    }
}

extension TaskAddView: TaskAddViewInterface {
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
        self.navigationItem.title = "Add new task"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ADD", style: .done, target: self, action: #selector(newTaskAdd))
    }
    
    func setupTextViews() {
        titleInput.delegate = self
        descInput.delegate = self
    }
}
