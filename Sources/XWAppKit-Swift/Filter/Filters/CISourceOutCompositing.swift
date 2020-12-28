import Foundation
import CoreImage

public class CISourceOutCompositing: ImageFilter {
    init() {
        super.init(name: "CISourceOutCompositing")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CISourceOutCompositing {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CISourceOutCompositing {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
}
