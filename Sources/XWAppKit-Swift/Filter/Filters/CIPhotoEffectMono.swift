import Foundation
import CoreImage

public class CIPhotoEffectMono: ImageFilter {
    init() {
        super.init(name: "CIPhotoEffectMono")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPhotoEffectMono {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
