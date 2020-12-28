import Foundation
import CoreImage

public class CIMaximumComponent: ImageFilter {
    init() {
        super.init(name: "CIMaximumComponent")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIMaximumComponent {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
