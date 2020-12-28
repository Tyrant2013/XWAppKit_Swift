import Foundation
import CoreImage

public class CITwirlDistortion: ImageFilter {
    public init() {
        super.init(name: "CITwirlDistortion")
    }
    public func inputAngle(_ inputAngle: Double) -> CITwirlDistortion {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CITwirlDistortion {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CITwirlDistortion {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CITwirlDistortion {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
}
