//
//  HealthConcernsPrioritiesViewController.swift
//  ChipView
//
//  Created by Htet LynnHtun on 27/12/2023.
//

import UIKit

class HealthConcernsPrioritiesViewController: UITableViewController {
    
    private let cellId = String(describing: PriorityItemViewCell.self)
    
    var healthConcerns = ["Sleep", "Immunity", "Stress", "Joint Support", "Digestion"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        tableView.showsVerticalScrollIndicator = false
        tableView.isEditing = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return healthConcerns.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Prioritize"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PriorityItemViewCell else {
            fatalError("Failed to dequeue PriorityItemViewCell")
        }
        cell.titleLabel.text = healthConcerns[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedItem = healthConcerns[fromIndexPath.row]
        healthConcerns.remove(at: fromIndexPath.row)
        healthConcerns.insert(movedItem, at: to.row)
    }
    
}
