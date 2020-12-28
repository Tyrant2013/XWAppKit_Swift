import Foundation
import CoreImage

public class CIHoleDistortion: ImageFilter {
    public init() {
        super.init(name: "CIHoleDistortion")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIHoleDistortion {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIHoleDistortion {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIHoleDistortion {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
}
