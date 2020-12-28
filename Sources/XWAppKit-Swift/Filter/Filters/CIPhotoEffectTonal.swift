import Foundation
import CoreImage

public class CIPhotoEffectTonal: ImageFilter {
    public init() {
        super.init(name: "CIPhotoEffectTonal")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPhotoEffectTonal {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
