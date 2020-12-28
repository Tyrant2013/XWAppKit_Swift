import Foundation
import CoreImage

public class CIVibrance: ImageFilter {
    init() {
        super.init(name: "CIVibrance")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIVibrance {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputAmount(_ inputAmount: Double) -> CIVibrance {
        filter.setValue(inputAmount, forKey:"inputAmount")
        return self
    }
}
