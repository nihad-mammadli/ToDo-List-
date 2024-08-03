//
//  TasksView.swift
//  ToDo List
//
//  Created by Nebula on 14.07.24.
//

import UIKit

protocol TasksViewInterface : AnyObject {
    func refreshData()
    func setupNavBar()
    func setupUI()
    func setupCollectionView()
    func setupRefreshControl()
}

final class TasksView: UIViewController {
    
    private lazy var viewModel = TasksViewModel()
    
    private let tasksCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createFlowLayout())
        return cv
    }()
    
    private let refreshControl: UIRefreshControl = {
       let rc = UIRefreshControl()
        return rc
    }()
    
    private let emptyLabel: UILabel = {
        let el = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.dHeight, height: CGFloat.dWidth))
        el.text = "No task"
        el.textAlignment = .center
        el.font = .systemFont(ofSize: 32, weight: .bold)
        return el
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()
    }
}

    //MARK: - CollectionView Settings
extension TasksView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.tasksCollectionView.backgroundView = emptyLabel
        if CoreDataHelper.tasksList.count == 0 {
            emptyLabel.isHidden = false
            return 0
        } else {
            emptyLabel.isHidden = true
            return CoreDataHelper.tasksList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = CoreDataHelper.tasksList[indexPath.row]
        let cell = tasksCollectionView.dequeueReusableCell(withReuseIdentifier: TasksCell.identifier, for: indexPath) as! TasksCell
        cell.setCell(title: model.title ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width - 30
        let height = self.view.frame.height / 10
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToEdit(task: CoreDataHelper.tasksList[indexPath.row])
    }
    
}

    //MARK: - Delegate
extension TasksView : TasksViewInterface {
    @objc func refreshData() {
        DispatchQueue.main.async {
            self.tasksCollectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func setupUI() {
        self.view?.addSubview(tasksCollectionView)
        tasksCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tasksCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tasksCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tasksCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tasksCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    func setupNavBar() {
        self.navigationItem.title = "Tasks"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let addBtn = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"),
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(addButtonClicked))
        let removeAllBtn = UIBarButtonItem(image: UIImage(systemName: "arrow.up.trash")
                                           , style: .plain,
                                           target: self,
                                           action: #selector(removeAllBtnClicked))
        
        self.navigationItem.rightBarButtonItems = [addBtn,removeAllBtn]
        
        removeAllBtn.tintColor = .red
    }
    
    
    func setupCollectionView() {
        tasksCollectionView.dataSource = self
        tasksCollectionView.delegate = self
        tasksCollectionView.register(TasksCell.self, forCellWithReuseIdentifier: TasksCell.identifier)
    }
    
    func setupRefreshControl() {
        if #available(iOS 10.0, *) {
            tasksCollectionView.refreshControl = refreshControl
        } else {
            tasksCollectionView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
    }
    
    func navigateToEdit(task: Task) {
        DispatchQueue.main.async {
            let editView = TaskEditView(task: task)
            self.navigationController?.pushViewController(editView, animated: true)
        }
    }
}

extension TasksView {
    @objc private func addButtonClicked() {
        lazy var nextVC = TaskAddView()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func removeAllBtnClicked() {
        let alert = UIAlertController(title: "Attention",
                                      message: "Do you want to delete all tasks ?",
                                      preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", 
                                   style: .cancel) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        
        let remove = UIAlertAction(title: "Remove", 
                                   style: .destructive) { _ in
            self.viewModel.removeAllTasks()
        }
        
        alert.addAction(cancel)
        alert.addAction(remove)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func createTask(title: String, desc: String) {
        CoreDataHelper.shared.createTask(title: title, description: desc)
    }
}
