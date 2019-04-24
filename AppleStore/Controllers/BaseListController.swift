//
//  BaseListController.swift
//  AppleStore
//
//  Created by 豊岡正紘 on 2019/04/23.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit

class BaseListController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
