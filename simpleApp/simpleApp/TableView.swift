//
//  TableView.swift
//  simpleApp
//
//  Created by Imcrinox Mac on 06/12/1444 AH.
//

import Foundation
import UIKit

class tableView: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    var colorsArray = Colors()
    var tappedCell: CollectionViewCellModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        table.backgroundColor =  UIColor.colorFromHex()
        table.separatorStyle = .none
        
        let cellNib = UINib(nibName: "tableViewCell", bundle: nil)
        self.table.register(cellNib, forCellReuseIdentifier: "tableViewCellID")
    }
    
}

extension tableView: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return colorsArray.objectsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorsArray.objectsArray[section].subcategory.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 0, width: 200, height: 44))
        headerView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.clear
        
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.text = colorsArray.objectsArray[section].category
        return headerView
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = table.dequeueReusableCell(withIdentifier: "tableViewCellID", for: indexPath) as? tableViewCell
        {
            let subCategoryTitle = colorsArray.objectsArray[indexPath.section].subcategory
            cell.categoryLabel.text = subCategoryTitle[indexPath.row]
            let rowArray = colorsArray.objectsArray[indexPath.section].colors[indexPath.row]
            cell.updateCellWith(row: rowArray)
            
            cell.cellDelegate = self
            
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewcontrollerseg" {
            let DestViewController = segue.destination as! ViewController
            DestViewController.backgroundColor = tappedCell.color
            DestViewController.backgroundColorName = tappedCell.name
        }
    }
}

extension tableView: CollectionViewCellDelegate {
    func collectionView(collectionviewcell: collectionViewCell?, index: Int, didTappedInTableViewCell: tableViewCell) {
        if let colorsRow = didTappedInTableViewCell.rowWithColors {
            self.tappedCell = colorsRow[index]
            performSegue(withIdentifier: "viewcontrollerseg", sender: self)
        }
    }
}
