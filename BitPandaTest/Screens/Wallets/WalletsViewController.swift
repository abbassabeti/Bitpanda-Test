//
//  WalletsViewController.swift
//  BitPandaTest
//
//  Created by Abbas on 2/11/21.
//

import UIKit
import Floaty

class WalletsViewController : UIViewController {
    var viewModel : WalletViewModel?
    var tableView : UITableView?
    var floatyView: Floaty?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        configTableView()
        setupFloaty()
    }
    
    func reloadTableView(){
        guard let tableView = self.tableView else {return}
        UIView.transition(with: tableView, duration: 1.5, options: .transitionCurlUp, animations: {tableView.reloadData()}, completion: nil)
    }
    
    func setupFloaty(){
        let floaty = Floaty()
        floaty.addItem("Wallets",icon: UIImage(named:"coin")) {[weak self] (_) in
            guard let self = self else {return}
            self.viewModel?.type = .Wallet
            self.reloadTableView()
        }
        floaty.addItem("Commodity Wallets",icon: UIImage(named:"commodity")) {[weak self] (_) in
            guard let self = self else {return}
            self.viewModel?.type = .CommodityWallet
            self.reloadTableView()
        }
        floaty.addItem("Fiat Wallets",icon: UIImage(named:"fiat")) {[weak self] (_) in
            guard let self = self else {return}
            self.viewModel?.type = .FiatWallet
            self.reloadTableView()
        }
        floaty.addItem(title: "All") {[weak self] (_) in
            guard let self = self else {return}
            self.viewModel?.type = .All
            self.reloadTableView()
        }
        floaty.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(floaty)
        self.floatyView = floaty
        NSLayoutConstraint.activate([
            floaty.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            floaty.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
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
        tableView.register(WalletCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
    }
}

extension WalletsViewController : UITableViewDelegate,UITableViewDataSource{
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
                    return viewModel?.getCorrespondingGroup(type: .Wallet).count ?? 0
                case 1:
                    return viewModel?.getCorrespondingGroup(type: .CommodityWallet).count ?? 0
                case 2:
                    return viewModel?.getCorrespondingGroup(type: .FiatWallet).count ?? 0
                default:
                    return 0
                }
            default:
                return viewModel?.getCorrespondingGroup().count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? WalletCell else {
            return UITableViewCell()
        }
        switch viewModel?.type {
            case .All:
                switch indexPath.section {
                    case 0:
                        guard let item = viewModel?.wallets[indexPath.row] else {return cell}
                        let logo = viewModel?.getLogo(symbol: item.attributes?.cryptocoinSymbol ?? "")
                        cell.configView(item: item,logo: logo)
                    case 1:
                        guard let item = viewModel?.commodityWallets[indexPath.row] else {return cell}
                        let logo = viewModel?.getLogo(symbol: item.attributes?.cryptocoinSymbol ?? "")
                        cell.configView(item: item,logo: logo)
                    case 2:
                        guard let item = viewModel?.fiatWallets[indexPath.row] else {return cell}
                        let logo = viewModel?.getLogo(symbol: item.attributes?.fiatSymbol ?? "")
                        cell.configView(item: item,logo: logo)
                    default:
                        break
                }
            case .Wallet:
                guard let item = viewModel?.wallets[indexPath.row] else {return cell}
                let logo = viewModel?.getLogo(symbol: item.attributes?.cryptocoinSymbol ?? "")
                cell.configView(item: item,logo: logo)
            case .CommodityWallet:
                guard let item = viewModel?.commodityWallets[indexPath.row] else {return cell}
                let logo = viewModel?.getLogo(symbol: item.attributes?.cryptocoinSymbol ?? "")
                cell.configView(item: item,logo: logo)
            case .FiatWallet:
                guard let item = viewModel?.fiatWallets[indexPath.row] else {return cell}
                let logo = viewModel?.getLogo(symbol: item.attributes?.fiatSymbol ?? "")
                cell.configView(item: item,logo: logo)
            default:
                return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch viewModel?.type {
            case .All:
                switch section {
                case 0:
                    return "Wallets"
                case 1:
                    return "Commodity Wallets"
                case 2:
                    return "Fiat Wallets"
                default:
                    return ""
                }
            case .Wallet:
                return "Wallets"
            case .CommodityWallet:
                return "Commodity Wallets"
            case .FiatWallet:
                return "Fiat Wallets"
            default:
                return ""
        }
    }
}
