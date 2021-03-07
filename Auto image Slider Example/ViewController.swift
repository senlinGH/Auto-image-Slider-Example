//
//  ViewController.swift
//  Auto image Slider Example
//
//  Created by Lin Yi Sen on 2021/3/6.
//  Copyright © 2021 Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    
    let airJordanArr = ["aj1", "aj2", "aj3", "aj4", "aj5"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        
        // 設定CollectionView的高度約束跟Cell高度一樣
        let screenWidth = UIScreen.main.bounds.width
        collectionHeight.constant = screenWidth / 1.5
        
        // 針對Collectionview的item約束
        let flowLayout = sliderCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let width = screenWidth  // 畫面的寬
        let height = width / 1.5
        flowLayout?.itemSize = CGSize(width: width, height: height)
        flowLayout?.minimumLineSpacing = 0  //圖片間距0
        flowLayout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        airJordanArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sliderCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SliderCell
        cell.sliderImage.image = UIImage(named: airJordanArr[indexPath.row])
        
        return cell
    }
    
    
    
}

