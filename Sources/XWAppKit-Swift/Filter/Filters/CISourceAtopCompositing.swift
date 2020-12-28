import Foundation
import CoreImage

public class CISourceAtopCompositing: ImageFilter {
    public init() {
        super.init(name: "CISourceAtopCompositing")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CISourceAtopCompositing {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CISourceAtopCompositing {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
