import UIKit

class CountdownViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    let model = CountdownModel()
    
    var seconds: TimeInterval? {
        get {
            guard
                let secondsString = numberTextField.text,
                let seconds = Double(secondsString)
            else {
                return nil
            }
            return seconds
        }
        set {
            guard let seconds = newValue else {
                numberTextField.text = ""
                return
            }
            numberTextField.text = "\(seconds)"
        }
    }

    @IBAction func startButtonTapped(_ sender: Any) {
        guard let seconds = self.seconds else {
            return
        }
        model.startCounting(from: seconds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Subscribe to the channel we are interested in!
        NotificationCenter.default.addObserver(self, selector: #selector(updateFromModel), name: Notification.Name("SecondsHasUpdated"), object: nil)
    }
    
    @objc func updateFromModel() {
        seconds = model.seconds
    }
}

