import Foundation
import CoreImage

public class CIPhotoEffectTransfer: ImageFilter {
    public init() {
        super.init(name: "CIPhotoEffectTransfer")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPhotoEffectTransfer {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
