//
//  TasksViewModel.swift
//  ToDo List
//
//  Created by Nebula on 23.07.24.
//

import UIKit

protocol TasksViewModelInterface {
    var view: TasksViewInterface? {get set}
    func viewDidLoad()
    func viewWillAppear()
    func removeAllTasks()
}

final class TasksViewModel {
    weak var view: TasksViewInterface?

}

extension TasksViewModel: TasksViewModelInterface {
    func removeAllTasks() {
        for task in CoreDataHelper.tasksList {
            CoreDataHelper.shared.deleteTask(task: task)
            self.view?.refreshData()
        }
    }
    
    func viewDidLoad() {
        CoreDataHelper.shared.getAllTasks()
        view?.setupNavBar()
        view?.setupUI()
        view?.setupCollectionView()
        view?.setupRefreshControl()
    }
    
    func viewWillAppear() {
        view?.refreshData()
    }
    
}
