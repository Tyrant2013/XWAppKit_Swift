import Foundation
import CoreImage

public class CICrop: ImageFilter {
    public init() {
        super.init(name: "CICrop")
    }
    public func inputRectangle(_ inputRectangle: CIVector?) -> CICrop {
        filter.setValue(inputRectangle, forKey:"inputRectangle")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CICrop {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
