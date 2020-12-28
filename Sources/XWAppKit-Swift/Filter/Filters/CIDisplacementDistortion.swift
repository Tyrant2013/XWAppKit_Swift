import Foundation
import CoreImage

public class CIDisplacementDistortion: ImageFilter {
    init() {
        super.init(name: "CIDisplacementDistortion")
    }
    public func inputDisplacementImage(_ inputDisplacementImage: CIImage?) -> CIDisplacementDistortion {
        filter.setValue(inputDisplacementImage, forKey:"inputDisplacementImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIDisplacementDistortion {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputScale(_ inputScale: Double) -> CIDisplacementDistortion {
        filter.setValue(inputScale, forKey:"inputScale")
        return self
    }
}
