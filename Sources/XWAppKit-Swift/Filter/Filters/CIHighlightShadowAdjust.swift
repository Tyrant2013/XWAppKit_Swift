import Foundation
import CoreImage

public class CIHighlightShadowAdjust: ImageFilter {
    init() {
        super.init(name: "CIHighlightShadowAdjust")
    }
    public func inputHighlightAmount(_ inputHighlightAmount: Double) -> CIHighlightShadowAdjust {
        filter.setValue(inputHighlightAmount, forKey:"inputHighlightAmount")
        return self
    }
    public func inputShadowAmount(_ inputShadowAmount: Double) -> CIHighlightShadowAdjust {
        filter.setValue(inputShadowAmount, forKey:"inputShadowAmount")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIHighlightShadowAdjust {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIHighlightShadowAdjust {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
}
