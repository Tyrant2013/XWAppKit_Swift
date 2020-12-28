import Foundation
import CoreImage

public class CITemperatureAndTint: ImageFilter {
    public init() {
        super.init(name: "CITemperatureAndTint")
    }
    public func inputTargetNeutral(_ inputTargetNeutral: CIVector?) -> CITemperatureAndTint {
        filter.setValue(inputTargetNeutral, forKey:"inputTargetNeutral")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CITemperatureAndTint {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputNeutral(_ inputNeutral: CIVector?) -> CITemperatureAndTint {
        filter.setValue(inputNeutral, forKey:"inputNeutral")
        return self
    }
}
