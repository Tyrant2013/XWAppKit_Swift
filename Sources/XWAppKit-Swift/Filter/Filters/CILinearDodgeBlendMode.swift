import Foundation
import CoreImage

public class CILinearDodgeBlendMode: ImageFilter {
    public init() {
        super.init(name: "CILinearDodgeBlendMode")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CILinearDodgeBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CILinearDodgeBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
}
