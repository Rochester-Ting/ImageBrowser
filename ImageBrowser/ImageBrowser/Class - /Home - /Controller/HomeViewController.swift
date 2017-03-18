//
//  HomeViewController.swift
//  ImageBrowser
//
//  Created by Rochester on 18/3/17.
//  Copyright © 2017年 Rochester. All rights reserved.
//

import UIKit
import AFNetworking
private let reuseIdentifier = "Cell"

class HomeViewController: UICollectionViewController {
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var modelArr : [Model] = [Model]()
    weak var detailVC : DetailVC?
    lazy var animation : HomeAnimator = {
        $0.presentDelegate = self
        $0.dismissDelegate = self
        return $0
    }(HomeAnimator())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout(fowLayout: flowLayout)
        
        loadData()
    }


    
}
extension HomeViewController{
    fileprivate func loadData(){
        let manager = AFHTTPSessionManager()
        let params = [
            "opt_type" : 1,
            "size" : 9,
            "offset" : 0
        ]
        manager.get("http://apiv2.yangkeduo.com/operation/14/groups", parameters: params, progress: nil, success: { (task : URLSessionDataTask, resultObject : Any?) in
            let dict = resultObject as? [String : Any]
            guard let dictArray = dict?["goods_list"] as? [[String : Any]] else{return}
            
            for dic in dictArray{
                let model : Model = Model(dict: dic)
                self.modelArr.append(model)
            }
            self.collectionView?.reloadData()
        }) { (task : URLSessionDataTask?, error : Error) in
            
        }
    }
}
extension HomeViewController{
    fileprivate func setUpLayout(fowLayout : UICollectionViewFlowLayout){
        let margin = CGFloat(10)
        let numOfRow = CGFloat(3)
        let itemW = (ScreenW - (numOfRow + CGFloat(1)) * margin) / 3.0
        flowLayout.itemSize = CGSize(width: itemW, height: itemW * 1.3)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = margin
        flowLayout.minimumInteritemSpacing = 0
        collectionView?.contentInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
}

extension HomeViewController{
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(modelArr.count)
        
        return modelArr.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RRCell
        
        cell.backgroundColor = UIColor.red
        let model = modelArr[indexPath.row]
        cell.model = model
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let model = modelArr[indexPath.row]
        let detailVC = DetailVC()
        detailVC.modelArr = modelArr
//        detailVC.modalTransitionStyle = .crossDissolve
        detailVC.modalPresentationStyle = .custom
        detailVC.scrollToIndexRow = indexPath
        // 设置转场动画代理
        detailVC.transitioningDelegate = animation
        self.detailVC = detailVC
        present(detailVC, animated: true, completion: nil)
    }

}
extension HomeViewController : dismissAnimationDelegate{
    // 做消失动画的视图
    func dismissAnimationView() -> UIView{
        // 取出当前的model
        let currentModel : Model = modelArr[self.detailVC?.currentIndex ?? 0]
        // 创建一个uiimage
        let image = UIImageView()
        guard let url = URL(string: currentModel.hd_thumb_url) else {return UIView()}
        image.kf.setImage(with: url)
        return image
    }
    // 消失动画的开始位置
    func dismissAnimationFromFrame() -> CGRect{
        return ScreenBounds
    }
    // 消失动画结束的位置
    func dismissAnimationToFrame() -> CGRect{
        let currentIndex = IndexPath(item: self.detailVC?.currentIndex ?? 0, section: 0)
        // 取出当前的cell
        guard let cell = collectionView?.cellForItem(at: currentIndex) else{return CGRect.zero}
        // 取出cell当前的坐标
        return collectionView?.convert(cell.frame, to: UIApplication.shared.keyWindow!) ?? CGRect.zero
    }
}
extension HomeViewController : presentAnimationDelegate{
    func presentAnimationView() -> UIView {
        // 取出当前选中的cell的indexpath
        guard let currentIndex = collectionView?.indexPathsForSelectedItems?.first else {return UIView()}
        // 取出当前的model
        let currentModel : Model = modelArr[currentIndex.row]
        // 创建一个uiimage
        let image = UIImageView()
        guard let url = URL(string: currentModel.hd_thumb_url) else {return UIView()}
        image.kf.setImage(with: url)
        return image
        
    }
    func presentAnimationFromFrame() -> CGRect {
        // 取出当前选中的cell的indexpath
        guard let currentIndex = collectionView?.indexPathsForSelectedItems?.first else {return CGRect.zero}
        // 取出当前的cell
        guard let cell = collectionView?.cellForItem(at: currentIndex) else{return CGRect.zero}
        // 取出cell当前的坐标
        return collectionView?.convert(cell.frame, to: UIApplication.shared.keyWindow!) ?? CGRect.zero
    }
    func presentAnimationToFrame() -> CGRect {
        return ScreenBounds
    }
}
