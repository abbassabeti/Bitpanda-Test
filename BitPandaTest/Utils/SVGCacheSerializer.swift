//
//  SVGCacheSerializer.swift
//  BitPandaTest
//
//  Created by Abbas on 2/12/21.
//

//import UIKit
//import Kingfisher
//import SwiftSVG
//
//struct SVGCacheSerializer: CacheSerializer {
//    
//    func data(with image: KFCrossPlatformImage, original: Data?) -> Data? {
//        return original
//    }
//    
//    func image(with data: Data, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
//        return generateSVGImage(data: data) ?? image(with: data, options: options)
//    }
//}
//
//func generateSVGImage(data: Data, size: CGSize? = CGSize(width:250, height:250)) -> UIImage?{
//    let frame = CGRect(x: 0, y: 0, width: size!.width, height: size!.height)
//    if let strData = String(data: data, encoding: .utf8){
//        let svgLayer = CAShapeLayer(pathString: strData)//CALayer(SVGData: data) { (layer) in
//        svgLayer.frame = frame
//        return snapshotImage(for: svgLayer)
//    }
//    
//    return nil
//}
//
//func snapshotImage(for layer: CALayer) -> UIImage? {
//    UIGraphicsBeginImageContextWithOptions(layer.bounds.size, false, UIScreen.main.scale)
//    guard let context = UIGraphicsGetCurrentContext() else { return nil }
//    layer.render(in: context)
//    let image = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    return image
//}
