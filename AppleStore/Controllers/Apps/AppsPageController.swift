//
//  AppsController.swift
//  AppleStore
//
//  Created by 豊岡正紘 on 2019/04/23.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit

class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout{
    
    private let cellId = "cellId"
    private let headerId = "headerId"
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        fetchData()
    }
    
    var group = [AppGroup]()
    var socialApps = [SocialApp]()
    
    private func fetchData() {
        
        var appGroup1: AppGroup?
        var appGroup2: AppGroup?
        var appGroup3: AppGroup?
        
        let dispatchGroup = DispatchGroup()
        
        
        dispatchGroup.enter()
        Service.shared.fetchTopGames { (appGroup, err) in
            dispatchGroup.leave()
            appGroup1 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, err) in
            dispatchGroup.leave()
            appGroup2 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossingGames { (appGroup, err) in
            dispatchGroup.leave()
            appGroup3 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchSocialApps { (apps, err) in
            dispatchGroup.leave()
            self.socialApps = apps ?? []
        }
        
    
        dispatchGroup.notify(queue: .main) {
            self.activityIndicatorView.stopAnimating()
            
            if let appGroup1 = appGroup1 {
                self.group.append(appGroup1)
            }
            if let appGroup2 = appGroup2 {
                self.group.append(appGroup2)
            }
            if let appGroup3 = appGroup3 {
                self.group.append(appGroup3)
            }
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
        
        header.appHeaderHorizontalController.socialApps = self.socialApps
        header.appHeaderHorizontalController.collectionView.reloadData()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        
        let appGroup = group[indexPath.item]
        
        cell.titleLabel.text = appGroup.feed.title
        cell.horizontalController.appGroup = appGroup
        cell.horizontalController.collectionView.reloadData()
        
        cell.horizontalController.didSelectHandler = {[weak self] feedResult in
            let appDetailController = AppDetailController(appId: feedResult.id)
            appDetailController.navigationItem.title = feedResult.name
            self?.navigationController?.pushViewController(appDetailController, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
