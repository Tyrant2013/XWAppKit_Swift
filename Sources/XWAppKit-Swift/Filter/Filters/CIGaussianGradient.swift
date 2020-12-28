import Foundation
import CoreImage

public class CIGaussianGradient: ImageFilter {
    public init() {
        super.init(name: "CIGaussianGradient")
    }
    public func inputRadius(_ inputRadius: Double) -> CIGaussianGradient {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    public func inputColor0(_ inputColor0: CIColor?) -> CIGaussianGradient {
        filter.setValue(inputColor0, forKey:"inputColor0")
        return self
    }
    public func inputColor1(_ inputColor1: CIColor?) -> CIGaussianGradient {
        filter.setValue(inputColor1, forKey:"inputColor1")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIGaussianGradient {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
}
