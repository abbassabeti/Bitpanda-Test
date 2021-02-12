//
//  SVGProcessor.swift
//  BitPandaTest
//
//  Created by Abbas on 2/12/21.
//

import UIKit
import Kingfisher
import PocketSVG

struct SVGProcessor: ImageProcessor {
    
    let imgSize: CGSize?
    
    init(size: CGSize? = CGSize(width:250, height:250)) {
        imgSize = size
    }
    
    // `identifier` should be the same for processors with same properties/functionality
    // It will be used when storing and retrieving the image to/from cache.
    let identifier = "my.app.svg"
    
    // Convert input data/image to target image and return it.
    func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            //already an image
            return image
        case .data(let data):
            return generateSVGImage(data: data, size: imgSize ?? CGSize(width: 250, height: 250)) ?? DefaultImageProcessor().process(item: item, options: options)
        }
    }
    
    func generateSVGImage(data: Data, size: CGSize) -> KFCrossPlatformImage? {
        if let svgString = String(data: data, encoding: .utf8) {
//            let layer = CAShapeLayer(pathString: svgString)
//            layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//            return snapshotImage(for: layer)
            let svgLayer = SVGLayer()
            svgLayer.paths = SVGBezierPath.paths(fromSVGString: svgString)
            let originRect = SVGBoundingRectForPaths(svgLayer.paths)
            svgLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            return snapshotImage(for: svgLayer)
        }
        return nil
    }
    
    func snapshotImage(for layer: CALayer) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}
