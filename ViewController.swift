//
//  ViewController.swift
//  Consolidation6
//
//  Created by Venkata on 2/12/24.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()
    var cities = [City]()
    var currencies = [CurrencyCode]()
    var populations = [Population]()
    var areas = [Area]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries"
        // Do any additional setup after loading the view.
        let urlCountries = URL(string: "https://raw.githubusercontent.com/samayo/country-json/master/src/country-by-name.json")!
        let urlCapitals = URL(string: "https://raw.githubusercontent.com/samayo/country-json/master/src/country-by-capital-city.json")!
        let urlCurrency = URL(string: "https://raw.githubusercontent.com/samayo/country-json/master/src/country-by-currency-code.json")!
        let urlPopulation = URL(string: "https://raw.githubusercontent.com/samayo/country-json/master/src/country-by-population.json")!
        let urlArea = URL(string: "https://raw.githubusercontent.com/samayo/country-json/master/src/country-by-surface-area.json")!
        
        fetchData(from: urlCountries, model: [Country].self) { [weak self] result in
            switch result {
            case .success(let countries):
                self?.countries = countries
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch countries: \(error)")
            }
        }
        
        fetchData(from: urlCapitals, model: [City].self) { [weak self] result in
            switch result {
            case .success(let cities):
                self?.cities = cities
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch capitals: \(error)")
            }
        }
        
        fetchData(from: urlCurrency, model: [CurrencyCode].self) { [weak self] result in
            switch result {
            case .success(let currencies):
                self?.currencies = currencies
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch currencies: \(error)")
            }
        }
        
        fetchData(from: urlPopulation, model: [Population].self) { [weak self] result in
            switch result {
            case .success(let populations):
                self?.populations = populations
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch populations: \(error)")
            }
        }
        
        fetchData(from: urlArea, model: [Area].self) { [weak self] result in
            switch result {
            case .success(let areas):
                self?.areas = areas
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch areas: \(error)")
            }
        }
    }
    
    // Generic data fetching function
    func fetchData<T: Decodable>(from url: URL, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Unknown Error", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].country
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities.first { $0.country == countries[indexPath.row].country }?.city ?? "No Capital"
        let currency = currencies.first { $0.country == countries[indexPath.row].country }?.currency_code ?? "No Currency"
        let population = populations.first { $0.country == countries[indexPath.row].country }?.population ?? 0
        let area = areas.first { $0.country == countries[indexPath.row].country }?.area ?? 0.0
        let countryCapitalArray = ["Country: " + countries[indexPath.row].country, "Capital City: " + city, "Currency: " + currency, "Population: \(population)", "Area: \(area)"]
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.countryCapital = countryCapitalArray
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

