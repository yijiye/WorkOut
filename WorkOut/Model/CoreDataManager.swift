//
//  CoreDataManager.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/07/12.
//

import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() { }
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.newBackgroundContext()
    
    func create(_ workout: TodayWorkout) {
        guard let context,
              let entity = NSEntityDescription.entity(forEntityName: "WorkoutEntity", in: context),
              let storage = NSManagedObject(entity: entity, insertInto: context) as? WorkoutEntity else { return }
        
        setValue(at: storage, data: workout)
        save()
    }
    
    func read(by id: UUID) -> WorkoutEntity? {
        guard let context else { return nil }
        let request = NSFetchRequest<NSManagedObject>(entityName: "WorkoutEntity")
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let data = try context.fetch(request)
            return data.first as? WorkoutEntity
        } catch {
            return nil
        }
    }
    
    func readLast() -> WorkoutEntity? {
        guard let context else { return nil }
        
        do {
            let data = try context.fetch(WorkoutEntity.fetchRequest())
            return data.last
        } catch {
            return nil
        }
    }
    
    func readAll() -> [WorkoutEntity]? {
        guard let context else { return nil }
        
        do {
            let data = try context.fetch(WorkoutEntity.fetchRequest())
            return data
        } catch {
            return nil
        }
    }
    
    func update(from id: UUID, to workout: TodayWorkout) {
        guard let currentWorkout = read(by: id) else { return }
        
        setValue(at: currentWorkout, data: workout)
        save()
    }
    
    func delete(by id: UUID) {
        guard let context else { return }
        let request: NSFetchRequest<NSFetchRequestResult> = WorkoutEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(delete)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAll() {
        guard let context = self.context else { return }
        
        let request: NSFetchRequest<NSFetchRequestResult> = WorkoutEntity.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(delete)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setValue(at target: WorkoutEntity, data: TodayWorkout) {
        target.setValue(data.id, forKey: "id")
        target.setValue(data.satisfaction, forKey: "satisfaction")
        target.setValue(data.memo, forKey: "memo")
    }
    
    private func save() {
        guard let context else { return }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
