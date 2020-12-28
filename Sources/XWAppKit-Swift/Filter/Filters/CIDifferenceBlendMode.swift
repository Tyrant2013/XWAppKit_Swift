import Foundation
import CoreImage

public class CIDifferenceBlendMode: ImageFilter {
    public init() {
        super.init(name: "CIDifferenceBlendMode")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIDifferenceBlendMode {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIDifferenceBlendMode {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
