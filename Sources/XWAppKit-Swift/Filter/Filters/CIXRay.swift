import Foundation
import CoreImage

public class CIXRay: ImageFilter {
    public init() {
        super.init(name: "CIXRay")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIXRay {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
