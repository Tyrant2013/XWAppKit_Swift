import Foundation
import CoreImage

public class CIColumnAverage: ImageFilter {
    public init() {
        super.init(name: "CIColumnAverage")
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIColumnAverage {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIColumnAverage {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
