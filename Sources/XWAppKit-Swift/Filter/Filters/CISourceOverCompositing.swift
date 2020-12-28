import Foundation
import CoreImage

public class CISourceOverCompositing: ImageFilter {
    init() {
        super.init(name: "CISourceOverCompositing")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CISourceOverCompositing {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CISourceOverCompositing {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
