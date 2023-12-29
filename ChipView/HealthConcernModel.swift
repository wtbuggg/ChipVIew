//
//  HealthConcernModel.swift
//  ChipView
//
//  Created by Htet LynnHtun on 29/12/2023.
//

import Foundation

class HealthConcernModel {
    private let _concerns = ["Sleep", "Immunity", "Stress", "Joint Support", "Digestion", "Mood", "Energy", "Hair, Skin, Nails", "Weight Loss", "Fitness", "Special Medical Condition"]
    
    private(set) var selectedConcerns = [String]()
    private let kMaxConcern = 5
    
    var concerns: [(String, Bool)] {
        _concerns.map { concern in
            let isSelected = selectedConcerns.contains([concern])
            return (concern, isSelected)
        }
    }
    
    var modelUpdated: (() -> Void)?
    
    func select(_ concern: String) {
        if let selectedIndex = selectedConcerns.firstIndex(of: concern) {
            selectedConcerns.remove(at: selectedIndex)
        } else if selectedConcerns.count < kMaxConcern {
            selectedConcerns.append(concern)
        }
        modelUpdated?()
    }
    
    func move(_ concern: String, to destination: Int) {
        guard let currentIndex = selectedConcerns.firstIndex(of: concern) else {
            return
        }
        selectedConcerns.remove(at: currentIndex)
        selectedConcerns.insert(concern, at: destination)
        modelUpdated?()
        print(">> selectedConcerns: \(selectedConcerns)")
    }
}
