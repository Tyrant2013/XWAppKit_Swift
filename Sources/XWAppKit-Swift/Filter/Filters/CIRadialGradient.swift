import Foundation
import CoreImage

public class CIRadialGradient: ImageFilter {
    init() {
        super.init(name: "CIRadialGradient")
    }
    public func inputRadius0(_ inputRadius0: Double) -> CIRadialGradient {
        filter.setValue(inputRadius0, forKey:"inputRadius0")
        return self
    }
    public func inputColor0(_ inputColor0: CIColor?) -> CIRadialGradient {
        filter.setValue(inputColor0, forKey:"inputColor0")
        return self
    }
    public func inputRadius1(_ inputRadius1: Double) -> CIRadialGradient {
        filter.setValue(inputRadius1, forKey:"inputRadius1")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIRadialGradient {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputColor1(_ inputColor1: CIColor?) -> CIRadialGradient {
        filter.setValue(inputColor1, forKey:"inputColor1")
        return self
    }
}
