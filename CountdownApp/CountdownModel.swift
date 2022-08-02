import Foundation

class CountdownModel {
    
    var seconds: TimeInterval?
    
    func startCounting(from seconds: TimeInterval) {
        self.seconds = seconds
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            guard let seconds = self.seconds else {
                return
            }
            let newSeconds = seconds - 1
            if newSeconds >= 0 {
                self.seconds = newSeconds
                // We brodcast that an update has occured
                NotificationCenter.default.post(name: Notification.Name("SecondsHasUpdated"), object: nil)
            } else {
                timer.invalidate()
                // We brodcast that counting down has finished
                NotificationCenter.default.post(name: Notification.Name("CountdownIsDone"), object: nil)
            }
        }
    }
}
