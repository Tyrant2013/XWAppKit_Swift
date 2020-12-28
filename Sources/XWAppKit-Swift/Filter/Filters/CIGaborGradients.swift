import Foundation
import CoreImage

public class CIGaborGradients: ImageFilter {
    public init() {
        super.init(name: "CIGaborGradients")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIGaborGradients {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
