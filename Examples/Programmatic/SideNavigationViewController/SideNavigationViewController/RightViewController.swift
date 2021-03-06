/*
* Copyright (C) 2015 - 2016, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.io>.
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*	*	Redistributions of source code must retain the above copyright notice, this
*		list of conditions and the following disclaimer.
*
*	*	Redistributions in binary form must reproduce the above copyright notice,
*		this list of conditions and the following disclaimer in the documentation
*		and/or other materials provided with the distribution.
*
*	*	Neither the name of Material nor the names of its
*		contributors may be used to endorse or promote products derived from
*		this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
* AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
* IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
* FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
* DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
* CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
* OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
* OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/*
The following is an example of setting a UITableView as the RightViewController
within a SideNavigationViewController.
*/

import UIKit
import Material

private struct Cell {
	var text: String
	var imageName: String
	var selected: Bool
}

class RightViewController: UIViewController {
	/// A tableView used to display navigation items.
	private let tableView: UITableView = UITableView()
	
	/// A list of all the navigation items.
	private var items: Array<Cell> = Array<Cell>()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		prepareView()
		prepareCells()
		prepareTableView()
	}
	
	/// General preparation statements.
	private func prepareView() {
		view.backgroundColor = MaterialColor.blueGrey.darken4
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	
	/// Prepares the items that are displayed within the tableView.
	private func prepareCells() {
		items.append(Cell(text: "Inbox", imageName: "ic_inbox", selected: false))
		items.append(Cell(text: "Today", imageName: "ic_today", selected: true))
		items.append(Cell(text: "Bookmarks", imageName: "ic_book", selected: false))
		items.append(Cell(text: "Work", imageName: "ic_work", selected: false))
		items.append(Cell(text: "Contacts", imageName: "ic_contacts", selected: false))
		items.append(Cell(text: "Settings", imageName: "ic_settings", selected: false))
	}
	
	/// Prepares the tableView.
	private func prepareTableView() {
		tableView.registerClass(MaterialTableViewCell.self, forCellReuseIdentifier: "MaterialTableViewCell")
		tableView.backgroundColor = MaterialColor.clear
		tableView.dataSource = self
		tableView.delegate = self
		tableView.separatorStyle = .None
		
		// Use MaterialLayout to easily align the tableView.
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		MaterialLayout.alignToParent(view, child: tableView)
	}
}

/// TableViewDataSource methods.
extension RightViewController: UITableViewDataSource {
	/// Determines the number of rows in the tableView.
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count;
	}
	
	/// Prepares the cells within the tableView.
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell: MaterialTableViewCell = tableView.dequeueReusableCellWithIdentifier("MaterialTableViewCell", forIndexPath: indexPath) as! MaterialTableViewCell
		cell.backgroundColor = MaterialColor.clear
		
		let item: Cell = items[indexPath.row]
		cell.textLabel!.text = item.text
		cell.textLabel!.font = RobotoFont.medium
		cell.imageView!.image = UIImage(named: item.imageName)?.imageWithRenderingMode(.AlwaysTemplate)
		cell.imageView!.tintColor = MaterialColor.grey.lighten2
		
		cell.textLabel!.textColor = item.selected ? MaterialColor.cyan.lighten5 : MaterialColor.grey.lighten3
		
		return cell
	}
}

/// UITableViewDelegate methods.
extension RightViewController: UITableViewDelegate {
	/// Sets the tableView cell height.
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 64
	}
	
	/// Select item at row in tableView.
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		print("Cell selected")
	}
}
