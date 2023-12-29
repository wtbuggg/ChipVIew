//
//  ViewController.swift
//  ChipView
//
//  Created by Htet LynnHtun on 22/12/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let healthConcerns = ["Sleep", "Immunity", "Stress", "Joint Support", "Digestion", "Mood", "Energy", "Hair, Skin, Nails", "Weight Loss", "Fitness", "Stress", "Special Medical Condition"]
    private lazy var healthConcernsSelectorVC = HealthConcernsSelectorVC()
    private lazy var prioritiesVC = HealthConcernsPrioritiesViewController()
    
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
        
        healthConcernsSelectorVC.healthConcerns = healthConcerns.map { ($0, false) }
        
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
