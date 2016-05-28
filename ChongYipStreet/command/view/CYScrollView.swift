//
//  CYScrollView.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/5/7.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYScrollView: UIView{
    
    let scrollView  = UIScrollView()
    let pageControl = UIPageControl()
    
    var imageViews = [UIImageView]()
    var checkBlock : ((Int) -> Void)? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init() {
        
        super.init(frame: CGRectMake(0, 0, 0, 0))
        self.addSubview(scrollView)
        self.addSubview(pageControl)
        
        self.scrollView.delegate = self
        self.scrollView.pagingEnabled = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        
        self.scrollView.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(0)
            make.left.right.equalTo(0)
        }
        self.pageControl.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(120)
            make.height.equalTo(30)
            make.bottom.equalTo(-10)
            make.centerX.equalTo(self)
        }
        
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = 1
        self.pageControl.addTarget(self, action: "actionChangeValue:", forControlEvents: UIControlEvents.ValueChanged)
    }


    func setImages(images : [String]){
        
        for imageView in self.imageViews{
            imageView.removeFromSuperview()
        }
        self.imageViews.removeAll()
        
        for i in 0...images.count - 1{
            
            let imageView = UIImageView()
            self.imageViews.append(imageView)
            self.scrollView.addSubview(imageView)
            
            imageView.snp_makeConstraints(closure: { (make) -> Void in
                make.centerY.equalTo(self.scrollView)
                make.centerX.equalTo(self.scrollView).multipliedBy(i * 2 + 1)
                make.width.height.equalTo(self.scrollView)
            })

            if let url = NSURL(string: images[i]){
                imageView.sd_setImageWithURL(url)
            }
            imageView.tag = i
            imageView.userInteractionEnabled = true
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "actionTaoGesture:") )
        }
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = images.count
        self.scrollView.contentSize = CGSizeMake(screenWidth() * CGFloat(images.count), 200)
    }
    
    func actionChangeValue(pageControle : UIPageControl){
        self.scrollView.setContentOffset(CGPointMake(CGFloat(pageControl.currentPage) * screenWidth(), 0), animated: true)
    }
    func actionTaoGesture(tapGesture : UITapGestureRecognizer){
        if let view = tapGesture.view{
            self.checkBlock?(view.tag)
        }
    }
}

extension CYScrollView : UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x / screenWidth())
    }

}
