import Foundation
import CoreImage

public class CIColorCurves: ImageFilter {
    public init() {
        super.init(name: "CIColorCurves")
    }
    public func inputColorSpace(_ inputColorSpace: NSObject?) -> CIColorCurves {
        filter.setValue(inputColorSpace, forKey:"inputColorSpace")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIColorCurves {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputCurvesData(_ inputCurvesData: NSData?) -> CIColorCurves {
        filter.setValue(inputCurvesData, forKey:"inputCurvesData")
        return self
    }
    public func inputCurvesDomain(_ inputCurvesDomain: CIVector?) -> CIColorCurves {
        filter.setValue(inputCurvesDomain, forKey:"inputCurvesDomain")
        return self
    }
}
