import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    self.contentViewController = flutterViewController
    // Open at a phone-like size since MyShop is a mobile layout.
    let phoneSize = NSSize(width: 430, height: 900)
    self.setContentSize(phoneSize)
    self.contentMinSize = NSSize(width: 320, height: 568)
    self.center()

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
