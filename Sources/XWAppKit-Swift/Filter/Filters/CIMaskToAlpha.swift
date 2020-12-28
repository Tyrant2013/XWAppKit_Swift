import Foundation
import CoreImage

public class CIMaskToAlpha: ImageFilter {
    init() {
        super.init(name: "CIMaskToAlpha")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIMaskToAlpha {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
