//
//  ScriptsTableViewController.swift
//  Extension
//
//  Created by Николай Никитин on 27.01.2022.
//

import UIKit

class ScriptsTableViewController: UITableViewController {


  //MARK: - Properties
  var scripts: [Script]?
  weak var delegate: ScriptDelegate?

  //MARK: - UIVIewContriller lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ScriptCell")
  }

  //MARK: - Methods
  @objc func cancel() {
    navigationController?.popViewController(animated: true)
  }
}

// MARK: - UITableViewDataSource Protocol
extension ScriptsTableViewController {

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let scripts = scripts else { return 1 }
    return scripts.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ScriptCell", for: indexPath)
    guard let scripts = scripts else {
      return UITableViewCell()
    }
    let script = scripts[indexPath.row]
    cell.textLabel?.text = script.name
    return cell
  }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    switch editingStyle {
    case .delete:
      guard let scripts = scripts else { return }
      let deletingScript = scripts[indexPath.row]
      delegate?.deleteSelectedScript(scriptString: deletingScript.name)
      navigationController?.popViewController(animated: true)
    case .insert:
      break
    case .none:
      break
    @unknown default:
      break
    }
  }
}

//MARK: - UITableViewDelegate Protocol
extension ScriptsTableViewController {

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let scripts = scripts else { return }
    let selectedScript = scripts[indexPath.row]
    delegate?.loadSelectedScript(scriptString: selectedScript.script)
    navigationController?.popViewController(animated: true)
  }
}
