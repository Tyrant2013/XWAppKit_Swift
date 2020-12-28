import Foundation
import CoreImage

public class CIAreaMinMax: ImageFilter {
    public init() {
        super.init(name: "CIAreaMinMax")
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIAreaMinMax {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIAreaMinMax {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
