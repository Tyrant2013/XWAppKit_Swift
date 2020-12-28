import Foundation
import CoreImage

public class CIPerspectiveTransformWithExtent: ImageFilter {
    public init() {
        super.init(name: "CIPerspectiveTransformWithExtent")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPerspectiveTransformWithExtent {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputTopLeft(_ inputTopLeft: CIVector?) -> CIPerspectiveTransformWithExtent {
        filter.setValue(inputTopLeft, forKey:"inputTopLeft")
        return self
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIPerspectiveTransformWithExtent {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
    public func inputBottomRight(_ inputBottomRight: CIVector?) -> CIPerspectiveTransformWithExtent {
        filter.setValue(inputBottomRight, forKey:"inputBottomRight")
        return self
    }
    public func inputTopRight(_ inputTopRight: CIVector?) -> CIPerspectiveTransformWithExtent {
        filter.setValue(inputTopRight, forKey:"inputTopRight")
        return self
    }
    public func inputBottomLeft(_ inputBottomLeft: CIVector?) -> CIPerspectiveTransformWithExtent {
        filter.setValue(inputBottomLeft, forKey:"inputBottomLeft")
        return self
    }
}
