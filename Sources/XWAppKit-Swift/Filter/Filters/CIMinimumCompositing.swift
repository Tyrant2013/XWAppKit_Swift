import Foundation
import CoreImage

public class CIMinimumCompositing: ImageFilter {
    init() {
        super.init(name: "CIMinimumCompositing")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIMinimumCompositing {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIMinimumCompositing {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
