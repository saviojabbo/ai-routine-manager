import SwiftUI

struct TodoItem: Identifiable {
    let id = UUID()
    var text: String
}

struct ContentView: View {
    @State private var todos: [TodoItem] = []
    @State private var newTodoText = ""
    @State private var showingAddTodo = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(todos) { todo in
                        Text(todo.text)
                    }
                    .onDelete(perform: deleteTodos)
                }
                
                Spacer()
            }
            .navigationTitle("Daily Routine")
            .navigationBarItems(trailing:
                Button(action: { showingAddTodo = true }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddTodo) {
                VStack {
                    TextField("Enter todo item", text: $newTodoText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button("Add") {
                        if !newTodoText.isEmpty {
                            todos.append(TodoItem(text: newTodoText))
                            newTodoText = ""
                            showingAddTodo = false
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    func deleteTodos(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 14")
        
        ContentView()
            .previewDevice("iPhone 14 Pro Max")
            .preferredColorScheme(.dark)
    }
}