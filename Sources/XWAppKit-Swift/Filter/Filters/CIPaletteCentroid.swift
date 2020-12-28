import Foundation
import CoreImage

public class CIPaletteCentroid: ImageFilter {
    public init() {
        super.init(name: "CIPaletteCentroid")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPaletteCentroid {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputPaletteImage(_ inputPaletteImage: CIImage?) -> CIPaletteCentroid {
        filter.setValue(inputPaletteImage, forKey:"inputPaletteImage")
        return self
    }
    public func inputPerceptual(_ inputPerceptual: Double) -> CIPaletteCentroid {
        filter.setValue(inputPerceptual, forKey:"inputPerceptual")
        return self
    }
}
