import Foundation
import CoreImage

public class CIPhotoEffectProcess: ImageFilter {
    init() {
        super.init(name: "CIPhotoEffectProcess")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPhotoEffectProcess {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
