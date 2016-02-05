//
//  constParams.swift
//  J0Task
//
//  Created by WanJianying on 1/15/16.
//  Copyright © 2016 解铃网. All rights reserved.
//

import UIKit

let DocumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
let LibCacheDirectoryPath = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).first!
let TmpDirectoryPath = NSTemporaryDirectory()

public func screenWidth() -> CGFloat{
    return UIScreen.mainScreen().bounds.width
}

public func screenHeight() -> CGFloat{
    return UIScreen.mainScreen().bounds.height
}

public func isIphone() -> Bool {
    
    if UIDevice.currentDevice().model.rangeOfString("iPhone", options: .CaseInsensitiveSearch, range: UIDevice.currentDevice().model.characters.indices, locale: nil) != nil {
        
        return true
    }
    else {
        return false
    }
}

public func isIpad() -> Bool {
    
    if UIDevice.currentDevice().model.rangeOfString("iPad", options: .CaseInsensitiveSearch, range: UIDevice.currentDevice().model.characters.indices, locale: nil) != nil {
        
        return true
    }
    else {
        return false
    }
}

public func CYNSLocalizedString(key: String!) -> String! {
    return NSLocalizedString(key, comment: "")
}








