import Foundation
import CoreImage

public class CISaturationBlendMode: ImageFilter {
    init() {
        super.init(name: "CISaturationBlendMode")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CISaturationBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CISaturationBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
