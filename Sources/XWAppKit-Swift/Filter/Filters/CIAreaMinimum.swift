import Foundation
import CoreImage

public class CIAreaMinimum: ImageFilter {
    init() {
        super.init(name: "CIAreaMinimum")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIAreaMinimum {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIAreaMinimum {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
}
