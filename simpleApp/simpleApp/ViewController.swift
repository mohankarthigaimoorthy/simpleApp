//
//  ViewController.swift
//  simpleApp
//
//  Created by Imcrinox Mac on 05/12/1444 AH.
//

import UIKit

class ViewController: UIViewController {

    var backgroundColor : UIColor!
    var backgroundColorName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = backgroundColor
        self.navigationItem.title = backgroundColorName
    }


}

