//
//  HealthConcernModel.swift
//  ChipView
//
//  Created by Htet LynnHtun on 29/12/2023.
//

import Foundation
import Combine

class HealthConcernModel {
    private let _concerns = ["Sleep", "Immunity", "Stress", "Joint Support", "Digestion", "Mood", "Energy", "Hair, Skin, Nails", "Weight Loss", "Fitness", "Special Medical Condition"]
    
    private(set) var selectedConcerns = CurrentValueSubject<[String], Never>([])
    private let kMaxConcern = 5
    
    var concerns: [(String, Bool)] {
        _concerns.map { concern in
            let isSelected = selectedConcerns.value.contains([concern])
            return (concern, isSelected)
        }
    }
    
    func select(_ concern: String) {
        var lastSelected = selectedConcerns.value
        if let selectedIndex = lastSelected.firstIndex(of: concern) {
            lastSelected.remove(at: selectedIndex)
        } else if lastSelected.count < kMaxConcern {
            lastSelected.append(concern)
        }
        selectedConcerns.send(lastSelected)
    }
    
    func move(_ concern: String, to destination: Int) {
        var lastSelected = selectedConcerns.value
        guard let currentIndex = lastSelected.firstIndex(of: concern) else {
            return
        }
        lastSelected.remove(at: currentIndex)
        lastSelected.insert(concern, at: destination)
        selectedConcerns.send(lastSelected)
    }
}
