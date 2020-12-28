import Foundation
import CoreImage

public class CIAdditionCompositing: ImageFilter {
    public init() {
        super.init(name: "CIAdditionCompositing")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIAdditionCompositing {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIAdditionCompositing {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
