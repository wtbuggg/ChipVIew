//
//  HealthConcernsPrioritiesViewController.swift
//  ChipView
//
//  Created by Htet LynnHtun on 27/12/2023.
//

import UIKit
import Combine

class HealthConcernsPrioritiesViewController: UITableViewController {
    
    private let cellId = String(describing: PriorityItemViewCell.self)
    private let healthConcernModel: HealthConcernModel
    private var cancellable: AnyCancellable?
    
    init(model: HealthConcernModel) {
        self.healthConcernModel = model
        super.init(nibName: "HealthConcernsPrioritiesViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        tableView.showsVerticalScrollIndicator = false
        tableView.isEditing = true
        
        cancellable = healthConcernModel.selectedConcerns.sink { [weak self] _ in
            self?.syncViewWithModel()
        }
    }
    
    @objc func syncViewWithModel() {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return healthConcernModel.selectedConcerns.value.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Prioritize"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PriorityItemViewCell else {
            fatalError("Failed to dequeue PriorityItemViewCell")
        }
        cell.titleLabel.text = healthConcernModel.selectedConcerns.value[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let concern = healthConcernModel.selectedConcerns.value[fromIndexPath.row]
        healthConcernModel.move(concern, to: to.row)
    }
    
}
