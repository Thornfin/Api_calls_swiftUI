//
//  ContentView.swift
//  Api_calls_swiftUI
//
//  Created by ilyass Serghini on 2024-04-29.
//

import SwiftUI

struct ContentView: View {
    @State private var user: GitHubUser?
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { Image in
                Image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
                    
            }
            .frame(width: 120, height: 120)
            
            Text(user?.login ?? "Username")
                .bold()
                .font(.title3)
            
            Text(user?.bio ?? "This is where the github bio will go")
                .padding()
            
            Spacer()
        }
        .padding()
        .task {
            do {
                user = try await getUser()
                
            }catch GHError.invalidURL {
                print("invalid URL")
            } catch GHError.invalidResponse {
                print("invalid response")
            } catch GHError.invalidData {
                print("invalid Data")
            } catch {
                print("unexpected error...")
            }
        }
    }
}

#Preview {
    ContentView()
}


