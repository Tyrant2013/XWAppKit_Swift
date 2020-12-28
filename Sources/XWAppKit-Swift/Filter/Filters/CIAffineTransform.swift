import Foundation
import CoreImage

public class CIAffineTransform: ImageFilter {
    init() {
        super.init(name: "CIAffineTransform")
    }
    public func inputTransform(_ inputTransform: NSValue?) -> CIAffineTransform {
        filter.setValue(inputTransform, forKey:"inputTransform")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIAffineTransform {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
