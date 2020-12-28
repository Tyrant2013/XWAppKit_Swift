import Foundation
import CoreImage

public class CIPhotoEffectFade: ImageFilter {
    public init() {
        super.init(name: "CIPhotoEffectFade")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPhotoEffectFade {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
