import Foundation
import CoreImage

public class CISourceInCompositing: ImageFilter {
    init() {
        super.init(name: "CISourceInCompositing")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CISourceInCompositing {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CISourceInCompositing {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
