import Foundation
import CoreImage

public class CIShadedMaterial: ImageFilter {
    init() {
        super.init(name: "CIShadedMaterial")
    }
    public func inputScale(_ inputScale: Double) -> CIShadedMaterial {
        filter.setValue(inputScale, forKey:"inputScale")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIShadedMaterial {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputShadingImage(_ inputShadingImage: CIImage?) -> CIShadedMaterial {
        filter.setValue(inputShadingImage, forKey:"inputShadingImage")
        return self
    }
}
