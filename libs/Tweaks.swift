// Facebook Tweak Swift utility extensions

import Foundation

extension FBTweakStore {
  func get<T:AnyObject>(category categoryName: String, collection collectionName: String, name: String, defaultValue: T) -> FBTweak {

    // get category
    let category: FBTweakCategory
    if let existingCategory = tweakCategoryWithName(categoryName) {
      category = existingCategory
    } else {
      category = FBTweakCategory(name: categoryName)
      addTweakCategory(category)
    }

    // get collection
    let collection: FBTweakCollection
    if let existingCollection = category.tweakCollectionWithName(collectionName) {
      collection = existingCollection
    } else {
      collection = FBTweakCollection(name: collectionName)
      category.addTweakCollection(collection)
    }

    // get tweak
    let identifier = "\(categoryName).\(collectionName).\(name)".lowercaseString
    let tweak: FBTweak
    if let existingTweak = collection.tweakWithIdentifier(identifier) {
      tweak = existingTweak
    } else {
      tweak = FBTweak(identifier: identifier)
      tweak.name = name
      tweak.defaultValue = defaultValue
      collection.addTweak(tweak)
    }
    return tweak
  }
}

extension FBTweak {
  var value: FBTweakValue {
    get {
      return currentValue ?? defaultValue
    }
  }
}

class Tweaks: NSObject, FBTweakObserver {
  typealias ActionWithValue = ((value: AnyObject) -> ())

  var actionsWithValue = [String:ActionWithValue]()

  func get<T:AnyObject>(#category: String, collection: String, name: String, defaultValue: T) -> T {
    let tweak = FBTweakStore.sharedInstance().get(category: category, collection: collection, name: name, defaultValue: defaultValue)
    return tweak.value as! T
  }

  func get<T:AnyObject>(#category: String, collection: String, name: String, defaultValue: T, action: (T) -> Void) {
    let tweak = FBTweakStore.sharedInstance().get(category: category, collection: collection, name: name, defaultValue: defaultValue)
    let fn: ActionWithValue = { if let val = $0 as? T { action(val) }}
    actionsWithValue[tweak.identifier] = fn
    action(defaultValue)
  }

  func tweakDidChange(tweak: FBTweak!) {
    if let action = actionsWithValue[tweak.identifier] {
      action(value: tweak.currentValue ?? tweak.defaultValue)
    }
  }
}