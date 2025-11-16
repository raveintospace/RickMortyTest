//
//  LocationView.swift
//  RickMorty
//
//  Created by Uri on 16/11/25.
//

import SwiftUI

struct LocationView: View {
    
    @State private var locationViewModel: LocationViewModel
    
    let locationURL: URL
    
    init(locationURL: URL) {
        _locationViewModel = State(initialValue: LocationViewModel(locationURL: locationURL, fetchLocationUseCase: FetchLocationUseCaseImpl(dataSource: LocationDataSourceImpl(dataService: DataService()))))
        
        self.locationURL = locationURL
    }
    
    var body: some View {
        NavigationStack {
            if locationViewModel.isLoading && locationViewModel.location == nil {
                ProgressColorBarsView()
            } else if let error = locationViewModel.errorMessage {
                Text(error)
                    .font(.title3)
                    .foregroundStyle(.rmLime)
                    .padding()
            } else if let location = locationViewModel.location {
                VStack {
                    Text(location.name.capitalized)
                    Text(location.dimension.capitalized)
                    Text(location.type.capitalized)
                    Text("\(location.residentCount) residents")
                }
            }
        }
        .task {
            await locationViewModel.loadLocation()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        LocationView(locationURL: (DetailCharacter.Stub.stub1.origin?.url)!)
    }
}
#endif
