import Foundation
import CoreImage

public class CISubtractBlendMode: ImageFilter {
    public init() {
        super.init(name: "CISubtractBlendMode")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CISubtractBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CISubtractBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
}
