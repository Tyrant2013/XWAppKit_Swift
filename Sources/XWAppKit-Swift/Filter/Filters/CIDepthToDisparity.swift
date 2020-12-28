import Foundation
import CoreImage

public class CIDepthToDisparity: ImageFilter {
    init() {
        super.init(name: "CIDepthToDisparity")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIDepthToDisparity {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
