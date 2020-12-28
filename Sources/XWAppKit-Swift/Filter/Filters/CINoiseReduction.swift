import Foundation
import CoreImage

public class CINoiseReduction: ImageFilter {
    public init() {
        super.init(name: "CINoiseReduction")
    }
    public func inputNoiseLevel(_ inputNoiseLevel: Double) -> CINoiseReduction {
        filter.setValue(inputNoiseLevel, forKey:"inputNoiseLevel")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CINoiseReduction {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputSharpness(_ inputSharpness: Double) -> CINoiseReduction {
        filter.setValue(inputSharpness, forKey:"inputSharpness")
        return self
    }
}
