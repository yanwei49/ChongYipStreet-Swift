//
//  CYCustomButtons.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/2/5.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit
protocol CYCustomButtonsDelegate : NSObjectProtocol{
    func customButtons(customButton : CYCustomButtons, selectIndex : Int)
}
class CYCustomButtons: UIView {
 
    var items : Array<UIButton> = Array()
    var delegate : CYCustomButtonsDelegate? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func setButtonInfo(buttonSize : CGSize,titles : Array<String>, images : Array<String>, delegate : CYCustomButtonsDelegate?){

        self.delegate = delegate
        self.initLayoutView(buttonSize,isCustom: true, titles: titles, images: images)
    }
    
    func setTitleInfo(titles : Array<String>, images : Array<String>, delegate : CYCustomButtonsDelegate?){
        self.delegate = delegate
        self.initLayoutView(CGSize(),isCustom: false, titles: titles, images: images)
    }
    
    private func initLayoutView(buttonSize : CGSize,isCustom : Bool,titles : Array<String>, images : Array<String>){
        
        for index in 0 ..< titles.count{

            let button = UIButton(type: .Custom)
            self.items.append(button)
            button.tag = index + 1024
            button.frame = CGRect(x: 0, y: 0, width: buttonSize.width, height: buttonSize.height + 20)
            button.addTarget(self, action: "actionTouchUpInside:", forControlEvents: .TouchUpInside)
            
            let imageView = UIImageView()
            button.addSubview(imageView)
            imageView.image = UIImage(named: images[index])
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            let imageViewHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[imageView]-5-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["imageView" : imageView])
            let imageViewVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[imageView]-25-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["imageView" : imageView])
            
            let textLabel = UILabel()
            button.addSubview(textLabel)
            textLabel.text = titles[index]
            textLabel.textAlignment = .Center
            textLabel.font = UIFont.systemFontOfSize(14)
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let textLabelHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[textLabel]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["textLabel" : textLabel])
            let textLabelVConstraints =
            [NSLayoutConstraint(item: textLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0, constant: 20),
            NSLayoutConstraint(item: textLabel, attribute: .Bottom, relatedBy: .Equal, toItem: button, attribute: .Bottom, multiplier: 1, constant: 0)]
            
            button.addConstraints(imageViewHConstraints)
            button.addConstraints(imageViewVConstraints)
            button.addConstraints(textLabelVConstraints)
            button.addConstraints(textLabelHConstraints)
        }
        
        if isCustom{
            self.layoutConstraintCustomSize()
            
        }else{
            self.layoutConstraintView()
        }
    }
    
    private func layoutConstraintCustomSize(){
        
        let tooBar = UIToolbar()
        self.addSubview(tooBar)
        tooBar.translatesAutoresizingMaskIntoConstraints = false
        
        let tooBarHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[tooBar]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["tooBar" : tooBar])
        let tooBarVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[tooBar]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["tooBar" : tooBar])
        self.addConstraints(tooBarHConstraints)
        self.addConstraints(tooBarVConstraints)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        var tooBarItems : Array<UIBarButtonItem> = Array()
        for index in 0 ..< self.items.count{
            let button = self.items[index]
            button.autoresizingMask = .FlexibleLeftMargin
            tooBarItems.append(UIBarButtonItem(customView: button))
            tooBarItems.append(flexibleSpace)
        }
        tooBarItems.removeLast()
        tooBar.items = tooBarItems
    }
    
    private func layoutConstraintView(){
        
        var views : [String:AnyObject] = Dictionary()
        var stringFormat = "H:|"
        
        for index in 0 ..< self.items.count{
            
            let button = self.items[index]
            self.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            let buttonVConstraints  = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[button]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["button":button])
            
            self.addConstraint(NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1.0 / CGFloat(self.items.count), constant: 0))
            self.addConstraints(buttonVConstraints)
            
            stringFormat += "-0-[button\(index)]"
            views["button\(index)"] = button
        }
        stringFormat += "-0-|"
        let buttonHConstraints  = NSLayoutConstraint.constraintsWithVisualFormat(stringFormat, options: .DirectionLeadingToTrailing, metrics: nil, views: views)
        self.addConstraints(buttonHConstraints)
    }
    private func shouldCustomWidth(button : CGSize){
    
    }
    
    func getHeight() -> CGFloat{
        return screenWidth() / CGFloat(self.items.count) + 20
    }
    func actionTouchUpInside(button : UIButton){
        self.delegate?.customButtons(self, selectIndex: button.tag - 1024)
    }
    


}
