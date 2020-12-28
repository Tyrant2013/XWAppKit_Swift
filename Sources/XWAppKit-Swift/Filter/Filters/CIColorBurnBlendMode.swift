import Foundation
import CoreImage

public class CIColorBurnBlendMode: ImageFilter {
    init() {
        super.init(name: "CIColorBurnBlendMode")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIColorBurnBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIColorBurnBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
}
