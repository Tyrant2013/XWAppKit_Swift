import Foundation
import CoreImage

public class CIClamp: ImageFilter {
    init() {
        super.init(name: "CIClamp")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIClamp {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIClamp {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
}
