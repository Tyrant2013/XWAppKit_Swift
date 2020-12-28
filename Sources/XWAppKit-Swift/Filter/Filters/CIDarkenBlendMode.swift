import Foundation
import CoreImage

public class CIDarkenBlendMode: ImageFilter {
    init() {
        super.init(name: "CIDarkenBlendMode")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIDarkenBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIDarkenBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
}
