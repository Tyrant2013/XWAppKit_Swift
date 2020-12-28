import Foundation
import CoreImage

public class CIAreaMaximum: ImageFilter {
    init() {
        super.init(name: "CIAreaMaximum")
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIAreaMaximum {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIAreaMaximum {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
