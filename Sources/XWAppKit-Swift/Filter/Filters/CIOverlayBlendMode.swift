import Foundation
import CoreImage

public class CIOverlayBlendMode: ImageFilter {
    public init() {
        super.init(name: "CIOverlayBlendMode")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIOverlayBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIOverlayBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
}
