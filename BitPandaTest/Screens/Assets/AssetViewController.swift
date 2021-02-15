//
//  AssetViewController.swift
//  BitPandaTest
//
//  Created by Abbas on 2/11/21.
//

import UIKit
import Floaty

class AssetViewController : UIViewController {
    var viewModel : AssetViewModel?
    var tableView : UITableView?
    var floatyView: Floaty?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView?.reloadData()
    }
    
    func setupView(){
        configTableView()
        if (viewModel?.showFloaty ?? true){
            setupFloaty()
        }
    }
    
    func reloadTableView(){
        guard let tableView = self.tableView else {return}
        UIView.transition(with: tableView, duration: 1.5, options: .transitionCurlUp, animations: {tableView.reloadData()}, completion: nil)
    }
    
    func setupFloaty(){
        let floaty = Floaty()
        floaty.addItem("Cryptocoins",icon: coinImage) {[weak self] (_) in
            guard let self = self else {return}
            guard self.viewModel?.type != .Cryptocoin else {return}
            self.viewModel?.type = .Cryptocoin
            floaty.buttonImage = self.coinImage
            self.reloadTableView()
        }
        floaty.addItem("Commodities",icon: commodityImage) {[weak self] (_) in
            guard let self = self else {return}
            guard self.viewModel?.type != .Commodity else {return}
            self.viewModel?.type = .Commodity
            floaty.buttonImage = self.commodityImage
            self.reloadTableView()
        }
        floaty.addItem("Fiats",icon: fiatImage) {[weak self] (_) in
            guard let self = self else {return}
            guard self.viewModel?.type != .Fiat else {return}
            self.viewModel?.type = .Fiat
            floaty.buttonImage = self.fiatImage
            self.reloadTableView()
        }
        floaty.addItem("Show All",icon: self.clearImage) {[weak self] (_) in
            guard let self = self else {return}
            guard self.viewModel?.type != .All else {return}
            self.viewModel?.type = .All
            floaty.buttonImage = self.filterImage
            self.reloadTableView()
        }
        //floaty.buttonImage = UIImage(named: "filter")
        floaty.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(floaty)
        floaty.buttonImage = self.filterImage
        floaty.rotationDegrees = 20
        self.floatyView = floaty
        NSLayoutConstraint.activate([
            floaty.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -130),
            floaty.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            floaty.widthAnchor.constraint(equalToConstant: 45),
            floaty.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func configTableView(){
        let tableView = UITableView()
        self.tableView = tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(AssetCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
    }
}

extension AssetViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        switch viewModel?.type {
        case .All:
            return 3
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel?.type {
            case .All:
                switch section {
                case 0:
                    return viewModel?.getCorrespondingGroup(type: .Cryptocoin).count ?? 0
                case 1:
                    return viewModel?.getCorrespondingGroup(type: .Commodity).count ?? 0
                case 2:
                    return viewModel?.getCorrespondingGroup(type: .Fiat).count ?? 0
                default:
                    return 0
                }
            default:
                return viewModel?.getCorrespondingGroup().count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AssetCell else {
            return UITableViewCell()
        }
        switch viewModel?.type {
            case .All:
                switch indexPath.section {
                    case 0:
                        guard let item = viewModel?.cryptoCoins[indexPath.row] else {return cell}
                        cell.configView(item: item)
                    case 1:
                        guard let item = viewModel?.commodities[indexPath.row] else {return cell}
                        cell.configView(item: item)
                    case 2:
                        guard let item = viewModel?.fiats[indexPath.row] else {return cell}
                        cell.configView(item: item)
                    default:
                        break
                }
            case .Commodity:
                guard let item = viewModel?.commodities[indexPath.row] else {return cell}
                cell.configView(item: item)
            case .Cryptocoin:
                guard let item = viewModel?.cryptoCoins[indexPath.row] else {return cell}
                cell.configView(item: item)
            case .Fiat:
                guard let item = viewModel?.fiats[indexPath.row] else {return cell}
                cell.configView(item: item)
            default:
                return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard viewModel?.showSectionHeader != false else {return nil}
        switch viewModel?.type {
            case .All:
                switch section {
                case 0:
                    return "Cryptocoins"
                case 1:
                    return "Commodities"
                case 2:
                    return "Fiats"
                default:
                    return ""
                }
            case .Cryptocoin:
                return "Cryptocoins"
            case .Commodity:
                return "Commodities"
            case .Fiat:
                return "Fiats"
            default:
                return ""
        }
    }
}

extension AssetViewController {
    var coinImage : UIImage? {
        return UIImage(named:"coin")?.bigBadgeIt()
    }
    var commodityImage : UIImage? {
        return UIImage(named:"commodity")?.bigBadgeIt()
    }
    var fiatImage : UIImage? {
        return UIImage(named: "fiat")?.bigBadgeIt()
    }
    
    var clearImage : UIImage? {
        return UIImage(named: "clear")?.badgeIt()
    }
    
    var filterImage : UIImage? {
        return UIImage(named: "filter")?.badgeIt()
    }
}
