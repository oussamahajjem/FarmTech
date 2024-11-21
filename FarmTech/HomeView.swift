import SwiftUI

struct HomeView: View {
    let features: [Feature] = [
        Feature(title: "Weather Forecast", description: "AI-powered local weather predictions", iconName: "cloud.sun.fill", route: "weather"),
        Feature(title: "Crop Health Analysis", description: "Detect diseases and nutrient deficiencies", iconName: "leaf.fill", route: "crop_health"),
        Feature(title: "Smart Irrigation", description: "Optimize your watering schedule", iconName: "drop.fill", route: "irrigation"),
        Feature(title: "Pest Detection", description: "Identify and manage pests effectively", iconName: "ant.fill", route: "pest"),
        Feature(title: "Market Prices", description: "Predict and track agricultural commodity prices", iconName: "chart.line.uptrend.xyaxis", route: "market"),
        Feature(title: "Soil Analysis", description: "Get fertilizer recommendations based on soil health", iconName: "mountain.2.fill", route: "soil")
    ]

    var body: some View {
        NavigationView {
            List(features) { feature in
                NavigationLink(destination: destinationView(for: feature)) {
                    FeatureRow(feature: feature)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("FarmTechAI")
        }
    }

    @ViewBuilder
    func destinationView(for feature: Feature) -> some View {
        switch feature.route {
        case "weather":
            WeatherView()
        default:
            Text("Coming soon: \(feature.title)")
        }
    }
}

struct FeatureRow: View {
    let feature: Feature

    var body: some View {
        HStack {
            Image(systemName: feature.iconName)
                .foregroundColor(.green)
                .font(.system(size: 30))
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(feature.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(feature.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

