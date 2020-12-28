import Foundation
import CoreImage

public class CIHueBlendMode: ImageFilter {
    init() {
        super.init(name: "CIHueBlendMode")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIHueBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIHueBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
}
