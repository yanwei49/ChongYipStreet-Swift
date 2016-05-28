//
//  CYUserDetailedViewController.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/2/13.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYUserDetailedViewController: CYSBaseViewController,CYUserHeadViewDelegate,CYCustomSegmentedViewDelegate  {

    enum UserDetailedType{
        case UserDetailed
        case LeaveComments
    }

    let kIdentifier : String = "UserDetailedCell"
    let kLeaveCommentIdentifier : String = "LeaveCommentCell"
    
    let tableView : UITableView = UITableView()
    let segmentedView = CYCustomSegmentedView()
    let headView : CYUserHeadView = CYUserHeadView.initUserHeadView()
    let kSegmentedTitles : Array<String> = [CYNSLocalizedString("介绍"),CYNSLocalizedString("留言区")]
    
    var userDetailedType : UserDetailedType = .UserDetailed

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.translucent = false
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.translucent = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initLayoutView()
        self.initNavigationBar()
    }

    func initLayoutView(){
        
        self.view.addSubview(self.headView)
        self.headView.delegate = self

        self.view.addSubview(segmentedView)
        self.segmentedView.setTitleInfos(kSegmentedTitles, delegate : self)
        
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.registerNib(UINib(nibName: "CYLeaveCommentCell", bundle: nil), forCellReuseIdentifier: kLeaveCommentIdentifier)
        
        self.headView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.height.equalTo(120)
            make.left.right.equalTo(0)
        }
        self.segmentedView.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.left.right.equalTo(0)
            make.top.equalTo(self.headView.snp_bottom).offset(0)
        }
        self.tableView.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.top.equalTo(segmentedView.snp_bottom).offset(0)
        }
        
        self.tableViewReloadData()
    }
    
    func initNavigationBar(){
        
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        titleLable.textAlignment = .Center
        titleLable.textColor = UIColor.whiteColor()
        titleLable.font = UIFont.systemFontOfSize(17)
        titleLable.text = CYNSLocalizedString("用户详情")
        self.navigationItem.titleView = titleLable
    }
    
    //MARK- CYUserHeadViewDelegate
    func goUserHome(userHeadView: CYUserHeadView) {
        let userHomeViewController = CYUserHomeViewController()
        self.navigationController?.pushViewController(userHomeViewController, animated: true)
    }
    //MARK:- CYCustomSegmentedViewDelegate
    func customSegmentedView(segmentedView: CYCustomSegmentedView, selectIndex: Int) {
        
        if selectIndex == 0{
            self.userDetailedType = .UserDetailed
        }else{
            self.userDetailedType = .LeaveComments
        }
        self.tableViewReloadData()
    }

}

//MARK:- TableViewDelegate
extension CYUserDetailedViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableViewReloadData(){

        var number : Int = 0
        switch self.userDetailedType{
        case .UserDetailed:
            number = 3
        case .LeaveComments:
            number = 11
        }
        
        if number <= 0{
            self.tableView.separatorStyle = .None
        }
        else{
            self.tableView.separatorStyle = .SingleLine
        }
        
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number : Int = 0
        switch self.userDetailedType{
        case .UserDetailed:
            number = 3
        case .LeaveComments:
            number = 11
        }
        return  number
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch self.userDetailedType{
        case .UserDetailed:
            return 80
        case .LeaveComments:
            return 130
        }
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch self.userDetailedType{
        case .UserDetailed:
            return CYNSLocalizedString("用户项目")
        case .LeaveComments:
            return CYNSLocalizedString("最新留言")
        }
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch self.userDetailedType{
        case .UserDetailed:
            
            let cell = tableView.dequeueReusableCellWithIdentifier(kIdentifier)
                       ?? UITableViewCell(style: .Subtitle, reuseIdentifier: kIdentifier)
            
            cell.textLabel?.font = UIFont.systemFontOfSize(14.0)
            cell.textLabel?.textColor = UIColor.lightGrayColor()
            switch indexPath.item{
            case 0:cell.textLabel?.text = CYNSLocalizedString("个人介绍:")
            case 1:cell.textLabel?.text = CYNSLocalizedString("擅长方面:")
            case 2:cell.textLabel?.text = CYNSLocalizedString("用户需求:")
            default:break;
            }
            
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.text = "撒打算打算打算打算打算的撒打算打算打算打算打算的撒打算打算打算打算打算的撒打算打算打算打算打算的撒打算打算打算打算打算的"
            
            return cell
            
        case .LeaveComments:
            
            let cell = tableView.dequeueReusableCellWithIdentifier(kLeaveCommentIdentifier, forIndexPath: indexPath)
            if let leaveCommentCell = cell as? CYLeaveCommentCell{
                //leaveCommentCell.userImageView.image = UIImage(named: "")
                leaveCommentCell.userName.text = "小考拉"
                leaveCommentCell.userLevel.text = "LV." + "总裁夫人"
                leaveCommentCell.contentLabel.text = "如果不能简洁明了的表达出来，就说明你理解的不够透彻"
                leaveCommentCell.likeButton.setTitle("88", forState: .Normal)
                leaveCommentCell.shoucanButton.setTitle("999", forState: .Normal)
            }
            return cell
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.tableViewReloadData()
    }
    

}