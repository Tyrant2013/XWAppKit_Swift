//
//  XWAKSVGLoader.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/3/25.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

// https://www.w3school.com.cn/svg/svg_reference.asp
// https://www.w3.org/TR/SVGMobile/elementTable.html

import Foundation
import UIKit

public final class XWAKSVGLoader: NSObject {
    let fileName: String
    private let names = ["path", "rect", "circle", "ellipse", "line", "polyline", "polygon"]
    public init(fileName: String) {
        guard fileName.count > 0 else {
            fatalError("FileName Error!")
        }
        self.fileName = fileName
    }
    
    public func parse() {
        if let dataAsset = NSDataAsset(name: fileName) {
            let xmlParser = XMLParser(data: dataAsset.data)
            xmlParser.delegate = self
            xmlParser.parse()
        }

    }
    
    public var svgSize: CGSize = .zero
    public var transform: String = ""
    private var elements = [XWAKSVGElement]()
}

extension XWAKSVGLoader: XMLParserDelegate {
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print("elementName: ", elementName, ", attributes: ", attributeDict)
//        if elementName == "svg" {
//            let width = Double(attributeDict["width"] ?? "0")!
//            let height = Double(attributeDict["height"] ?? "0")!
//            svgSize = CGSize(width: width, height: height)
//        }
//        else if elementName == "g" {
//            transform = attributeDict["transform"] ?? ""
//        }
//        else if names.contains(elementName) {
//            let className = "SVG".appending(elementName.capitalized)
//            if let myClass: AnyClass = NSClassFromString(className) {
//                let cls = myClass as! XWAKSVGElement.Type
////                let element = cls.init(dict: attributeDict)
////                print(element)
//                let element = cls.init(dict: attributeDict)
//                print(element)
//                elements.append(element)
//            }
//        }
        let path = UIBezierPath()
        path.addQuadCurve(to: <#T##CGPoint#>, controlPoint: <#T##CGPoint#>)
    }
    
    public func parserDidStartDocument(_ parser: XMLParser) {
        
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        
    }
}
