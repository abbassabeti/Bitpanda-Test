//
//  AssetCell.swift
//  BitPandaTest
//
//  Created by Abbas on 2/11/21.
//

import UIKit
import Kingfisher

class AssetCell : UITableViewCell {
    
    var imgView : UIImageView?
    var nameLbl: UILabel?
    var priceLbl : UILabel?
    var symbolLbl : UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView(){
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
        
        NSLayoutConstraint.activate([
            imgView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            imgView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            imgView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -10),
            imgView.widthAnchor.constraint(equalToConstant: 45),
            imgView.heightAnchor.constraint(equalToConstant: 45),
            nameLbl.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 5),
            nameLbl.topAnchor.constraint(equalTo: imgView.topAnchor),
            priceLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor,constant: 5),
            priceLbl.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -10),
            priceLbl.leadingAnchor.constraint(equalTo: imgView.trailingAnchor,constant: 5),
            priceLbl.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            priceLbl.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            symbolLbl.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 5),
            symbolLbl.widthAnchor.constraint(equalToConstant: 120),
            symbolLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 5),
            symbolLbl.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
        priceLbl.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        nameLbl.setContentHuggingPriority(.init(751), for: .horizontal)
    }
    
    func configView(item: AssetItem){
        self.imgView?.kf.cancelDownloadTask()
        let processor = SVGProcessor(size: CGSize(width: 45, height: 45))
        //let serializer = SVGCacheSerializer()
        switch traitCollection.userInterfaceStyle {
            case .dark:
                if let logo = URL(string: item.attributes?.logoDark ?? ""){
                    self.imgView?.kf.setImage(with: logo, placeholder: nil, options: [.processor(processor)])
                }
            default:
                if let logo = URL(string: item.attributes?.logo ?? ""){
                    self.imgView?.kf.setImage(with: logo, placeholder: nil, options: [.processor(processor)])
                }
        }
        self.nameLbl?.text = item.attributes?.name
        let price = getPrice(item: item)
        self.priceLbl?.text = price
        self.priceLbl?.sizeToFit()
        self.symbolLbl?.text = item.attributes?.symbol
        self.symbolLbl?.sizeToFit()
    }
    
    func getPrice(item: AssetItem) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = item.attributes?.precisionForFiatPrice ?? 2
        formatter.minimumFractionDigits = item.attributes?.precisionForFiatPrice ?? 2
        guard let rawPrice = item.attributes?.avgPrice else {return ""}
        formatter.numberStyle = .decimal
        guard let number = formatter.number(from: rawPrice) else {return ""}
        formatter.currencyCode = item.attributes?.symbol
        let locale = Locale.getPreferredLocale()
        formatter.locale = locale
        formatter.currencySymbol = locale.currencySymbol//item.attributes?.symbol
        formatter.numberStyle = .currency
        return formatter.string(from: number) ?? ""
    }
}
