//
//  CYProject.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/5/7.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYProject: NSObject {
    
    var teamNumber : Int = 0
    var teamID     : String = "" //团队Id
    var targetUser : String = "" //目标用户
    
    var userId     : String = "" //项目id
    var projectId  : String = "" //项目发起人id

    var title      : String = "" //标题
    var light      : String = "" //项目亮点
    
    var updateTime : String = "" //发布时间
    
    class func reInit(info : [String : AnyObject]) -> CYProject{
        
        let project = CYProject()
        
        project.teamNumber = info["team_numbers"] as? Int ?? 0
        project.teamID     = info["team_id"] as? String ?? ""
        project.targetUser = info["target_user"] as? String ?? ""
        
        project.userId     = info["user_id"] as? String ?? ""
        project.projectId  = info["project_id"] as? String ?? ""
  
        project.title      = info["project_title"] as? String ?? ""
        project.light      = info["project_light"] as? String ?? ""
        project.updateTime = info["update_time"] as? String ?? ""
        

        return project
    }
}
