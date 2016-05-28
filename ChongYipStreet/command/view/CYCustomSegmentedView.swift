//
//  CYCustomSegmentedView.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/2/5.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

protocol CYCustomSegmentedViewDelegate : NSObjectProtocol{
    func customSegmentedView(segmentedView : CYCustomSegmentedView, selectIndex : Int)
}

class CYCustomSegmentedView: UIView {

    var selectIndex : Int = 0
    private var selectView : UIView = UIView()
    
    private var titles : Array<String> = Array()
    private var titleItems : Array<UIButton> = Array()
    
    var delegate : CYCustomSegmentedViewDelegate? = nil
    
    var selectCenterXConstraint : NSLayoutConstraint? = nil
    
    func setTitleInfos( titles : Array<String>, delegate : CYCustomSegmentedViewDelegate){
        self.titles = titles
        self.delegate = delegate
        self.initLayoutTitles()
    }

    private func initLayoutTitles(){
        
        self.selectView.backgroundColor = appMainColor
        self.addSubview(self.selectView)
        for index in 0 ..< self.titles.count{
            
            let title = self.titles[index]
            let titleButton = UIButton(type: .System)
            
            titleButton.tag = index + 1024
            titleButton.setTitle(CYNSLocalizedString(title), forState: .Normal)
            titleButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
            titleButton.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
            
            titleButton.addTarget(self, action: "actionTouchUpInside:", forControlEvents: .TouchUpInside)
            
            self.addSubview(titleButton)
            self.titleItems.append(titleButton)
        }
        
        self.shouldView()
    }

    private func shouldView(){
        
        var views : [String:AnyObject] = Dictionary()
        var stringFormat = "H:|"
        
        for index in 0 ..< self.titleItems.count{
            
            let titleButton = self.titleItems[index]
            
            titleButton.translatesAutoresizingMaskIntoConstraints = false
            
            let titleButtonVConstraints  = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[titleButton]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["titleButton":titleButton])
            
            self.addConstraint(NSLayoutConstraint(item: titleButton, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1.0 / CGFloat(self.titleItems.count), constant: 0))
            self.addConstraints(titleButtonVConstraints)
            
            stringFormat += "-0-[titleButton\(index)]"
            views["titleButton\(index)"] = titleButton
        }
        stringFormat += "-0-|"
        let titleButtonHConstraints  = NSLayoutConstraint.constraintsWithVisualFormat(stringFormat, options: .DirectionLeadingToTrailing, metrics: nil, views: views)
        self.addConstraints(titleButtonHConstraints)
        
        self.selectView.translatesAutoresizingMaskIntoConstraints = false
        let selectViewConstraints =
        [NSLayoutConstraint(item: selectView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: selectView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 2),
            NSLayoutConstraint(item: selectView, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1.0 / CGFloat(self.titleItems.count), constant: 0)]
        
        self.addConstraints(selectViewConstraints)
        self.selectCenterXConstraint = NSLayoutConstraint(item: self.selectView, attribute: .CenterX, relatedBy: .Equal, toItem: self.titleItems[0], attribute: .CenterX, multiplier: 1.0, constant: 0)
        if let layoutConstraint = self.selectCenterXConstraint{
            self.addConstraint(layoutConstraint)
        }
    }
    private func shouldSelectView(index : Int){
        
        if let layoutConstraint = self.selectCenterXConstraint{
            self.removeConstraint(layoutConstraint)
        }
        self.selectCenterXConstraint = NSLayoutConstraint(item: self.selectView, attribute: .CenterX, relatedBy: .Equal, toItem: self.titleItems[index], attribute: .CenterX, multiplier: 1.0, constant: 0)
        if let newLayoutConstraint = self.selectCenterXConstraint{
            self.addConstraint(newLayoutConstraint)
        }
        UIView.animateWithDuration(0.3) { () -> Void in
            self.layoutIfNeeded()
        }
    }
    
    func actionTouchUpInside(button : UIButton){
        
        self.selectIndex = button.tag - 1024
        
        self.shouldSelectView(self.selectIndex)
        self.delegate?.customSegmentedView(self, selectIndex: self.selectIndex)
    }
    



}
