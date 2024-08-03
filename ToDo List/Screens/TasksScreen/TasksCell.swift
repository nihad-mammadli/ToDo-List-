//
//  TasksCell.swift
//  ToDo List
//
//  Created by Nebula on 14.07.24.
//

import UIKit

final class TasksCell: UICollectionViewCell {
    static let identifier: String = "taskCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        self.backgroundColor = .secondaryLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let taskTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
}

extension TasksCell {
    private func setupCell() {
        self.addSubview(taskTitle)
        self.layer.cornerRadius = 8
        taskTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            taskTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            taskTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    func setCell(title:String) {
        taskTitle.text = title
    }
}

