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
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CityListViewRepresentation>) -> CityListViewController {
        return CityListViewController()
    }

    func updateUIViewController(_ uiViewController: CityListViewController, context: UIViewControllerRepresentableContext<CityListViewRepresentation>) {
        var snapshot = uiViewController.dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(cityList, toSection: .cities)
        uiViewController.dataSource.apply(snapshot)
    }
}

class CityListViewController: UIViewController {
    
    private let defaultCellId = "defaultCellId"
    private var tableView = UITableView()
    var dataSource: UITableViewDiffableDataSource<Section, City>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.makeDataSource()
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellId)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.tableView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leadingMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.tableView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailingMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.tableView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.topMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.tableView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottomMargin, multiplier: 1.0, constant: 0.0).isActive = true
    }
    
    private func makeDataSource() {
        self.dataSource = UITableViewDiffableDataSource<Section, City>(tableView: self.tableView) { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: self.defaultCellId)
            cell.textLabel?.text = "\(item.name), \(item.country)"
            cell.detailTextLabel?.text = "(\(item.coord.lon), \(item.coord.lat))"
            return cell
        }
    }
}

enum Section: Int, CaseIterable {
    case cities
}
