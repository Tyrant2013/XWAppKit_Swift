import Foundation
import CoreImage

public class CIPointillize: ImageFilter {
    public init() {
        super.init(name: "CIPointillize")
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIPointillize {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPointillize {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIPointillize {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
}
