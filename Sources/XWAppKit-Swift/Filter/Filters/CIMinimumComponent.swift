import Foundation
import CoreImage

public class CIMinimumComponent: ImageFilter {
    public init() {
        super.init(name: "CIMinimumComponent")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIMinimumComponent {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
