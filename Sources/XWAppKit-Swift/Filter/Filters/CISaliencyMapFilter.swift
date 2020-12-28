import Foundation
import CoreImage

public class CISaliencyMapFilter: ImageFilter {
    init() {
        super.init(name: "CISaliencyMapFilter")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CISaliencyMapFilter {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
