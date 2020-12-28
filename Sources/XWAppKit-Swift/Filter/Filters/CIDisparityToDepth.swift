import Foundation
import CoreImage

public class CIDisparityToDepth: ImageFilter {
    public init() {
        super.init(name: "CIDisparityToDepth")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIDisparityToDepth {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
