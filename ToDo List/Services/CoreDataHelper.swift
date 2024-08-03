//
//  CoreDataHelper.swift
//  ToDo List
//
//  Created by Nebula on 24.07.24.
//

import UIKit
import CoreData

final class CoreDataHelper {
    static let shared = CoreDataHelper()
    
    private init() {}
    
    static var tasksList = [Task]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func getAllTasks() {
        do {
            CoreDataHelper.tasksList = try context.fetch(Task.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createTask(title: String, description: String) {
        let newTask = Task(context: context)
        newTask.title = title
        newTask.desc = description
        newTask.date = Date()
        
        do {
            try context.save()
            CoreDataHelper.tasksList.append(newTask)
            getAllTasks()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteTask(task: Task) {
        context.delete(task)
        
        do {
            try context.save()
            getAllTasks()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateTask(task: Task, newTitle: String?, newDesc: String?) {
        if let newTitle = newTitle {
            task.title = newTitle
        }
        if let newDesc = newDesc {
            task.desc = newDesc
        }
        do {
            try context.save()
            getAllTasks()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
