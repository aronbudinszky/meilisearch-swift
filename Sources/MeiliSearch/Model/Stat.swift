import Foundation

/**
 `AllStats` instances represent stat of all Indexes.
 */
public struct AllStats: Codable, Equatable {

    // MARK: Properties

    /// Size of the whole database, in bytes.
    public let databaseSize: Int

    /// Date when the server was last updated.
    public let lastUpdate: Date?

    /// Dictionary of all Indexes containing the stat for each Index.  
    public let indexes: [String: Stat]

    enum CodingKeys: String, CodingKey {
        case databaseSize
        case lastUpdate
        case indexes
    }

}

/**
 `AllStats` instances represent stat of a specific Index.
 */
public struct Stat: Codable, Equatable {

    // MARK: Properties

    /// Number of documents in the given index.
    public let numberOfDocuments: Int

    /// Returns if the Index is currenly being indexed.
    public let isIndexing: Bool

    /// Usage frequency for each Index field.
    public let fieldsFrequency: [String: Int]

    enum CodingKeys: String, CodingKey {
        case numberOfDocuments
        case isIndexing
        case fieldsFrequency
    }

}
