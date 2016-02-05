//
//  CYSParser.swift
//  ChongYipStreet
//
//  Created by David Yu on 28/1/16.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit
import SwiftyJSON

private let manager = CYSParser()

class CYSParser: NSObject {
    //创建单例
    class var shareInstance: CYSParser {
        get {
            return manager
        }
    }

    func userWithData(data: JSON) -> CYSUserModel {
        let user = CYSUserModel()
        user.userName = data["userName"].stringValue
        user.userId = data["userId"].stringValue
        user.portraitUri = data["portraitUri"].stringValue
        user.account = data["account"].stringValue
        user.password = data["password"].stringValue
        user.name = data["name"].stringValue
        user.sex = data["sex"].stringValue
        user.brithday = data["brithday"].stringValue
        user.telephone = data["telephone"].stringValue
        user.address = data["address"].stringValue
        user.infos = data["infos"].stringValue
        user.scoring = data["scoring"].stringValue
        user.rank = data["rank"].stringValue
        user.email = data["email"].stringValue
        user.age = data["age"].stringValue
        
        return user
    }

}
