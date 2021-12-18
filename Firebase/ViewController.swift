//
//  ViewController.swift
//  Firebase
//
//  Created by Daniel on 18/12/21.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var rows: [RowModel] = []
    var photoCell: PhotoTableViewCell?
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getChart()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func registerCell() {
        let dataCell = UINib(nibName: "DataTableViewCell", bundle: Bundle.main)
        let photoCell = UINib(nibName: "PhotoTableViewCell", bundle: Bundle.main)
        let graphCell = UINib(nibName: "GRaphTableViewCell", bundle: Bundle.main)
        
        tableView.register(dataCell, forCellReuseIdentifier: "DataTableViewCell")
        tableView.register(photoCell, forCellReuseIdentifier: "PhotoTableViewCell")
        tableView.register(graphCell, forCellReuseIdentifier: "GRaphTableViewCell")
    }
    
    func getChart() {
        ApiClient().getChart()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { result in
                debugPrint(result)
            },
            receiveValue: { [self] chart in
                prepareData(data: chart)
            }).store(in: &cancellables)
    }
    
    func prepareData(data: RootChart){
        
        let rowData = RowModel();
        rowData.row = Row.Data
        rows.append(rowData)
        
        let rowPhoto = RowModel();
        rowPhoto.row = Row.Photo
        rows.append(rowPhoto)
        
        for (_,item) in data.questions!.enumerated() {
            let row = RowModel();
            row.row = Row.Graph
            row.colors = data.colors
            row.question = item
            rows.append(row)
            debugPrint(row)
        }
        
        
        tableView.reloadData()
    }
    
}

extension ViewController: CameraDelegate {
    func openCamera() {
        let controller = CustomCameraController()
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
}

extension ViewController: CustomCameraControllerDelegate {
    func sendImage(image: UIImage?) {
        photoCell?.setImage(image: image)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        switch row.row {
        case .Data:
            return  tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell") as! DataTableViewCell
        case .Photo:
            photoCell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell") as? PhotoTableViewCell
            photoCell?.delegateCamera = self
            return  photoCell!
        case .Graph:
            let cellG = tableView.dequeueReusableCell(withIdentifier: "GRaphTableViewCell") as! GRaphTableViewCell
            cellG.setRowModel(rowModel: row)
            return  cellG
        case .none:
            return  tableView.dequeueReusableCell(withIdentifier: "GRaphTableViewCell") as! GRaphTableViewCell
        }
    }
}
