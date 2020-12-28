import Foundation
import CoreImage

public class CIColorControls: ImageFilter {
    public init() {
        super.init(name: "CIColorControls")
    }
    public func inputSaturation(_ inputSaturation: Double) -> CIColorControls {
        filter.setValue(inputSaturation, forKey:"inputSaturation")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIColorControls {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputContrast(_ inputContrast: Double) -> CIColorControls {
        filter.setValue(inputContrast, forKey:"inputContrast")
        return self
    }
    public func inputBrightness(_ inputBrightness: Double) -> CIColorControls {
        filter.setValue(inputBrightness, forKey:"inputBrightness")
        return self
    }
}
