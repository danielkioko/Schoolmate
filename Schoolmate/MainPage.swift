//
//  MainPage.swift
//  Schoolmate
//
//  Created by Daniel Nzioka on 9/23/20.
//

import Foundation
import UIKit

class MainPage: UIViewController, WormTabStripDelegate {
    
    var currentTab = 0
    
    var tabs:[UIViewController] = [
        UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "AssignmentsVC") as! AssignmentsVC,
        UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "MoreVC")
    ]
    
    var allViews:[UIViewController] = []
        
    func setUpViewPager(){
        let frame =  CGRect(x: 0, y: 40, width: self.view.frame.size.width, height: self.view.frame.size.height - 40)
        let viewPager:WormTabStrip = WormTabStrip(frame: frame)
        self.view.addSubview(viewPager)
        viewPager.delegate = self
        viewPager.eyStyle.wormStyel = .line
        viewPager.eyStyle.isWormEnable = true
        viewPager.eyStyle.spacingBetweenTabs = 15
        viewPager.eyStyle.dividerBackgroundColor = .white
        viewPager.eyStyle.tabItemSelectedColor = #colorLiteral(red: 0.9133356214, green: 0.4596616626, blue: 0.3209186196, alpha: 1)
        viewPager.eyStyle.tabItemDefaultColor = #colorLiteral(red: 0.967738688, green: 0.7120885849, blue: 0.5840174556, alpha: 1)
        viewPager.eyStyle.WormColor = #colorLiteral(red: 0.9133356214, green: 0.4596616626, blue: 0.3209186196, alpha: 1)
        viewPager.eyStyle.topScrollViewBackgroundColor = .white
        viewPager.currentTabIndex = 0
        viewPager.buildUI()
    }
    
    func setUpTabs(){
        for i in tabs {
            let vc = i
            allViews.append(vc)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpTabs()
        setUpViewPager()
    }
    
    func wtsNumberOfTabs() -> Int {
        return tabs.count
    }
    
    func wtsViewOfTab(index: Int) -> UIView {
        return allViews[index].view
    }
    
    func wtsTitleForTab(index: Int) -> String {
        switch index {
        case 0:
            return "Assignments"
        case 1:
            return "More"
        default:
            return "No Page"
        }
    }
    
    func wtsDidSelectTab(index: Int) {
        return currentTab = index
    }
    
    func wtsReachedLeftEdge(panParam: UIPanGestureRecognizer) {
    }
    
    func wtsReachedRightEdge(panParam: UIPanGestureRecognizer) {
    }
    
}
