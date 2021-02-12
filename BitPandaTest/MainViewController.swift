//
//  ViewController.swift
//  BitPandaTest
//
//  Created by Abbas on 2/11/21.
//

import UIKit
import Tabman
import Pageboy

class MainViewController: TabmanViewController {
    
    private var viewControllers : [UIViewController] = []
    private var coordinator : MainCoordinator? = nil{
        didSet{
            guard let coordinator = coordinator else {return}
            self.viewControllers = [coordinator.provideAssetViewController(),
                                    coordinator.provideWalletViewController()]
            self.dataSource = self
        }
    }
    
    func setCoordinator(coordinator : MainCoordinator) {
        self.coordinator = coordinator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
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
                    btn.tintColor = .white
                }
            default:
                bar.buttons.customize{ (btn) in
                    btn.selectedTintColor = bar.indicator.tintColor
                    btn.tintColor = .gray
                }
        }
        addBar(bar.systemBar(), dataSource: self, at: .top)
        
    }
}

extension MainViewController: PageboyViewControllerDataSource, TMBarDataSource {

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
        switch index {
            case 0:
                return TMBarItem(title: "Assets")
            default:
                return TMBarItem(title: "Wallets")
        }
    }
}


