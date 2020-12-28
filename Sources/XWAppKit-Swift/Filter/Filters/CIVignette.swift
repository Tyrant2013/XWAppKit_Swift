import Foundation
import CoreImage

public class CIVignette: ImageFilter {
    public init() {
        super.init(name: "CIVignette")
    }
    public func inputIntensity(_ inputIntensity: Double) -> CIVignette {
        filter.setValue(inputIntensity, forKey:"inputIntensity")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIVignette {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIVignette {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
