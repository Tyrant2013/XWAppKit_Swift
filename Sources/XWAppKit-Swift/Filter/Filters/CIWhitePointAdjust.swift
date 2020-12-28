import Foundation
import CoreImage

public class CIWhitePointAdjust: ImageFilter {
    public init() {
        super.init(name: "CIWhitePointAdjust")
    }
    override public func inputColor(_ inputColor: CIColor?) -> CIWhitePointAdjust {
        filter.setValue(inputColor, forKey:"inputColor")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIWhitePointAdjust {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
