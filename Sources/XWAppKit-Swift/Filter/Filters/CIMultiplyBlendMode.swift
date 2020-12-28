import Foundation
import CoreImage

public class CIMultiplyBlendMode: ImageFilter {
    public init() {
        super.init(name: "CIMultiplyBlendMode")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIMultiplyBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIMultiplyBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
