import Foundation
import CoreImage

public class CILuminosityBlendMode: ImageFilter {
    public init() {
        super.init(name: "CILuminosityBlendMode")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CILuminosityBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CILuminosityBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
}
