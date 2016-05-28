//
//  CYSMineMediaController.swift
//  ChongYipStreet
//
//  Created by xie on 16/2/28.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYSMineMediaAndPostController : CYSBaseViewController,CYCustomSegmentedViewDelegate {
    
    let kSeekUserIdentifier : String = "SeekUserCell"
    let kSeekPostIdentifier : String = "SeekPostCell"
    let kSegmentedTitles : Array<String> = [CYNSLocalizedString("帖子"),CYNSLocalizedString("方案"),CYNSLocalizedString("文章")]
    
    var selectIndex : Int = 0
    
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

        self.tableView.registerNib(UINib(nibName: "CYSeekPostCell", bundle: nil), forCellReuseIdentifier: kSeekPostIdentifier)
        self.tableView.registerNib(UINib(nibName: "CYSeekUserCell", bundle: nil), forCellReuseIdentifier: kSeekUserIdentifier)
        
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
extension CYSMineMediaAndPostController : UITableViewDelegate,UITableViewDataSource{
    
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
        return selectIndex == 0 ? 130 : 120
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(selectIndex == 0 ? kSeekPostIdentifier : kSeekUserIdentifier, forIndexPath: indexPath)
        
        if let seekPostCell = cell as? CYSeekPostCell{
            seekPostCell.contentImageView.image = UIImage(named: "201510296120828674")
            seekPostCell.typeLabel.text = "我"
            seekPostCell.titleLable.text = "我我我我我我我我我"
            seekPostCell.contentLabel.text = "我我我我我我我我"
            seekPostCell.likeButton.setTitle("110", forState: .Normal)
            seekPostCell.shoucanButton.setTitle("8888", forState: .Normal)
        }
        
        if let seekUserCell = cell as? CYSeekUserCell{
            seekUserCell.userImageView.image = UIImage(named: "201510296120828674")
            seekUserCell.nameLabel.text = "我"
            seekUserCell.pContentLabel.text = "我我我我我我我我"
            seekUserCell.rContentLabel.text = "我我我我我我我我"
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if selectIndex == 0{
            
        }else{
            let userDetailedViewController = CYUserDetailedViewController()
            self.navigationController?.pushViewController(userDetailedViewController, animated: true)
        }
    }
    
}
