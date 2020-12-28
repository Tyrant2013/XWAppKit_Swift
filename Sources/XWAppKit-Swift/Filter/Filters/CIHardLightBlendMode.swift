import Foundation
import CoreImage

public class CIHardLightBlendMode: ImageFilter {
    init() {
        super.init(name: "CIHardLightBlendMode")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIHardLightBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIHardLightBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
