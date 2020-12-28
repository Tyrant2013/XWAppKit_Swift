import Foundation
import CoreImage

public class CIAreaMinMaxRed: ImageFilter {
    init() {
        super.init(name: "CIAreaMinMaxRed")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIAreaMinMaxRed {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIAreaMinMaxRed {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
}
