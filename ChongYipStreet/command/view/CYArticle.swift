//
//  CYArticle.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/5/7.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYArticle: NSObject {
    
    var userId : String = ""     //文章id
    var articleId : String = ""  //文章发起人id
    
    var title      : String = "" //标题
    var origin     : String = "" //出处
    var content    : String = "" //内容
    var updateTime : String = "" //发布时间
    
    var collect : Int = 0  //收藏数
    var comment : Int = 0  //评论数
    var support : Int = 0  //点赞数
    var dislike : Int = 0  //不喜欢数
    
    class func reInit(info : [String : AnyObject]) -> CYArticle{
        
        let article = CYArticle()
        article.userId     = info["user_id"] as? String ?? ""
        article.articleId     = info["article_id"] as? String ?? ""
        
        article.title      = info["article_title"] as? String ?? ""
        article.origin     = info["article_origin"] as? String ?? ""
        article.content    = info["article_content"] as? String ?? ""
        article.updateTime = info["update_time"] as? String ?? ""
        
        article.collect    = info["article_collect_numbers"] as? Int ?? 0
        article.support    = info["article_support_numbers"] as? Int ?? 0
        article.dislike    = info["article_dislike_numbers"] as? Int ?? 0
        article.comment    = info["article_comment_numbers"] as? Int ?? 0
        return article
    }
}
