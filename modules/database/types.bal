import ballerina/sql;

type DatabaseConfig record {|
    string user;
    string password;
    string database;
    string host;
    int port;
|};

public type Book record {|

    @sql:Column {name: "id"}
    readonly int id;

    @sql:Column {name: "title"}
    string title;

    @sql:Column {name: "author"}
    string author;

    @sql:Column {name: "published_year"}
    string publishedYear;

    @sql:Column {name: "genre"}
    string? genre;

    @sql:Column {name: "price"}
    decimal price;

    @sql:Column {name: "quantity"}
    int quantity;
|};

public type BookCreate record {|
    string title;
    string author;
    string publishedYear;
    string genre;
    decimal price;
    int quantity;
|};

public type BookUpdate record {|
    string? title = ();
    string? author = ();
    string? publishedYear = ();
    string? genre = ();
    decimal? price = ();
    int? quantity = ();
|};
