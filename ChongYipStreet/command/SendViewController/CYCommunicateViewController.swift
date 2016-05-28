//
//  CYCommunicateViewController.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/2/6.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYCommunicateViewController: CYSBaseViewController,CYCustomSegmentedViewDelegate,CYCustomButtonsDelegate {
    
    let kIdentifier : String = "CommunicateCell"
    
    let kSegmentedTitles : Array<String> = [CYNSLocalizedString("联系人"),CYNSLocalizedString("群组")]
    let kSubTitles : Array<String> = [CYNSLocalizedString("消息"),CYNSLocalizedString("联系"),CYNSLocalizedString("动态")]
    let kSubImages : Array<String> = ["cang","cang","cang"]
    
    let tableView     = UITableView()
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

    }
    func initLayoutView(){
        
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.segmentedView)
        self.view.addSubview(self.customButtons)

        self.segmentedView.setTitleInfos(kSegmentedTitles, delegate : self)
        self.customButtons.setButtonInfo(CGSize(width: 40,height: 40) , titles: kSubTitles, images: kSubImages,delegate: self)

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
            make.top.equalTo(segmentedView.snp_bottom).offset(0)
        }
        self.customButtons.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(64)
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.top.equalTo(self.tableView.snp_bottom).offset(0)
        }
        
        self.tableViewReloadData()
    }
    func initNavigationBar(){

        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        titleLable.textAlignment = .Center
        titleLable.textColor = UIColor.whiteColor()
        titleLable.font = UIFont.systemFontOfSize(17)
        titleLable.text = CYNSLocalizedString("交流圈")
        
        self.navigationItem.titleView = titleLable
        self.navigationItem.rightBarButtonItems =
            [UIBarButtonItem(title: CYNSLocalizedString("添加"), style: .Plain, target: self, action: "actionAdd:"),
             UIBarButtonItem(image: UIImage(named: "search"), style: .Plain, target: self, action: "actionSearch:") ]
    }
    

    //MARK:- FooterToorbarEvent
    
    
    //MARK:- NavigationEvent
    func actionMessage(messageItem : UIBarButtonItem){
        
    }
    func actionAdd(addItem : UIBarButtonItem){
        
    }
    func actionSearch(searchItem : UIBarButtonItem){
        
    }
    //MARK:- CYCustomSegmentedViewDelegate、CYCustomButtons
    func customSegmentedView(segmentedView: CYCustomSegmentedView, selectIndex: Int) {
        

    }
    
    func customButtons(customButton: CYCustomButtons, selectIndex: Int) {
        
    }
    
}

//MARK:- TableViewDelegate
extension CYCommunicateViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableViewReloadData(){
        if false{
            self.tableView.separatorStyle = .None
        }
        else{
            self.tableView.separatorStyle = .SingleLine
        }
        

        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
    }

}
