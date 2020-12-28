import Foundation
import CoreImage

public class CIQRCodeGenerator: ImageFilter {
    public init() {
        super.init(name: "CIQRCodeGenerator")
    }
    public func inputMessage(_ inputMessage: NSData?) -> CIQRCodeGenerator {
        filter.setValue(inputMessage, forKey:"inputMessage")
        return self
    }
    public func inputCorrectionLevel(_ inputCorrectionLevel: NSString?) -> CIQRCodeGenerator {
        filter.setValue(inputCorrectionLevel, forKey:"inputCorrectionLevel")
        return self
    }
}
