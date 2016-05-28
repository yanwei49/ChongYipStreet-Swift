//
//  CYSTribuneViewController.swift
//  ChongYipStreet
//
//  Created by David Yu on 28/1/16.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYSTribuneViewController: CYSBaseViewController,CYCustomSegmentedViewDelegate {
    
    let kIdentifier : String = "TribuneCell"
    
    let kSegmentedTitles : Array<String> = [CYNSLocalizedString("交流"),CYNSLocalizedString("相关"),CYNSLocalizedString("分享"),CYNSLocalizedString("方案")]
    
    
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
        self.tableView.registerNib(UINib(nibName: "CYTribuneCell", bundle: nil), forCellReuseIdentifier: kIdentifier)
        
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
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .Plain, target: self, action: "actionCommand:")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .Plain, target: self, action: "actionSearch:")
    }
    
    //MARK:- NavigationEvent
    func updateTitleIndex(segmentedControl : UISegmentedControl){
        if segmentedControl.selectedSegmentIndex == 0{
        }
        else{
            
        }
    }
    func actionCommand(messageItem : UIBarButtonItem){
        
    }
    func actionSearch(searchItem : UIBarButtonItem){
        let searchViewController = CYSearchViewController()
        searchViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    //MARK:- CYCustomSegmentedViewDelegate
    func customSegmentedView(segmentedView: CYCustomSegmentedView, selectIndex: Int) {
        
        
    }
    
}

//MARK:- TableViewDelegate
extension  CYSTribuneViewController : UITableViewDelegate,UITableViewDataSource{
    
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
        return  10
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kIdentifier, forIndexPath: indexPath)
        
        if let tribuneCell = cell as? CYTribuneCell{
            tribuneCell.contentImageView.image = UIImage(named: "201510296120828674")
            tribuneCell.typeLabel.text = "商业"
            tribuneCell.titleLable.text = "撒打算打算打算打算打算的"
            tribuneCell.contentLabel.text = "撒打算几点回家卡圣诞节喀什的空间啊是贷款计划"
            tribuneCell.likeButton.setTitle("110", forState: .Normal)
            tribuneCell.shoucanButton.setTitle("8888", forState: .Normal)
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
}
