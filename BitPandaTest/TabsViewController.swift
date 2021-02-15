//
//  ViewController.swift
//  BitPandaTest
//
//  Created by Abbas on 2/11/21.
//

import UIKit
import Tabman
import Pageboy

class TabsViewController: TabmanViewController {
    
    private var viewControllers : [UIViewController] = []
    private var vcNames: [String] = []

    
    func setViewControllers(vcs:[UIViewController]){
        self.viewControllers = vcs
        self.dataSource = self
    }
    
    func setVCNames(names: [String]){
        self.vcNames = names
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        addTopBar()
    }
    
    func addTopBar(){
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.contentMode = .fit
        switch traitCollection.userInterfaceStyle {
            case .dark:
                bar.buttons.customize{ (btn) in
                    btn.selectedTintColor = bar.indicator.tintColor
                    btn.tintColor = .gray
                    btn.selectedTintColor = .white
                    //btn.font = .systemFont(ofSize: 10)
                }
            default:
                bar.buttons.customize{ (btn) in
                    btn.selectedTintColor = bar.indicator.tintColor
                    btn.tintColor = .gray
                    //btn.font = .systemFont(ofSize: 10)
                }
        }
        addBar(bar.systemBar(), dataSource: self, at: .top)
        
    }
}

extension TabsViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        guard vcNames.count > index else {return TMBarItem(title:"Tab\(index)")}
        return TMBarItem(title: vcNames[index])
    }
}


