//
//  SearchCityUIKitView.swift
//  CitiesSearch
//
//  Created by Diego Dos Santos on 26/04/21.
//

import SwiftUI
import UIKit

struct CityListViewRepresentation: UIViewControllerRepresentable {
    typealias UIViewControllerType = CityListViewController
    
    @Binding var cityList: [City]
    var didSelectRowAt: (Int) -> ()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(didSelectRowAt: didSelectRowAt)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CityListViewRepresentation>) -> CityListViewController {
        let viewController = CityListViewController()
        viewController.tableView.delegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: CityListViewController, context: UIViewControllerRepresentableContext<CityListViewRepresentation>) {
        uiViewController.cityList = cityList
    }
}

extension CityListViewRepresentation {
    class Coordinator: NSObject, UITableViewDelegate {
        private let didSelectRowAt: (Int) -> ()

        init(didSelectRowAt: @escaping (Int) -> ()) {
            self.didSelectRowAt = didSelectRowAt
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.didSelectRowAt(indexPath.row)
        }
    }
}

class CityListViewController: UIViewController {
    
    private let defaultCellId = "defaultCellId"
    var tableView = UITableView()
    var cityList = [City]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellId)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.tableView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leadingMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.tableView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailingMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.tableView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.topMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.tableView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottomMargin, multiplier: 1.0, constant: 0.0).isActive = true
    }
}

extension CityListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = cityList[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: self.defaultCellId)
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.textLabel?.text = "\(city.name), \(city.country)"
        cell.detailTextLabel?.text = "(\(city.coord.lon), \(city.coord.lat))"
        return cell
    }
}
