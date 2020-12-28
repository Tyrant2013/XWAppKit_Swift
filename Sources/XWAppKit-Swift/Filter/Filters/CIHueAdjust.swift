import Foundation
import CoreImage

public class CIHueAdjust: ImageFilter {
    init() {
        super.init(name: "CIHueAdjust")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIHueAdjust {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CIHueAdjust {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
}
