import Foundation
import CoreImage

public class CIPalettize: ImageFilter {
    init() {
        super.init(name: "CIPalettize")
    }
    public func inputPerceptual(_ inputPerceptual: Double) -> CIPalettize {
        filter.setValue(inputPerceptual, forKey:"inputPerceptual")
        return self
    }
    public func inputPaletteImage(_ inputPaletteImage: CIImage?) -> CIPalettize {
        filter.setValue(inputPaletteImage, forKey:"inputPaletteImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPalettize {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
