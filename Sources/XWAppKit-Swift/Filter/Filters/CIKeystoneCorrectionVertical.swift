import Foundation
import CoreImage

public class CIKeystoneCorrectionVertical: ImageFilter {
    public init() {
        super.init(name: "CIKeystoneCorrectionVertical")
    }
    public func inputBottomRight(_ inputBottomRight: CIVector?) -> CIKeystoneCorrectionVertical {
        filter.setValue(inputBottomRight, forKey:"inputBottomRight")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIKeystoneCorrectionVertical {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBottomLeft(_ inputBottomLeft: CIVector?) -> CIKeystoneCorrectionVertical {
        filter.setValue(inputBottomLeft, forKey:"inputBottomLeft")
        return self
    }
    public func inputTopLeft(_ inputTopLeft: CIVector?) -> CIKeystoneCorrectionVertical {
        filter.setValue(inputTopLeft, forKey:"inputTopLeft")
        return self
    }
    public func inputTopRight(_ inputTopRight: CIVector?) -> CIKeystoneCorrectionVertical {
        filter.setValue(inputTopRight, forKey:"inputTopRight")
        return self
    }
    public func inputFocalLength(_ inputFocalLength: Double) -> CIKeystoneCorrectionVertical {
        filter.setValue(inputFocalLength, forKey:"inputFocalLength")
        return self
    }
}
