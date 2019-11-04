//
//  HeaderCell.swift
//  AmazonBooks
//
//  Created by Victor Chang on 06/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionReusableView {

    var onSegmentChange: ((Int) -> Void)?
    
    var segmentControl: UISegmentedControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.0)
        addSubview(headerView)
        headerView.fillSuperview()
        setupSegmentedControl()
        headerView.addSubview(segmentControl)
        segmentControl.centerInSuperview()
    }
    
    fileprivate func setupSegmentedControl() {

        let titles = ["Todos", "Disponible", "No Disponible"]
        segmentControl = UISegmentedControl(items: titles)
        segmentControl.selectedSegmentTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        segmentControl.backgroundColor = UIColor(white: 0.2, alpha: 1)
        segmentControl.selectedSegmentIndex = 0
        for index in 0...titles.count - 1 {
            segmentControl.setWidth(120, forSegmentAt: index)
        }
        segmentControl.sizeToFit()
        segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.sendActions(for: .valueChanged)
        segmentControl.selectedSegmentTintColor(.white)
        segmentControl.unselectedSegmentTintColor(.white)
    }
    
    @objc fileprivate func segmentChanged() {        self.onSegmentChange?(segmentControl.selectedSegmentIndex)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
