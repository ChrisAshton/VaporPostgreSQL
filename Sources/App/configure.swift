import FluentPostgreSQL
import Vapor
import Leaf

/// Called before your application initializes.
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
    ) throws {
    

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    let myService = NIOServerConfig.default(port: 8003)
    services.register(myService)
    
    // Register the LeafProvider
    try services.register(LeafProvider()) // added
    
    // Register FluentPostgreSQL
    try services.register(FluentPostgreSQLProvider())
    
    // Set LeafRenderer as our preferred ViewRenderer
    config.prefer(LeafRenderer.self, for: ViewRenderer.self) // added
    
    // Configure PostgreSQL server
    
    let postgresqlConfig = PostgreSQLDatabaseConfig(
        hostname: "127.0.0.1",
        port: 5432,
        username: "christopherashton",
        database: "mycooldb",
        password: nil
    )
    
    // register database
    services.register(postgresqlConfig)

    
    // Register migration service to introduce model to database
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .psql) // adding things to migrations...
    services.register(migrations)

}

