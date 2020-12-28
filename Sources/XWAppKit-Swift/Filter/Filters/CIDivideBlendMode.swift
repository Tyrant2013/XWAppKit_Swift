import Foundation
import CoreImage

public class CIDivideBlendMode: ImageFilter {
    public init() {
        super.init(name: "CIDivideBlendMode")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIDivideBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIDivideBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
