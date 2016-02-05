//
//  CSYHttpManager.swift
//  ChongYipStreet
//
//  Created by David Yu on 28/1/16.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private let manager = CSYHttpManager()
private let HostURL = "http://www.51qnz.cn/"      // 公司域名

class CSYHttpManager: NSObject {
    //创建单例
    class var shareInstance: CSYHttpManager {
        get {
            return manager
        }
    }
    
    //设置请求头
    func settingRequestHead() -> [String: String] {
        var head = [String: String]()
        
        return head
    }

    //根据状态回调block
    func responseObjectParser(response: Response<AnyObject, NSError>, successClosure: (data: AnyObject) -> Void, otherErrorClosure: (data: AnyObject) -> Void, failureClosure: (data: AnyObject) -> Void) {
        if let data = response.result.value {
            if Int(JSON(data)["code"].stringValue) == 200 {
                print("成功============")
                successClosure(data: data)
            }else {
                print("失败============")
                otherErrorClosure(data: data)
            }
        }
        if let error = response.result.error {
            failureClosure(data: error)
        }
    }
    
    /*======登录=====*/
    func requestLogin(parameters: [String: String]?, successClosure: (data: AnyObject) -> Void, otherErrorClosure: (data: AnyObject) -> Void, failureClosure: (data: AnyObject) -> Void) {
        Alamofire.request(.POST, HostURL+Login_Method, parameters: parameters, encoding: .JSON, headers: settingRequestHead()).responseJSON(options: .MutableContainers) { (response) -> Void in
            self.responseObjectParser(response, successClosure: successClosure, otherErrorClosure: otherErrorClosure, failureClosure: failureClosure)
        }
    }


}
