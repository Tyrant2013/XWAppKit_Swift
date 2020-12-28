import Foundation
import CoreImage

public class CIExclusionBlendMode: ImageFilter {
    init() {
        super.init(name: "CIExclusionBlendMode")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIExclusionBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIExclusionBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
}
