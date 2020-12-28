import Foundation
import CoreImage

public class CIPinchDistortion: ImageFilter {
    init() {
        super.init(name: "CIPinchDistortion")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPinchDistortion {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIPinchDistortion {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIPinchDistortion {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    public func inputScale(_ inputScale: Double) -> CIPinchDistortion {
        filter.setValue(inputScale, forKey:"inputScale")
        return self
    }
}
