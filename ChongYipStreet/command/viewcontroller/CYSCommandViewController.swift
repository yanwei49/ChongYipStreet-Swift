//
//  CYSCommandViewController.swift
//  ChongYipStreet
//
//  Created by David Yu on 28/1/16.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYSCommandViewController: CYSBaseViewController,CYCustomSegmentedViewDelegate {
    
    let commandService = CYCommandService()
    
    let kIdentifier : String = "CommandCell"
    
    let kSegmentedTitles : Array<String> = [CYNSLocalizedString("全部"),CYNSLocalizedString("经验"),CYNSLocalizedString("相关"),CYNSLocalizedString("方案")]
    let kSubTitles : Array<String> = [CYNSLocalizedString("寻找"),CYNSLocalizedString("找方法"),CYNSLocalizedString("找团队"),CYNSLocalizedString("交流圈")]
    let kSubImages : Array<String> = ["cang","cang","cang","cang"]
    
    let tableView     = UITableView()
    let headerView    = UIView(frame: CGRectMake(0, 0, screenWidth(), screenWidth() / CGFloat(4)  + 220))
    let scrollView    = CYScrollView()
    let customButtons = CYCustomButtons()
    let segmentedView = CYCustomSegmentedView()
    
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
        self.initLoadingData()
    }
    
    func initLoadingData(){
        self.showHeaderView(self.commandService.commandType)
        self.commandService.loadGetCommandData(self.commandService.commandType)
    }
    func initLayoutView(){
        
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.segmentedView)
        self.segmentedView.setTitleInfos(kSegmentedTitles, delegate : self)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib(nibName: "CYCommandCell", bundle: nil), forCellReuseIdentifier: kIdentifier)
        
        self.segmentedView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.height.equalTo(40)
            make.left.right.equalTo(0)
            
        }
        self.tableView.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.top.equalTo(segmentedView.snp_bottom).offset(0)
        }
        
        customButtons.setTitleInfo(kSubTitles, images: kSubImages,delegate: self)
        
        headerView.addSubview(scrollView)
        headerView.addSubview(customButtons)
        
        scrollView.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo(0)
            make.height.equalTo(200)
            make.left.right.equalTo(0)
        })
        customButtons.snp_makeConstraints(closure: { (make) -> Void in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.top.equalTo(scrollView.snp_bottom)
        })
        scrollView.checkBlock = {(checkIndex) in
            debugPrint(checkIndex)
        }
        scrollView.setImages(["http://y3.ifengimg.com/dee5ac7c19652025/2015/0520/rdn_555c3157d29e7.jpg","http://y3.ifengimg.com/dee5ac7c19652025/2015/0520/rdn_555c3157d29e7.jpg","http://y3.ifengimg.com/dee5ac7c19652025/2015/0520/rdn_555c3157d29e7.jpg","http://y3.ifengimg.com/dee5ac7c19652025/2015/0520/rdn_555c3157d29e7.jpg"])
        
        self.tableViewReloadData()
    }
    func initNavigationBar(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        let segmentedControl : UISegmentedControl = UISegmentedControl(items: [CYNSLocalizedString("热门"),CYNSLocalizedString("筛选")])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: "updateTitleIndex:", forControlEvents: .ValueChanged)
        self.navigationItem.titleView = segmentedControl
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .Plain, target: self, action: "actionMessage:")
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "search"), style: .Plain, target: self, action: "actionSearch:"),UIBarButtonItem(image: UIImage(named: "my_project.png"), style:.Done, target: self, action: "actionUserHome:")]
    }
    
    //MARK:- NavigationEvent
    func updateTitleIndex(segmentedControl : UISegmentedControl){
        if segmentedControl.selectedSegmentIndex == 0{
        }
        else{
            
        }
    }
    func actionMessage(messageItem : UIBarButtonItem){
        
    }
    
    func actionUserHome(messageItem : UIBarButtonItem){
        let userHomeViewController = CYUserHomeViewController()
        self.navigationController?.pushViewController(userHomeViewController, animated: true)
    }
    func actionSearch(searchItem : UIBarButtonItem){
        let searchViewController = CYSearchViewController()
        searchViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    
    //MARK:- Nocationfi
    func addNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "actionGetCommandDataFailed:", name: kNotificationGetCommandDataFailed, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "actionGetCommandDataSucceed:", name: kNotificationGetCommandDataSucceed, object: nil)
    }
    
    func actionGetCommandDataFailed(notification : NSNotification){
        self.tableViewReloadData()
    }
    
    func actionGetCommandDataSucceed(notification : NSNotification){
        self.tableViewReloadData()
    }
    
    
    //MARK:- CYCustomSegmentedViewDelegate
    func customSegmentedView(segmentedView: CYCustomSegmentedView, selectIndex: Int) {
        
        if selectIndex == self.commandService.commandType.rawValue{
            return
        }
        
        self.commandService.commandType = CommandType(rawValue: selectIndex) ?? CommandType.All
        self.showHeaderView(self.commandService.commandType)
        self.commandService.loadGetCommandData(self.commandService.commandType)
    }
    
}


//MARK:- TableViewDelegate
extension CYSCommandViewController : UITableViewDelegate,UITableViewDataSource,CYCustomButtonsDelegate{
    
    func showHeaderView(commandType : CommandType){
        if commandType == .All {
            //UIImage(named: "201510296120828674")
            self.tableView.tableHeaderView = headerView
        }
        else{
            self.tableView.tableHeaderView = nil
        }
    }
    
    func tableViewReloadData(){
        if self.commandService.getCommandDatasCount() > 0{
            self.tableView.separatorStyle = .None
        }
        else{
            self.tableView.separatorStyle = .SingleLine
        }
        
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commandService.getCommandDatas().count + 10
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kIdentifier, forIndexPath: indexPath)
        
        if let commandCell = cell as? CYCommandCell{
            commandCell.contentImageView.image = UIImage(named: "201510296120828674")
            commandCell.typeLabel.text = "商业"
            commandCell.contentLabel.numberOfLines = 0
            commandCell.contentLabel.text = "撒打算几点回家卡圣诞节喀什的空间啊是贷款计划"
            
            commandCell.likeButton.setTitle("110", forState: .Normal)
            commandCell.shoucanButton.setTitle("8888", forState: .Normal)
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let postViewController = CYPostViewController()
        postViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(postViewController, animated: true)
        
        self.tableViewReloadData()
    }
    
    func customButtons(customButton: CYCustomButtons, selectIndex: Int) {
        switch selectIndex{
        case 0:
            let seekViewController = CYSeekViewController()
            seekViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(seekViewController, animated: true)
        case 1:
            let programViewController = CYProgramViewController()
            programViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(programViewController, animated: true)
        case 2:
            let teamViewController = CYTeamViewController()
            teamViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(teamViewController, animated: true)
        case 3:
            let communicateViewController = CYCommunicateViewController()
            communicateViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(communicateViewController, animated: true)
        default:break
        }
    }
}
