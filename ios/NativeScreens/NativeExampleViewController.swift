import UIKit

/// Native (UIKit) screen pushed onto the nav stack. Close button or system swipe-back pops; onPopCallback runs when removed.
final class NativeExampleViewController: UIViewController {

  private let titleText: String
  private let onClose: () -> Void

  /// Called when this VC is popped (button or interactive swipe-back). Set by the module.
  var onPopCallback: (() -> Void)?

  init(title: String, onClose: @escaping () -> Void) {
    self.titleText = title
    self.onClose = onClose
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if isMovingFromParent {
      onPopCallback?()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground

    title = titleText
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: "Close",
      style: .plain,
      target: self,
      action: #selector(closeTapped)
    )

    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = titleText
    label.font = .systemFont(ofSize: 24, weight: .medium)
    label.textAlignment = .center
    view.addSubview(label)

    let closeButton = UIButton(type: .system)
    closeButton.translatesAutoresizingMaskIntoConstraints = false
    closeButton.setTitle("Close", for: .normal)
    closeButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
    closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
    view.addSubview(closeButton)

    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
      label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
      label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
      closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      closeButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 32),
    ])
  }

  @objc private func closeTapped() {
    onClose()
  }
}
