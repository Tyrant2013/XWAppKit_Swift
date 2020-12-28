import Foundation
import CoreImage

public class CIPDF417BarcodeGenerator: ImageFilter {
    init() {
        super.init(name: "CIPDF417BarcodeGenerator")
    }
    public func inputDataColumns(_ inputDataColumns: Double) -> CIPDF417BarcodeGenerator {
        filter.setValue(inputDataColumns, forKey:"inputDataColumns")
        return self
    }
    public func inputMessage(_ inputMessage: NSData?) -> CIPDF417BarcodeGenerator {
        filter.setValue(inputMessage, forKey:"inputMessage")
        return self
    }
    public func inputMaxWidth(_ inputMaxWidth: Double) -> CIPDF417BarcodeGenerator {
        filter.setValue(inputMaxWidth, forKey:"inputMaxWidth")
        return self
    }
    public func inputCorrectionLevel(_ inputCorrectionLevel: Double) -> CIPDF417BarcodeGenerator {
        filter.setValue(inputCorrectionLevel, forKey:"inputCorrectionLevel")
        return self
    }
    public func inputRows(_ inputRows: Double) -> CIPDF417BarcodeGenerator {
        filter.setValue(inputRows, forKey:"inputRows")
        return self
    }
    public func inputMinWidth(_ inputMinWidth: Double) -> CIPDF417BarcodeGenerator {
        filter.setValue(inputMinWidth, forKey:"inputMinWidth")
        return self
    }
    public func inputCompactionMode(_ inputCompactionMode: Double) -> CIPDF417BarcodeGenerator {
        filter.setValue(inputCompactionMode, forKey:"inputCompactionMode")
        return self
    }
    public func inputCompactStyle(_ inputCompactStyle: Double) -> CIPDF417BarcodeGenerator {
        filter.setValue(inputCompactStyle, forKey:"inputCompactStyle")
        return self
    }
    public func inputPreferredAspectRatio(_ inputPreferredAspectRatio: Double) -> CIPDF417BarcodeGenerator {
        filter.setValue(inputPreferredAspectRatio, forKey:"inputPreferredAspectRatio")
        return self
    }
    public func inputMaxHeight(_ inputMaxHeight: Double) -> CIPDF417BarcodeGenerator {
        filter.setValue(inputMaxHeight, forKey:"inputMaxHeight")
        return self
    }
    public func inputAlwaysSpecifyCompaction(_ inputAlwaysSpecifyCompaction: Double) -> CIPDF417BarcodeGenerator {
        filter.setValue(inputAlwaysSpecifyCompaction, forKey:"inputAlwaysSpecifyCompaction")
        return self
    }
    public func inputMinHeight(_ inputMinHeight: Double) -> CIPDF417BarcodeGenerator {
        filter.setValue(inputMinHeight, forKey:"inputMinHeight")
        return self
    }
}
