import Foundation
import CoreImage

public class CIAreaAverage: ImageFilter {
    public init() {
        super.init(name: "CIAreaAverage")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIAreaAverage {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIAreaAverage {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
}
