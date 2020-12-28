import Foundation
import CoreImage

public class CIZoomBlur: ImageFilter {
    public init() {
        super.init(name: "CIZoomBlur")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIZoomBlur {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputAmount(_ inputAmount: Double) -> CIZoomBlur {
        filter.setValue(inputAmount, forKey:"inputAmount")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIZoomBlur {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
}
