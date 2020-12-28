import Foundation
import CoreImage

public class CIMultiplyCompositing: ImageFilter {
    init() {
        super.init(name: "CIMultiplyCompositing")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIMultiplyCompositing {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIMultiplyCompositing {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
