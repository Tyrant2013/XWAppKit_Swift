import Foundation
import CoreImage

public class CISoftLightBlendMode: ImageFilter {
    public init() {
        super.init(name: "CISoftLightBlendMode")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CISoftLightBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CISoftLightBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
}
