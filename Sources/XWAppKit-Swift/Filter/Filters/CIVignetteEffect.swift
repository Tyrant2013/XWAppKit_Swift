import Foundation
import CoreImage

public class CIVignetteEffect: ImageFilter {
    public init() {
        super.init(name: "CIVignetteEffect")
    }
    public func inputRadius(_ inputRadius: Double) -> CIVignetteEffect {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIVignetteEffect {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIVignetteEffect {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputIntensity(_ inputIntensity: Double) -> CIVignetteEffect {
        filter.setValue(inputIntensity, forKey:"inputIntensity")
        return self
    }
    public func inputFalloff(_ inputFalloff: Double) -> CIVignetteEffect {
        filter.setValue(inputFalloff, forKey:"inputFalloff")
        return self
    }
}
