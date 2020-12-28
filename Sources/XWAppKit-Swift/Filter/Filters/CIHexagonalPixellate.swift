import Foundation
import CoreImage

public class CIHexagonalPixellate: ImageFilter {
    init() {
        super.init(name: "CIHexagonalPixellate")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIHexagonalPixellate {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputScale(_ inputScale: Double) -> CIHexagonalPixellate {
        filter.setValue(inputScale, forKey:"inputScale")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIHexagonalPixellate {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
}
