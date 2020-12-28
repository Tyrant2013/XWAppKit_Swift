import Foundation
import CoreImage

public class CIPerspectiveCorrection: ImageFilter {
    public init() {
        super.init(name: "CIPerspectiveCorrection")
    }
    public func inputTopLeft(_ inputTopLeft: CIVector?) -> CIPerspectiveCorrection {
        filter.setValue(inputTopLeft, forKey:"inputTopLeft")
        return self
    }
    public func inputTopRight(_ inputTopRight: CIVector?) -> CIPerspectiveCorrection {
        filter.setValue(inputTopRight, forKey:"inputTopRight")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPerspectiveCorrection {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBottomLeft(_ inputBottomLeft: CIVector?) -> CIPerspectiveCorrection {
        filter.setValue(inputBottomLeft, forKey:"inputBottomLeft")
        return self
    }
    public func inputBottomRight(_ inputBottomRight: CIVector?) -> CIPerspectiveCorrection {
        filter.setValue(inputBottomRight, forKey:"inputBottomRight")
        return self
    }
    public func inputCrop(_ inputCrop: Double) -> CIPerspectiveCorrection {
        filter.setValue(inputCrop, forKey:"inputCrop")
        return self
    }
}
