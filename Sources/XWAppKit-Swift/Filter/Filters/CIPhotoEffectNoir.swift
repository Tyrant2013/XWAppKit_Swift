import Foundation
import CoreImage

public class CIPhotoEffectNoir: ImageFilter {
    init() {
        super.init(name: "CIPhotoEffectNoir")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPhotoEffectNoir {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
