import Foundation
import CoreImage

public class CIMedianFilter: ImageFilter {
    init() {
        super.init(name: "CIMedianFilter")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIMedianFilter {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
