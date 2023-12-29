//
//  HealthConcernsSelectorVC.swift
//  ChipView
//
//  Created by Htet LynnHtun on 26/12/2023.
//

import UIKit

class HealthConcernsSelectorVC: UIViewController {
    
    let concernsSelectorView = ConcernsSelectorView()
    var healthConcerns = [(String, Bool)]() {
        didSet {
            concernsSelectorView.healthConcerns = healthConcerns
        }
    }
    
    override func loadView() {
        view = concernsSelectorView
        concernsSelectorView.didSelectConcernAt = { [weak self] index in
            guard let self else { return }
            let concern = self.healthConcerns[index]
            self.healthConcerns[index] = (concern.0, !concern.1)
        }
    }
    
}

final class ConcernsSelectorView: UIView {
    var chipViews = [UILabel]()
    var healthConcerns = [(String, Bool)]() {
        didSet {
            addChipViews()
        }
    }
    var didSelectConcernAt: ((Int) -> Void)?
    var viewHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layoutChipViews()
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: viewHeight)
    }
    
    func addChipViews() {
        chipViews.forEach { $0.removeFromSuperview() }
        chipViews.removeAll()
        
        for concern in healthConcerns {
            let (title, selected) = concern
            let chipItemView = makeLabel(
                withTitle: title,
                selected: selected
            )
            addSubview(chipItemView)
            chipViews.append(chipItemView)
        }
    }
    
    func layoutChipViews() {
        var x: CGFloat = 10
        var y: CGFloat = 10
        var lastItemView: UIView?
        for itemView in chipViews {
            let itemWidth = itemView.frame.size.width
            let needWrap = (x + itemWidth) > frame.size.width
            if needWrap {
                x = 10
                y += itemView.frame.size.height + 10
            }
            itemView.frame.origin = CGPoint(x: x, y: y)
            x += itemWidth + 10
            lastItemView = itemView
        }
        viewHeight = y + lastItemView!.frame.size.height + 10
        invalidateIntrinsicContentSize()
    }
    
    private func makeLabel(
        withTitle title: String,
        selected: Bool
    ) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textAlignment = .center
        label.textColor = selected ? .label : .systemGreen
        label.backgroundColor = selected ? .systemGreen : .clear
        label.sizeToFit()
        let intrinsicSize = label.intrinsicContentSize
        let labelSize = CGSize(
            width: 12 + intrinsicSize.width + 12,
            height: 8 + intrinsicSize.height + 8
        )
        label.frame.size = labelSize
        label.clipsToBounds = true
        label.layer.borderColor = UIColor.systemGreen.cgColor
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = labelSize.height / 2
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapChip)))
        return label
    }
    
    @objc func didTapChip(_ sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel,
        let tappedIndex = chipViews.firstIndex(of: label) else {
            fatalError("View should be UILabel")
        }
        
        didSelectConcernAt?(tappedIndex)
    }

}
