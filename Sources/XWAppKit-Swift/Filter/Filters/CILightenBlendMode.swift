import Foundation
import CoreImage

public class CILightenBlendMode: ImageFilter {
    public init() {
        super.init(name: "CILightenBlendMode")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CILightenBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CILightenBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
