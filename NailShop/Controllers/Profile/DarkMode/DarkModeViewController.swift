//
//  DarkModeViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/8/23.
//

import UIKit

class DarkModeViewController: UITableViewController {
    
    static func instantiate() -> DarkModeViewController {
        let controller = Account.instantiateViewController(withIdentifier: String(describing: self)) as! DarkModeViewController
        return controller
    }
    
    private var darkModes: [DarkModeModel] = DarkModeModel.darkModes
    private var defaults = UserDefaults.standard
    private var theme: Theme {
        get {
            return defaults.theme
        }
        set {
            defaults.theme = newValue
            configureStyle(for: newValue)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dark Mode"
        configureCell(for: theme, checked: true)
        tabBarController?.tabBar.isHidden = true
        tableView.backgroundColor = .colorBackground
        navigationController?.isNavigationBarHidden = false
        tableView.register(DarkModeTableViewCell.nib, forCellReuseIdentifier: DarkModeTableViewCell.identifier)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = true
    }
}

extension DarkModeViewController {
    private func configureCell(for theme: Theme, checked: Bool) {
        let cell = tableView.cellForRow(at: IndexPath(row: theme.rawValue, section: 0)) as? DarkModeTableViewCell
        cell?.checkIcon.isHidden = checked ? true : false
    }

    private func configureStyle(for theme: Theme) {
        view.window?.overrideUserInterfaceStyle = theme.userInterfaceStyle
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return darkModes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DarkModeTableViewCell.identifier, for: indexPath) as? DarkModeTableViewCell else { return UITableViewCell() }
        cell.darkMode = darkModes[indexPath.row]
        cell.checkIcon.isHidden = (darkModes[indexPath.row].mode == theme) ? false : true
        cell.separatorInset = .zero
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != theme.rawValue {
            configureCell(for: theme, checked: false)
            theme = Theme(rawValue: indexPath.row) ?? .device
            configureCell(for: theme, checked: true)
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
