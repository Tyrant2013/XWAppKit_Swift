import Foundation
import CoreImage

public class CIAztecCodeGenerator: ImageFilter {
    public init() {
        super.init(name: "CIAztecCodeGenerator")
    }
    public func inputCorrectionLevel(_ inputCorrectionLevel: Double) -> CIAztecCodeGenerator {
        filter.setValue(inputCorrectionLevel, forKey:"inputCorrectionLevel")
        return self
    }
    public func inputMessage(_ inputMessage: NSData?) -> CIAztecCodeGenerator {
        filter.setValue(inputMessage, forKey:"inputMessage")
        return self
    }
    public func inputLayers(_ inputLayers: Double) -> CIAztecCodeGenerator {
        filter.setValue(inputLayers, forKey:"inputLayers")
        return self
    }
    public func inputCompactStyle(_ inputCompactStyle: Double) -> CIAztecCodeGenerator {
        filter.setValue(inputCompactStyle, forKey:"inputCompactStyle")
        return self
    }
}
