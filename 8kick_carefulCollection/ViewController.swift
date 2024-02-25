//
//  ViewController.swift
//  8kick_carefulCollection
//
//  Created by Нечаев Михаил on 25.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let itemWidth: CGFloat = 200

    var leftOffset: CGFloat {
        view.layoutMargins.left
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: 350)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = leftOffset
        layout.sectionInset = UIEdgeInsets(top: 0, left: leftOffset, bottom: 0, right: leftOffset)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentOffset = CGPoint(x: leftOffset, y: 0)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Collection"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView.frame = CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 350)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        71
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.backgroundColor = .systemGray5
        return cell
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentOffset = targetContentOffset.pointee.x
        let targetIndex = round((currentOffset - leftOffset) / (itemWidth + leftOffset))
        let newX = targetIndex * (itemWidth + leftOffset)
        targetContentOffset.pointee.x = newX
    }

}
