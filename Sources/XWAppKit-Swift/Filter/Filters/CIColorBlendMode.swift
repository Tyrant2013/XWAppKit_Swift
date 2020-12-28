import Foundation
import CoreImage

public class CIColorBlendMode: ImageFilter {
    public init() {
        super.init(name: "CIColorBlendMode")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIColorBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIColorBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
