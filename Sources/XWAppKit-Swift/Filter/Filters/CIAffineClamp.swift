import Foundation
import CoreImage

public class CIAffineClamp: ImageFilter {
    init() {
        super.init(name: "CIAffineClamp")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIAffineClamp {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputTransform(_ inputTransform: NSValue?) -> CIAffineClamp {
        filter.setValue(inputTransform, forKey:"inputTransform")
        return self
    }
}
