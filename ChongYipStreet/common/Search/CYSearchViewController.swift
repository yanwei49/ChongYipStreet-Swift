//
//  CYSearchViewController.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/2/13.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYSearchViewController: CYSBaseViewController,CYCustomSegmentedViewDelegate {

    let kSegmentedTitles : Array<String> = [CYNSLocalizedString("帖子"),CYNSLocalizedString("用户")]
    
    let segmentedView = CYCustomSegmentedView()
    let searchController : UISearchController = UISearchController(searchResultsController: nil)
    
    enum SearchState{
        case Ordinary
        case Search
    }
    
    var searchState : SearchState = .Ordinary
    var searchDatas : Array<String> = Array()
    
    
    deinit{
        self.searchController.view.removeFromSuperview()
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

    func initNavigationBar(){
        
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.translucent = true;
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.hidesNavigationBarDuringPresentation = false
        
        self.navigationItem.titleView = self.searchController.searchBar
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .Plain, target: self, action: "actionSearch:")
    }
    
    
    func initLayoutView(){
        
        self.view.addSubview(self.segmentedView)
        self.segmentedView.setTitleInfos(kSegmentedTitles, delegate : self)
        
        self.segmentedView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.height.equalTo(40)
            make.left.right.equalTo(0)
            
        }
    }
    
    //MARK:- CYCustomSegmentedViewDelegate
    func customSegmentedView(segmentedView: CYCustomSegmentedView, selectIndex: Int) {
        
 
    }

}

extension CYSearchViewController : UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate{
    
    func getSearchingFiles(searchText : String){
        
        self.searchDatas.removeAll()
        
        if !searchText.isEmpty{
//            for fileInfo in self.service.allFiles{
//                var fileName = ""
//                if let fileFolder = fileInfo as? FileFolder{
//                    fileName = fileFolder.folderName.uppercaseString
//                }
//                else if let attachment = fileInfo as? Attachment{
//                    fileName = attachment.itemName.uppercaseString
//                }
//                if fileName.rangeOfString(searchText.uppercaseString)?.isEmpty ?? true{
//                    continue
//                }
//                self.searchDatas.append(fileInfo)
//            }
        }
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchState = .Search
        self.searchDatas.removeAll()
        self.searchController.searchBar.showsCancelButton = true
        
        //self.tableViewReloadData()
    }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        self.searchState = .Ordinary
        self.searchController.searchBar.text = ""
        self.searchController.searchBar.resignFirstResponder()
        self.searchController.searchBar.showsCancelButton = false;
        
        //self.tableViewReloadData()
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.getSearchingFiles(searchText)
        //self.tableViewReloadData()
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchController.searchBar.resignFirstResponder()
    }
    
    func presentSearchController(searchController: UISearchController) {
    }
    func updateSearchResultsForSearchController(searchController: UISearchController) {
    }
}

