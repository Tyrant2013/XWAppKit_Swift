import Foundation
import CoreImage

public class CIGammaAdjust: ImageFilter {
    public init() {
        super.init(name: "CIGammaAdjust")
    }
    public func inputPower(_ inputPower: Double) -> CIGammaAdjust {
        filter.setValue(inputPower, forKey:"inputPower")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIGammaAdjust {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
