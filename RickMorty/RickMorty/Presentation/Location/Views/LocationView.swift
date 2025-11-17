//
//  LocationView.swift
//  RickMorty
//
//  Created by Uri on 16/11/25.
//

import SwiftUI

struct LocationView: View {
    
    @Environment(\.isPad) var isPad: Bool
    
    @State private var locationViewModel: LocationViewModel
    
    let locationURL: URL
    let locationTitle: String
    
    init(locationURL: URL, locationTitle: String) {
        _locationViewModel = State(initialValue: LocationViewModel(locationURL: locationURL, fetchLocationUseCase: FetchLocationUseCaseImpl(dataSource: LocationDataSourceImpl(dataService: DataService()))))
        
        self.locationURL = locationURL
        self.locationTitle = locationTitle
    }
    
    var body: some View {
        NavigationStack {
            if locationViewModel.isLoading && locationViewModel.location == nil {
                ProgressColorBarsView()
            } else if let error = locationViewModel.errorMessage {
                RMErrorText(error: error)
            } else if let location = locationViewModel.location {
                VStack(spacing: 20) {
                    sheetHeader
                    
                    VStack(alignment: .leading, spacing: 12) {
                        LocationRow(title: "Name:",
                                    value: location.name.capitalized)
                        LocationRow(title: "Dimension:",
                                    value: location.dimension.capitalized)
                        LocationRow(title: "Type:",
                                    value: location.type.capitalized)
                        LocationRow(title: "Residents:",
                                    value: location.residentCountText)
                    }
                    
                    DismissSheetButton()
                        .padding(.top, 10)
                }
                .modifier(GlassSheetModifier())
                .shadow(color: .rmLime, radius: 3)
                .accessibilityElement(children: .contain)
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
        LocationView(locationURL: (DetailCharacter.Stub.stub1.origin?.url)!,
                     locationTitle: "Origin"
        )
    }
}
#endif

extension LocationView {
    
    private var sheetHeader: some View {
        Text(locationTitle.uppercased())
            .font(isPad ? .largeTitle : .title)
            .fontWeight(.semibold)
            .underline()
            .multilineTextAlignment(.center)
            .accessibilityAddTraits(.isHeader)
    }
}

fileprivate struct LocationRow: View {
    
    @Environment(\.isPad) var isPad: Bool
    
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(isPad ? .title : .title2)
                .fontWeight(.medium)
            Text(value)
                .font(isPad ? .title2: .title3)
                .lineLimit(3)
                .minimumScaleFactor(0.7)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(value)")
    }
}
