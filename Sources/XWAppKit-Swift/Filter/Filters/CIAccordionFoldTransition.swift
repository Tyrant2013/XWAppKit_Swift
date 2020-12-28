import Foundation
import CoreImage

public class CIAccordionFoldTransition: ImageFilter {
    public init() {
        super.init(name: "CIAccordionFoldTransition")
    }
    public func inputTargetImage(_ inputTargetImage: CIImage?) -> CIAccordionFoldTransition {
        filter.setValue(inputTargetImage, forKey:"inputTargetImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIAccordionFoldTransition {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputFoldShadowAmount(_ inputFoldShadowAmount: Double) -> CIAccordionFoldTransition {
        filter.setValue(inputFoldShadowAmount, forKey:"inputFoldShadowAmount")
        return self
    }
    public func inputTime(_ inputTime: Double) -> CIAccordionFoldTransition {
        filter.setValue(inputTime, forKey:"inputTime")
        return self
    }
    public func inputNumberOfFolds(_ inputNumberOfFolds: Double) -> CIAccordionFoldTransition {
        filter.setValue(inputNumberOfFolds, forKey:"inputNumberOfFolds")
        return self
    }
    public func inputBottomHeight(_ inputBottomHeight: Double) -> CIAccordionFoldTransition {
        filter.setValue(inputBottomHeight, forKey:"inputBottomHeight")
        return self
    }
}
