import Foundation
import CoreImage

public class CIAttributedTextImageGenerator: ImageFilter {
    init() {
        super.init(name: "CIAttributedTextImageGenerator")
    }
    public func inputText(_ inputText: NSAttributedString?) -> CIAttributedTextImageGenerator {
        filter.setValue(inputText, forKey:"inputText")
        return self
    }
    public func inputScaleFactor(_ inputScaleFactor: Double) -> CIAttributedTextImageGenerator {
        filter.setValue(inputScaleFactor, forKey:"inputScaleFactor")
        return self
    }
}
