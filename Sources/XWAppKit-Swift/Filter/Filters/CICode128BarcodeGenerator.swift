import Foundation
import CoreImage

public class CICode128BarcodeGenerator: ImageFilter {
    public init() {
        super.init(name: "CICode128BarcodeGenerator")
    }
    public func inputMessage(_ inputMessage: NSData?) -> CICode128BarcodeGenerator {
        filter.setValue(inputMessage, forKey:"inputMessage")
        return self
    }
    public func inputBarcodeHeight(_ inputBarcodeHeight: Double) -> CICode128BarcodeGenerator {
        filter.setValue(inputBarcodeHeight, forKey:"inputBarcodeHeight")
        return self
    }
    public func inputQuietSpace(_ inputQuietSpace: Double) -> CICode128BarcodeGenerator {
        filter.setValue(inputQuietSpace, forKey:"inputQuietSpace")
        return self
    }
}
