//
//  CIFilter.swift
//  instaxphoto
//
//  Created by ZHXW on 2020/7/15.
//

import Foundation
import CoreImage

//  下面网址可以查看所有的 Filter https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP40004346

enum FilterName: String {
    case SepiaTone = "CISepiaTone"
}

extension CIFilter {
    class func makeFilter(with filterName: FilterName) -> CIFilter? {
        
        return CIFilter(name: filterName.rawValue)
    }
}

final class CIFilters {
//    func name() {
//        let bloomFilter = CIFilter.makeFilter(with: .SepiaTone)
//    }
    // https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_concepts/ci_concepts.html#//apple_ref/doc/uid/TP30001185-CH2-TPXREF101
    class func listFilterNames() {
//        let effectTypesCategories = [
//            kCICategoryDistortionEffect,
//            kCICategoryGeometryAdjustment,
//            kCICategoryCompositeOperation,
//            kCICategoryHalftoneEffect,
//            kCICategoryColorAdjustment,
//            kCICategoryColorEffect,
//            kCICategoryTransition,
//            kCICategoryTileEffect,
//            kCICategoryGenerator,
//            kCICategoryGradient,
//            kCICategoryStylize,
//            kCICategorySharpen,
//            kCICategoryBlur
//        ]
        let usageCategories = [
            kCICategoryStillImage,
            kCICategoryVideo,
            kCICategoryInterlaced,
            kCICategoryNonSquarePixels,
            kCICategoryHighDynamicRange
        ]
//        let originCategories = [
//            kCICategoryBuiltIn
//        ]
        var filters = [String : [String]]()
//        [effectTypesCategories, usageCategories, originCategories].forEach
        var names = [String : Int]()
        
            [usageCategories].forEach { categories in
            categories.forEach { categoryName in
                var dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                dir += "/\(categoryName)"
                print(dir)
                if !FileManager.default.fileExists(atPath: dir) {
                    do {
                        try FileManager.default.createDirectory(atPath: dir, withIntermediateDirectories: true, attributes: nil)
                    }
                    catch {
                        print(error)
                    }
                }
                let filtersByCategory = CIFilter.filterNames(inCategory: categoryName)
                filters[categoryName] = filtersByCategory
                filtersByCategory.forEach { filterName in
                    if let filter = CIFilter(name: filterName) {
                        if names[filterName] == nil {
                            names[filterName] = 1
                            let attrs = filter.attributes
                            var str = "import Foundation\n"
                            str += "import CoreImage\n\n"
                            str += "public class \(filter.name): ImageFilter {\n"
//                            str += "    private var filter: CIFilter\n"
//                            str += "    public var outputImage: CIImage? {\n"
//                            str += "        get {\n"
//                            str += "            return filter.outputImage\n"
//                            str += "        }\n"
//                            str += "    }\n"
                            str += "    init() {\n"
                            str += "        super.init(name: \"\(filter.name)\")\n"
                            str += "    }\n"
                            attrs.forEach { attr in
                                let value = attr.value
                                if value is Dictionary<String, Any> {
                                    str += "    public func \(attr.key)(_ \(attr.key): \((value as! Dictionary<String, Any>)["CIAttributeClass"]!)?) -> \(filter.name) {\n"
                                    str += "        filter.setValue(\(attr.key), forKey:\"\(attr.key)\")\n"
                                    str += "        return self\n"
                                    str += "    }\n"
                                }
                            }
                            str += "}\n"
                            
                            print(str)
                            
                            let file = dir + "/\(filter.name).swift"
                            do {
                                try str.write(toFile: file, atomically: true, encoding: .utf8)
                            }
                            catch {
                                print(error)
                            }
                        }
                    }
                }
            }
        }
    }
}
