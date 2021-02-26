

import UIKit


class ResultViewController: UIViewController {
    var resultingScore: Int?
    var delegate: ViewControllerDelegate?
    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "\(String(describing: resultingScore!))"
        self.delegate?.restoreData()
    }
    
    @IBAction func tryAgainPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.delegate?.restoreTimer()
    }
    

    
    
    


}
