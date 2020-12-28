import Foundation
import CoreImage

public class CIAffineTile: ImageFilter {
    public init() {
        super.init(name: "CIAffineTile")
    }
    public func inputTransform(_ inputTransform: NSValue?) -> CIAffineTile {
        filter.setValue(inputTransform, forKey:"inputTransform")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIAffineTile {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
