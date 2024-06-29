import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Array "mo:base/Array";

actor StudentCRUD {
  type Student = {
    id: Text;
    firstName: Text;
    lastName: Text;
    age: Nat;
    activo: Bool;
  };

  var students : [Student] = [];

   private func generateUniqueId(): Text {
    let uniqueId = Nat.toText(Array.size(students) + 1);
    return uniqueId;  
  };

  public func addStudent(firstName: Text, lastName: Text, age: Nat, activo: Bool): async Bool {
    let newStudent: Student = {
      id = generateUniqueId(); 
      firstName = firstName;
      lastName = lastName;
      age = age;
      activo = activo;
    };
    students := Array.append(students, [newStudent]);
    return true;
  };

  public func getAllStudents(): async [Student] {
    return students;
  };

  public func deleteStudent(id: Text): async Bool {
    let initialLength = Array.size(students);
    students := Array.filter<Student>(students, func (student: Student) : Bool {
      student.id != id
    });
    return Array.size(students) < initialLength;
  };
}