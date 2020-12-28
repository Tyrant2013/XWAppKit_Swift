import Foundation
import CoreImage

public class CIStripesGenerator: ImageFilter {
    public init() {
        super.init(name: "CIStripesGenerator")
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIStripesGenerator {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputSharpness(_ inputSharpness: Double) -> CIStripesGenerator {
        filter.setValue(inputSharpness, forKey:"inputSharpness")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CIStripesGenerator {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    public func inputColor1(_ inputColor1: CIColor?) -> CIStripesGenerator {
        filter.setValue(inputColor1, forKey:"inputColor1")
        return self
    }
    public func inputColor0(_ inputColor0: CIColor?) -> CIStripesGenerator {
        filter.setValue(inputColor0, forKey:"inputColor0")
        return self
    }
}
