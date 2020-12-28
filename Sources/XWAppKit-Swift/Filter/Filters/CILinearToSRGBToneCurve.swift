import Foundation
import CoreImage

public class CILinearToSRGBToneCurve: ImageFilter {
    public init() {
        super.init(name: "CILinearToSRGBToneCurve")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CILinearToSRGBToneCurve {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
