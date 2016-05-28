//
//  CYPost.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/5/7.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYPost: NSObject {
    
    var userId : String = ""  //帖子id
    var postId : String = ""  //帖子发起人id

    var title      : String = "" //标题
    var origin     : String = "" //出处
    var content    : String = "" //内容
    var updateTime : String = "" //发布时间
    
    var collect : Int = 0  //收藏数
    var support : Int = 0  //点赞数
    var comment : Int = 0  //评论数
    
    class func reInit(info : [String : AnyObject]) -> CYPost{
        
        let post = CYPost()
        post.userId     = info["user_id"] as? String ?? ""
        post.postId     = info["posts_id"] as? String ?? ""
        
        post.title      = info["posts_title"] as? String ?? ""
        post.origin     = info["posts_origin"] as? String ?? ""
        post.content    = info["posts_content"] as? String ?? ""
        post.updateTime = info["update_time"] as? String ?? ""

        post.collect    = info["posts_collect_numbers"] as? Int ?? 0
        post.support    = info["posts_support_numbers"] as? Int ?? 0
        post.comment    = info["posts_comment_numbers"] as? Int ?? 0
        return post
    }
}
