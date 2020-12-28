import Foundation
import CoreImage

public class CIKeystoneCorrectionHorizontal: ImageFilter {
    public init() {
        super.init(name: "CIKeystoneCorrectionHorizontal")
    }
    public func inputFocalLength(_ inputFocalLength: Double) -> CIKeystoneCorrectionHorizontal {
        filter.setValue(inputFocalLength, forKey:"inputFocalLength")
        return self
    }
    public func inputTopLeft(_ inputTopLeft: CIVector?) -> CIKeystoneCorrectionHorizontal {
        filter.setValue(inputTopLeft, forKey:"inputTopLeft")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIKeystoneCorrectionHorizontal {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBottomLeft(_ inputBottomLeft: CIVector?) -> CIKeystoneCorrectionHorizontal {
        filter.setValue(inputBottomLeft, forKey:"inputBottomLeft")
        return self
    }
    public func inputBottomRight(_ inputBottomRight: CIVector?) -> CIKeystoneCorrectionHorizontal {
        filter.setValue(inputBottomRight, forKey:"inputBottomRight")
        return self
    }
    public func inputTopRight(_ inputTopRight: CIVector?) -> CIKeystoneCorrectionHorizontal {
        filter.setValue(inputTopRight, forKey:"inputTopRight")
        return self
    }
}
