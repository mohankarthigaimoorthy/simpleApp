//
//  tableViewCell.swift
//  simpleApp
//
//  Created by Imcrinox Mac on 06/12/1444 AH.
//

import UIKit
protocol CollectionViewCellDelegate: class {
    func collectionView(collectionviewcell: collectionViewCell?, index: Int, didTappedInTableViewCell: tableViewCell)
}
class tableViewCell: UITableViewCell {

    weak var cellDelegate: CollectionViewCellDelegate?

    var rowWithColors:[CollectionViewCellModel]?
    
    @IBOutlet weak var categoryLabel : UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        backgroundColor = UIColor.clear
        self.categoryLabel.textColor = UIColor.blue
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        flowlayout.itemSize = CGSize(width: 150, height: 180)
        flowlayout.minimumLineSpacing = 2.0
        flowlayout.minimumInteritemSpacing = 5.0
        self.collectionView.collectionViewLayout = flowlayout
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let cellNib = UINib(nibName: "collectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "collectionViewCellID")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension tableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func updateCellWith(row: [CollectionViewCellModel]) {
        self.rowWithColors = row
        self.collectionView.reloadData()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rowWithColors?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCellID", for: indexPath) as? collectionViewCell {
            cell.coloredView.backgroundColor = self.rowWithColors?[indexPath.item].color ?? UIColor.black
            cell.textLabel.text = self.rowWithColors?[indexPath.item].name ??
            ""
            return  cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? collectionViewCell
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item,didTappedInTableViewCell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}
