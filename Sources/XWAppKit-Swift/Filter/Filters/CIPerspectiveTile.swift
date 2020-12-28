import Foundation
import CoreImage

public class CIPerspectiveTile: ImageFilter {
    init() {
        super.init(name: "CIPerspectiveTile")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPerspectiveTile {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBottomRight(_ inputBottomRight: CIVector?) -> CIPerspectiveTile {
        filter.setValue(inputBottomRight, forKey:"inputBottomRight")
        return self
    }
    public func inputTopRight(_ inputTopRight: CIVector?) -> CIPerspectiveTile {
        filter.setValue(inputTopRight, forKey:"inputTopRight")
        return self
    }
    public func inputTopLeft(_ inputTopLeft: CIVector?) -> CIPerspectiveTile {
        filter.setValue(inputTopLeft, forKey:"inputTopLeft")
        return self
    }
    public func inputBottomLeft(_ inputBottomLeft: CIVector?) -> CIPerspectiveTile {
        filter.setValue(inputBottomLeft, forKey:"inputBottomLeft")
        return self
    }
}
