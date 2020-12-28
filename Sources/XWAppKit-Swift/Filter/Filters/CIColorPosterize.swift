import Foundation
import CoreImage

public class CIColorPosterize: ImageFilter {
    public init() {
        super.init(name: "CIColorPosterize")
    }
    public func inputLevels(_ inputLevels: Double) -> CIColorPosterize {
        filter.setValue(inputLevels, forKey:"inputLevels")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIColorPosterize {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
