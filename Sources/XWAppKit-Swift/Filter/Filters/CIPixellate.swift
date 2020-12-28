import Foundation
import CoreImage

public class CIPixellate: ImageFilter {
    public init() {
        super.init(name: "CIPixellate")
    }
    public func inputScale(_ inputScale: Double) -> CIPixellate {
        filter.setValue(inputScale, forKey:"inputScale")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIPixellate {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPixellate {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
