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
    
    let airJordanArr = ["aj1", "aj2", "aj3", "aj4", "aj5"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
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

