import Foundation
import CoreImage

public class CIColorDodgeBlendMode: ImageFilter {
    init() {
        super.init(name: "CIColorDodgeBlendMode")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIColorDodgeBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIColorDodgeBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
}
