import Foundation
import CoreImage

public class CIPerspectiveTransform: ImageFilter {
    init() {
        super.init(name: "CIPerspectiveTransform")
    }
    public func inputTopLeft(_ inputTopLeft: CIVector?) -> CIPerspectiveTransform {
        filter.setValue(inputTopLeft, forKey:"inputTopLeft")
        return self
    }
    public func inputBottomRight(_ inputBottomRight: CIVector?) -> CIPerspectiveTransform {
        filter.setValue(inputBottomRight, forKey:"inputBottomRight")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPerspectiveTransform {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputTopRight(_ inputTopRight: CIVector?) -> CIPerspectiveTransform {
        filter.setValue(inputTopRight, forKey:"inputTopRight")
        return self
    }
    public func inputBottomLeft(_ inputBottomLeft: CIVector?) -> CIPerspectiveTransform {
        filter.setValue(inputBottomLeft, forKey:"inputBottomLeft")
        return self
    }
}
