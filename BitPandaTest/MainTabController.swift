//
//  MainTabController.swift
//  BitPandaTest
//
//  Created by Abbas on 2/15/21.
//

import UIKit

class MainTabController : UITabBarController, UITabBarControllerDelegate {
    var assetsVC : TabsViewController?
    var walletsVC : TabsViewController?
    var overallVC: TabsViewController?
    
    var coordinator : MainCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setCoordinator(coordinator: MainCoordinator){
        self.coordinator = coordinator
        
        initializeVCs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (traitCollection.userInterfaceStyle == .dark){
            UITabBar.appearance().tintColor = .white
        }
    }
    
    func initializeVCs(){
        guard let coordinator = self.coordinator else {return}
        
        let assetsVC = coordinator.provideAssetsTabViewController()
        let walletsVC = coordinator.provideWalletsTabViewController()
        let overallVC = coordinator.provideOverallTabViewController()

        self.assetsVC = assetsVC
        self.walletsVC = walletsVC
        self.overallVC = overallVC
        
        setViewControllers([assetsVC,walletsVC,overallVC], animated: true)
    }
}
