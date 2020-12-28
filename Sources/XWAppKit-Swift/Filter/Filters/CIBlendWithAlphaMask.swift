import Foundation
import CoreImage

public class CIBlendWithAlphaMask: ImageFilter {
    init() {
        super.init(name: "CIBlendWithAlphaMask")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIBlendWithAlphaMask {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputMaskImage(_ inputMaskImage: CIImage?) -> CIBlendWithAlphaMask {
        filter.setValue(inputMaskImage, forKey:"inputMaskImage")
        return self
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIBlendWithAlphaMask {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
}
