import Foundation
import CoreImage

public class CIComicEffect: ImageFilter {
    init() {
        super.init(name: "CIComicEffect")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIComicEffect {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
