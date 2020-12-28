import Foundation
import CoreImage

public class CIPhotoEffectChrome: ImageFilter {
    public init() {
        super.init(name: "CIPhotoEffectChrome")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPhotoEffectChrome {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
