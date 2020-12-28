import Foundation
import CoreImage

public class CIPhotoEffectInstant: ImageFilter {
    public init() {
        super.init(name: "CIPhotoEffectInstant")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPhotoEffectInstant {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
