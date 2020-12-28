import Foundation
import CoreImage

public class CILinearBurnBlendMode: ImageFilter {
    init() {
        super.init(name: "CILinearBurnBlendMode")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CILinearBurnBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CILinearBurnBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
