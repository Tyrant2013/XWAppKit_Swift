import Foundation
import CoreImage

public class CIBumpDistortion: ImageFilter {
    init() {
        super.init(name: "CIBumpDistortion")
    }
    public func inputScale(_ inputScale: Double) -> CIBumpDistortion {
        filter.setValue(inputScale, forKey:"inputScale")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIBumpDistortion {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIBumpDistortion {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIBumpDistortion {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
}
