import Foundation
import CoreImage

public class CIRowAverage: ImageFilter {
    public init() {
        super.init(name: "CIRowAverage")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIRowAverage {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIRowAverage {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
}
