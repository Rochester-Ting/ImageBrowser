//
//  DetailVC.swift
//  ImageBrowser
//
//  Created by Rochester on 18/3/17.
//  Copyright © 2017年 Rochester. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var modelArr : [Model] = []
    
    var scrollToIndexRow : IndexPath?
    
    
    var currentIndex : Int{
        let row = collectionView.indexPathsForVisibleItems.first?.row ?? 0
        return row
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCollectionView()
        if let index = scrollToIndexRow{
            collectionView.scrollToItem(at: index, at: .left, animated: true)
        }

        
        
    }

    @IBAction func close(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
}
extension DetailVC{
    fileprivate func addCollectionView(){
        let nib = UINib.init(nibName: "RRDetailCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "xx")
        collectionView.dataSource = self
        
        collectionView.delegate = self

    }
}
extension DetailVC : UICollectionViewDelegate{
    
}
extension DetailVC : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "xx", for: indexPath) as! RRDetailCell
        cell.backgroundColor = UIColor.red
        cell.model = modelArr[indexPath.row]
        return cell
        
    }
}
