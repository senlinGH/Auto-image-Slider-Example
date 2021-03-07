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
    var timer: Timer? // 計時器
    var counter = 0 // 計數器
    
    
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
        
        pageControl.numberOfPages = airJordanArr.count  // Page Control 總共頁數
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .link   // 目前所在頁數的點點顏色
        
        /*
         withTimeInterval：觸發Timer的間隔時間
         target：Timer觸發的對象，這邊填入self表示這一個ViewController
         selector：Timer的觸發事件，需填入一個function，這邊填入changeImage()
         userInfo：可作為傳入Timer觸發事件的資料
         repeat：是否重複，若填入false則啟用後只觸發第一次
         */
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func changeImage() {
        if counter < airJordanArr.count {
            let index = IndexPath.init(item: counter, section: 0)
            sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = counter
            counter = 1
            
        }
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    // 離開畫面停止Timer
    // Timer 如同執行緒，若沒停止它的話，它是會一直在背景執行的。所以必須在離開畫面時去停止它。
    override func viewDidDisappear(_ animated: Bool) {
        //  將timer執行緒停止
        if self.timer != nil {
            self.timer?.invalidate() //停止timer的循環
        }
    }
    
}

