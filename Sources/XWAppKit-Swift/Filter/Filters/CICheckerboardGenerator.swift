import Foundation
import CoreImage

public class CICheckerboardGenerator: ImageFilter {
    public init() {
        super.init(name: "CICheckerboardGenerator")
    }
    public func inputSharpness(_ inputSharpness: Double) -> CICheckerboardGenerator {
        filter.setValue(inputSharpness, forKey:"inputSharpness")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CICheckerboardGenerator {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputColor0(_ inputColor0: CIColor?) -> CICheckerboardGenerator {
        filter.setValue(inputColor0, forKey:"inputColor0")
        return self
    }
    public func inputColor1(_ inputColor1: CIColor?) -> CICheckerboardGenerator {
        filter.setValue(inputColor1, forKey:"inputColor1")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CICheckerboardGenerator {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
}
