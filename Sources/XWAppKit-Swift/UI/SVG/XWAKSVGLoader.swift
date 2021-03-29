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

protocol XWAKSVGLoaderDelegate {
    func loaderDidStart(_ loader: XWAKSVGLoader) -> Void
    func loaderDidEnd(_ loader: XWAKSVGLoader) -> Void
}

final class XWAKSVGLoader: NSObject {
    var delegate: XWAKSVGLoaderDelegate?
    
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
    
    public var elements = [XWAKSVGElement]()
    public var root: XWAKSVGRootElement!
    public var style: XWAKSVGStyle?
    private var stack = Stack<XWAKSVGElement>()
    
    private var currentTag: String = ""
}

extension XWAKSVGLoader: XMLParserDelegate {
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentTag = elementName
        switch elementName {
        case "svg":
            root = XWAKSVGRootElement(dict: attributeDict)
            stack.push(root)
        case "style":
            style = XWAKSVGStyle()
        case "g":
            let group = XWAKSVGGroup(dict: attributeDict)
            stack.push(group)
        default:
            if names.contains(elementName) {
                let className = "XWAppKit_Swift.XWAKSVG".appending(elementName.capitalized)
                if let cls = NSClassFromString(className) {
                    var ele: XWAKSVGElement?
                    if cls is XWAKSVGPolygon.Type {
                        ele = (cls as! XWAKSVGPolygon.Type).init(dict: attributeDict)
                    }
                    else if cls is XWAKSVGPath.Type {
                        ele = (cls as! XWAKSVGPath.Type).init(dict: attributeDict)
                    }
                    else if cls is XWAKSVGRect.Type {
                        ele = (cls as! XWAKSVGRect.Type).init(dict: attributeDict)
                    }
                    else if cls is XWAKSVGEllipse.Type {
                        ele = (cls as! XWAKSVGEllipse.Type).init(dict: attributeDict)
                    }
                    else if cls is XWAKSVGCircle.Type {
                        ele = (cls as! XWAKSVGCircle.Type).init(dict: attributeDict)
                    }
                    if ele != nil {
                        stack.push(ele!)
                    }
                }
                else {
                    print("未实现的功能: ", elementName, className)
                }
            }
            else {
                print("未解析: ", elementName)
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "svg" || elementName == "g" || names.contains(elementName) {
            let ele = stack.pop()
            if let top = stack.top() {
                ele.parent = top
                top.children.append(ele)
            }
        }
    }
    
    public func parserDidStartDocument(_ parser: XMLParser) {
        delegate?.loaderDidStart(self)
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        delegate?.loaderDidEnd(self)
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentTag == "style" && string.count > 0 {
            style?.valueString = string
            do {
                let rules = string.components(separatedBy: "@")
                let regexp = try NSRegularExpression(pattern: "/\\*.*?\\*/", options: .dotMatchesLineSeparators)
                print(rules[0])
                let str = regexp.stringByReplacingMatches(in: rules[0], options: .reportProgress, range: NSRange(location: 0, length: rules[0].count), withTemplate: "")
                let classNameAndStyleStrings = str.components(separatedBy: CharacterSet(charactersIn: "}"))
                print("will print css style property!")
                for idStyleString in classNameAndStyleStrings {
                    print("css: ", idStyleString)
                    let rule = idStyleString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    if rule.count > 0 {
                        let stringSplitContainer = rule.components(separatedBy: "{")
                        print("name: ", stringSplitContainer[0])
                        print("value: ", stringSplitContainer[1])
                    }
                }
                for index in 1..<rules.count {
                    print("keyframes: ", rules[index])
                }
            }
            catch {
                print(error)
            }
        }
    }
}
