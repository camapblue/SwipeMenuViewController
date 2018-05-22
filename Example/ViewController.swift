import UIKit
import SwipeMenuViewController

final class ViewController: SwipeMenuViewController {

    private var datas: [String] = ["Bulbasaur","Caterpie", "Golem", "Jynx", "Marshtomp", "Salamence", "Riolu", "Araquanid"]

    var options = SwipeMenuViewOptions()
    var dataCount: Int = 5

    @IBOutlet private weak var settingButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.bringSubview(toFront: settingButton)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popupSegue" {
            let vc = segue.destination as! PopupViewController
            vc.options = options
            vc.dataCount = dataCount
            vc.reloadClosure = { self.reload() }
        }
    }

    private func reload() {
        options.tabView.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
        options.tabView.margin = 16
        options.tabView.itemView.margin = 16
        options.tabView.underlineView.height = 2
        
        swipeMenuView.reloadData(options: options)
    }

    // MARK: - SwipeMenuViewDelegate

    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewWillSetupAt currentIndex: Int) {
        print("will setup SwipeMenuView")
    }

    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewDidSetupAt currentIndex: Int) {
        print("did setup SwipeMenuView")
    }

    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        print("will change from section\(fromIndex + 1)  to section\(toIndex + 1)")
    }

    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        print("did change from section\(fromIndex + 1)  to section\(toIndex + 1)")
    }

    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, scrollViewDidScroll scrollView: UIScrollView) {
        print("did scroll to \(scrollView.contentOffset.x)")
    }
    
    // MARK - SwipeMenuViewDataSource

    override func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return dataCount
    }

    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return datas[index]
    }

    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        let vc = ContentViewController()
        vc.content = datas[index]
        return vc
    }
}
