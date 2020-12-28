import Foundation
import CoreImage

public class CIKeystoneCorrectionCombined: ImageFilter {
    init() {
        super.init(name: "CIKeystoneCorrectionCombined")
    }
    public func inputFocalLength(_ inputFocalLength: Double) -> CIKeystoneCorrectionCombined {
        filter.setValue(inputFocalLength, forKey:"inputFocalLength")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIKeystoneCorrectionCombined {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputTopRight(_ inputTopRight: CIVector?) -> CIKeystoneCorrectionCombined {
        filter.setValue(inputTopRight, forKey:"inputTopRight")
        return self
    }
    public func inputBottomRight(_ inputBottomRight: CIVector?) -> CIKeystoneCorrectionCombined {
        filter.setValue(inputBottomRight, forKey:"inputBottomRight")
        return self
    }
    public func inputBottomLeft(_ inputBottomLeft: CIVector?) -> CIKeystoneCorrectionCombined {
        filter.setValue(inputBottomLeft, forKey:"inputBottomLeft")
        return self
    }
    public func inputTopLeft(_ inputTopLeft: CIVector?) -> CIKeystoneCorrectionCombined {
        filter.setValue(inputTopLeft, forKey:"inputTopLeft")
        return self
    }
}
