import Foundation
import CoreImage

public class CIBlendWithBlueMask: ImageFilter {
    public init() {
        super.init(name: "CIBlendWithBlueMask")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIBlendWithBlueMask {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIBlendWithBlueMask {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    public func inputMaskImage(_ inputMaskImage: CIImage?) -> CIBlendWithBlueMask {
        filter.setValue(inputMaskImage, forKey:"inputMaskImage")
        return self
    }
}
