import Foundation
import CoreImage

public class CIDocumentEnhancer: ImageFilter {
    public init() {
        super.init(name: "CIDocumentEnhancer")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIDocumentEnhancer {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputAmount(_ inputAmount: Double) -> CIDocumentEnhancer {
        filter.setValue(inputAmount, forKey:"inputAmount")
        return self
    }
}
