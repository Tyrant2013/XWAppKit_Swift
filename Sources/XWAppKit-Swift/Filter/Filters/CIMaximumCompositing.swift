import Foundation
import CoreImage

public class CIMaximumCompositing: ImageFilter {
    init() {
        super.init(name: "CIMaximumCompositing")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIMaximumCompositing {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIMaximumCompositing {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
}
