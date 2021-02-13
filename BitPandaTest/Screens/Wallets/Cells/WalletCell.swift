//
//  WalletCell.swift
//  BitPandaTest
//
//  Created by Abbas on 2/12/21.
//

import UIKit
import Kingfisher

class WalletCell : UITableViewCell {
    
    var imgView : UIImageView?
    var nameLbl: UILabel?
    var priceLbl : UILabel?
    var symbolLbl : UILabel?
    
    var defaultItemColor : UIColor = .green
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgView?.layer.borderWidth = 0
        self.imgView?.layer.borderColor = UIColor.clear.cgColor
        self.nameLbl?.textColor = (traitCollection.userInterfaceStyle == .dark) ? .white : .black
    }
    
    func setupView(){
        defaultItemColor = (traitCollection.userInterfaceStyle == .dark) ? .green : .blue
        let imgView = UIImageView()
        let nameLbl = UILabel()
        let priceLbl = UILabel()
        let symbolLbl = UILabel()
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        priceLbl.translatesAutoresizingMaskIntoConstraints = false
        symbolLbl.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(nameLbl)
        self.contentView.addSubview(priceLbl)
        self.contentView.addSubview(symbolLbl)
        
        self.imgView = imgView
        self.nameLbl = nameLbl
        self.priceLbl = priceLbl
        self.symbolLbl = symbolLbl
        
        self.nameLbl?.textAlignment = .left
        self.priceLbl?.textAlignment = .right
        self.symbolLbl?.textAlignment = .left
        self.imgView?.contentMode = .scaleAspectFit
        self.symbolLbl?.font = UIFont.systemFont(ofSize: 10)
        self.imgView?.layer.cornerRadius = 23
        self.imgView?.backgroundColor = .gray
        self.selectionStyle = .none

        NSLayoutConstraint.activate([
            imgView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            imgView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            imgView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -16),
            imgView.widthAnchor.constraint(equalToConstant: 45),
            imgView.heightAnchor.constraint(equalToConstant: 45),
            nameLbl.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 8),
            nameLbl.topAnchor.constraint(equalTo: imgView.topAnchor),
            priceLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor,constant: 8),
            priceLbl.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -16),
            priceLbl.leadingAnchor.constraint(equalTo: imgView.trailingAnchor,constant: 8),
            priceLbl.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            priceLbl.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            symbolLbl.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 8),
            symbolLbl.widthAnchor.constraint(equalToConstant: 120),
            symbolLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 8),
            symbolLbl.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
        priceLbl.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        nameLbl.setContentHuggingPriority(.init(751), for: .horizontal)
    }
    
    func configView(item: WalletItem,logo: LogoItem?){
        self.imgView?.kf.cancelDownloadTask()
        let processor = SVGProcessor(size: CGSize(width: 45, height: 45))
        switch traitCollection.userInterfaceStyle {
            case .dark:
                if let logo = URL(string: logo?.darkLogo ?? ""){
                    self.imgView?.kf.setImage(with: logo, placeholder: UIImage(named: "wallet-def"), options: [.processor(processor)])
                }
            default:
                if let logo = URL(string: logo?.logo ?? ""){
                    self.imgView?.kf.setImage(with: logo, placeholder: UIImage(named: "wallet-def"), options: [.processor(processor)])
                }
        }
        self.nameLbl?.text = item.attributes?.name
        let price = getPrice(item: item)
        self.priceLbl?.text = price
        self.priceLbl?.sizeToFit()
        self.symbolLbl?.text = item.attributes?.cryptocoinSymbol
        self.symbolLbl?.sizeToFit()
        
        if (item.attributes?.isDefault == true){
            self.imgView?.layer.borderWidth = 3
            self.imgView?.layer.borderColor = defaultItemColor.cgColor
            self.nameLbl?.textColor = defaultItemColor
        }
    }
    
    func configView(item: FiatWalletItem,logo: LogoItem?){
        self.imgView?.kf.cancelDownloadTask()
        let processor = SVGProcessor(size: CGSize(width: 45, height: 45))
        switch traitCollection.userInterfaceStyle {
            case .dark:
                if let logo = URL(string: logo?.darkLogo ?? ""){
                    self.imgView?.kf.setImage(with: logo, placeholder: UIImage(named: "wallet-def"), options: [.processor(processor)])
                }
            default:
                if let logo = URL(string: logo?.logo ?? ""){
                    self.imgView?.kf.setImage(with: logo, placeholder: UIImage(named: "wallet-def"), options: [.processor(processor)])
                }
        }
        self.nameLbl?.text = item.attributes?.name
        let price = getPrice(item: item)
        self.priceLbl?.text = price
        self.priceLbl?.sizeToFit()
        self.symbolLbl?.text = item.attributes?.fiatSymbol
        self.symbolLbl?.sizeToFit()
    }
    
    func getPrice(item: WalletItem) -> String {
        let formatter = NumberFormatter()
        guard let rawPrice = item.attributes?.balance else {return ""}
        let number = NSNumber(value: rawPrice)
        formatter.currencyCode = item.attributes?.cryptocoinSymbol
        let locale = Locale.getPreferredLocale()
        formatter.locale = locale
        formatter.currencySymbol = locale.currencySymbol
        formatter.numberStyle = .currency
        return formatter.string(from: number) ?? ""
    }
    
    func getPrice(item: FiatWalletItem) -> String {
        let formatter = NumberFormatter()
        guard let rawPrice = item.attributes?.balance else {return ""}
        let number = NSNumber(value: rawPrice)
        formatter.currencyCode = item.attributes?.fiatSymbol
        let locale = Locale.getPreferredLocale()
        formatter.locale = locale
        formatter.currencySymbol = locale.currencySymbol
        formatter.numberStyle = .currency
        return formatter.string(from: number) ?? ""
    }
}
