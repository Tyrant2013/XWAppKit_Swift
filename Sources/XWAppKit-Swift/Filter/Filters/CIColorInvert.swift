import Foundation
import CoreImage

public class CIColorInvert: ImageFilter {
    init() {
        super.init(name: "CIColorInvert")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIColorInvert {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
