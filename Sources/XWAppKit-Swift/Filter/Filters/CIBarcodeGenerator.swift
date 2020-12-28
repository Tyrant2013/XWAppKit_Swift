import Foundation
import CoreImage

@available(iOS 11.0, *)
public class CIBarcodeGenerator: ImageFilter {
    public init() {
        super.init(name: "CIBarcodeGenerator")
    }
    public func inputBarcodeDescriptor(_ inputBarcodeDescriptor: CIBarcodeDescriptor?) -> CIBarcodeGenerator {
        filter.setValue(inputBarcodeDescriptor, forKey:"inputBarcodeDescriptor")
        return self
    }
}
