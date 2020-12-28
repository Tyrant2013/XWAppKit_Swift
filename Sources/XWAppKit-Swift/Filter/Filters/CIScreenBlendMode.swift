import Foundation
import CoreImage

public class CIScreenBlendMode: ImageFilter {
    public init() {
        super.init(name: "CIScreenBlendMode")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIScreenBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIScreenBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
