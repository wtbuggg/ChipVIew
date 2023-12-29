//
//  ViewController.swift
//  ChipView
//
//  Created by Htet LynnHtun on 22/12/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let healthConcernModel = HealthConcernModel()
    
    private lazy var healthConcernsSelectorVC = HealthConcernsSelectorVC(model: healthConcernModel)
    private lazy var prioritiesVC = HealthConcernsPrioritiesViewController(model: healthConcernModel)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(healthConcernsSelectorVC)
        healthConcernsSelectorVC.didMove(toParent: self)
        view.addSubview(healthConcernsSelectorVC.view)
        healthConcernsSelectorVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        let safeGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            healthConcernsSelectorVC.view.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor),
            healthConcernsSelectorVC.view.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            healthConcernsSelectorVC.view.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor),
        ])
        
        addChild(prioritiesVC)
        prioritiesVC.didMove(toParent: self)
        view.addSubview(prioritiesVC.view)
        prioritiesVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            prioritiesVC.view.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 10),
            prioritiesVC.view.topAnchor.constraint(equalTo: healthConcernsSelectorVC.view.bottomAnchor, constant: 10),
            prioritiesVC.view.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -10),
            prioritiesVC.view.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor, constant: -10),
        ])
    }

}
