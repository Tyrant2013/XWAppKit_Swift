import Foundation
import CoreImage

public class CIColorClamp: ImageFilter {
    init() {
        super.init(name: "CIColorClamp")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIColorClamp {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputMinComponents(_ inputMinComponents: CIVector?) -> CIColorClamp {
        filter.setValue(inputMinComponents, forKey:"inputMinComponents")
        return self
    }
    public func inputMaxComponents(_ inputMaxComponents: CIVector?) -> CIColorClamp {
        filter.setValue(inputMaxComponents, forKey:"inputMaxComponents")
        return self
    }
}
