import ballerina/sql;

type DatabaseConfig record {|
    # User of the database
    string user;
    # Password of the database
    string password;
    # Name of the database
    string database;
    # Host of the database
    string host;
    # Port
    int port;
|};

public type Book record {|
    # Book ID
    @sql:Column {name: "id"}
    readonly int id;

    # Book title
    @sql:Column {name: "title"}
    string title;

    # Book author
    @sql:Column {name: "author"}
    string author;

    # Book published year
    @sql:Column {name: "published_year"}
    string publishedYear; 

    # Book genre
    # FIX 1: Make this optional (string?) because SQL allows NULL here.
    @sql:Column {name: "genre"}
    string? genre; 

    # Book price
    # FIX 2: Change string -> decimal to match SQL DECIMAL(10,2)
    @sql:Column {name: "price"}
    decimal price; 

    # Book quantity
    # FIX 3: Change string -> int to match SQL INT
    @sql:Column {name: "quantity"}
    int quantity; 
|};

# Book create record type.
public type BookCreate record {|
    # Book title
    string title;
    # Book author
    string author;
    # Book published year
    string publishedYear;
    # Book genre
    string genre;
    # Book price
    decimal price;
    # Book quantity
    int quantity;
|};

# Book update record type.
public type BookUpdate record {|
    # Book title
    string? title = ();
    # Book author
    string? author = ();
    # Book published year
    string? publishedYear = ();
    # Book genre
    string? genre = ();
    # Book price
    decimal? price = ();
    # Book quantity
    int? quantity = ();
|};
