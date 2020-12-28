import Foundation
import CoreImage

public class CILabDeltaE: ImageFilter {
    init() {
        super.init(name: "CILabDeltaE")
    }
    public func inputImage2(_ inputImage2: CIImage?) -> CILabDeltaE {
        filter.setValue(inputImage2, forKey:"inputImage2")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CILabDeltaE {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
