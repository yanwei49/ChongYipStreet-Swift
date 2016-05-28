//
//  CYScheme.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/5/7.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYScheme: NSObject {
    var userId : String = ""     //方案id
    var schemeId : String = ""  //方案发起人id
    
    var title      : String = "" //标题
    var origin     : String = "" //出处
    var content    : String = "" //内容
    var updateTime : String = "" //发布时间
    
    var collect : Int = 0  //收藏数
    var support : Int = 0  //点赞数
    var dislike : Int = 0  //不喜欢数
    
    class func reInit(info : [String : AnyObject]) -> CYScheme{
        
        let scheme = CYScheme()
        scheme.userId     = info["user_id"] as? String ?? ""
        scheme.schemeId     = info["scheme_id"] as? String ?? ""
        
        scheme.title      = info["scheme_title"] as? String ?? ""
        scheme.origin     = info["scheme_origin"] as? String ?? ""
        scheme.content    = info["scheme_content"] as? String ?? ""
        scheme.updateTime = info["update_time"] as? String ?? ""
        
        scheme.collect    = info["scheme_collect_numbers"] as? Int ?? 0
        scheme.support    = info["scheme_support_numbers"] as? Int ?? 0
        scheme.dislike    = info["scheme_dislike_numbers"] as? Int ?? 0
        return scheme
    }
}
