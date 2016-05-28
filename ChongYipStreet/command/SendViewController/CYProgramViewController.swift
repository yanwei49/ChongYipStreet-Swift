//
//  CYProgramViewController.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/2/7.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYProgramViewController: CYSBaseViewController,CYCustomSegmentedViewDelegate{

    let kProgramIdentifier : String = "ProgramCell"
    let kProjectIdentifier : String = "ProjectCell"
    
    var selectIndex : Int = 0
    let kSegmentedTitles : Array<String> = [CYNSLocalizedString("方案"),CYNSLocalizedString("项目")]
    
    let tableView     = UITableView()
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
        self.segmentedView.setTitleInfos(kSegmentedTitles, delegate : self)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        
        self.tableView.registerNib(UINib(nibName: "CYProjectCell", bundle: nil), forCellReuseIdentifier: kProjectIdentifier)
        self.tableView.registerNib(UINib(nibName: "CYProgramCell", bundle: nil), forCellReuseIdentifier: kProgramIdentifier)
        
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
        
        self.tableViewReloadData()
    }
    func initNavigationBar(){
        
        let segmentedControl : UISegmentedControl = UISegmentedControl(items: [CYNSLocalizedString("热门"),CYNSLocalizedString("筛选")])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: "updateTitleIndex:", forControlEvents: .ValueChanged)
        self.navigationItem.titleView = segmentedControl
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .Plain, target: self, action: "actionSearch:")
    }
    
    
    //MARK:- NavigationEvent
    func updateTitleIndex(segmentedControl : UISegmentedControl){
        if segmentedControl.selectedSegmentIndex == 0{
        }
        else{
            
        }
    }
    
    
    //MARK:- NavigationEvent
    func actionMessage(messageItem : UIBarButtonItem){
        
    }
    func actionAdd(addItem : UIBarButtonItem){
        
    }
    func actionSearch(searchItem : UIBarButtonItem){
        
    }
    //MARK:- CYCustomSegmentedViewDelegate、CYCustomButtons
    func customSegmentedView(segmentedView: CYCustomSegmentedView, selectIndex: Int) {
        
        self.selectIndex = selectIndex
        self.tableViewReloadData()
    }
    
}

//MARK:- TableViewDelegate
extension CYProgramViewController : UITableViewDelegate,UITableViewDataSource{
    
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier(selectIndex == 0 ? kProgramIdentifier : kProjectIdentifier, forIndexPath: indexPath)
        
        if let programCell = cell as? CYProgramCell{

            programCell.typeLabel.text = "小白"
            programCell.titleLable.text = "撒打算几点回家卡圣诞节喀什的空间啊是贷款计划"
            programCell.contentLabel.text = "撒打算几点回家卡圣诞节喀什的空间啊是贷款计划"
            programCell.likeButton.setTitle("110", forState: .Normal)
            programCell.shoucanButton.setTitle("8888", forState: .Normal)
        }
        else if let projectCell = cell as? CYProjectCell{
            
            projectCell.typeLabel.text = "饮食"
            projectCell.typeImageView.image = UIImage(named: "cang")
            projectCell.contentLabel.text = "撒打算几点回家卡圣诞节喀什的空间啊是贷款计划"
            projectCell.contentImageView.image = UIImage(named: "201510296120828674")
            projectCell.likeButton.setTitle("110", forState: .Normal)
            projectCell.shoucanButton.setTitle("8888", forState: .Normal)
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
