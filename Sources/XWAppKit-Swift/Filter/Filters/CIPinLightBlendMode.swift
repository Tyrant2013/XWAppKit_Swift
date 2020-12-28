import Foundation
import CoreImage

public class CIPinLightBlendMode: ImageFilter {
    public init() {
        super.init(name: "CIPinLightBlendMode")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIPinLightBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPinLightBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
