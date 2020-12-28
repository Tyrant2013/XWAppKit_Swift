import Foundation
import CoreImage

public class CIToneCurve: ImageFilter {
    public init() {
        super.init(name: "CIToneCurve")
    }
    public func inputPoint2(_ inputPoint2: CIVector?) -> CIToneCurve {
        filter.setValue(inputPoint2, forKey:"inputPoint2")
        return self
    }
    public func inputPoint1(_ inputPoint1: CIVector?) -> CIToneCurve {
        filter.setValue(inputPoint1, forKey:"inputPoint1")
        return self
    }
    public func inputPoint4(_ inputPoint4: CIVector?) -> CIToneCurve {
        filter.setValue(inputPoint4, forKey:"inputPoint4")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIToneCurve {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputPoint0(_ inputPoint0: CIVector?) -> CIToneCurve {
        filter.setValue(inputPoint0, forKey:"inputPoint0")
        return self
    }
    public func inputPoint3(_ inputPoint3: CIVector?) -> CIToneCurve {
        filter.setValue(inputPoint3, forKey:"inputPoint3")
        return self
    }
}
