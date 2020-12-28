import Foundation
import CoreImage

public class CIVortexDistortion: ImageFilter {
    init() {
        super.init(name: "CIVortexDistortion")
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIVortexDistortion {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIVortexDistortion {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIVortexDistortion {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CIVortexDistortion {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
}
