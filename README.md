# MongoDB Exercise
The exercise of this is to put together a bunch of tutorials on setting up Mongo to use locally, in the cloud and in Docker so that I can TDD an API solution in another branch.

## Environment

The point of this exercise is to have MongoDB ready to play with and create and delete database records. So make sure you have docker setup. There is a *docker*-*compose* file in the root ready to start, or if you are on a. mac, there is a Makefile in the root for you easilly get the image generated using:

```makefile
mdb-up:
	echo "Starting Mongo ..."
	docker compose -f docker-compose.yml up

mdb-up-detached:
	echo "Starting Mongo ..."
	docker compose -f docker-compose.yml up

mdb-down:
	echo "Stopping Mongo ..."
	docker compose -f docker-compose.yml up -d

mdb-verify:
	echo "Verify Docker script ..."
	docker compose -f docker-compose.yml config
```

Feel free to alter the script to experiment with whatever you need.

## Tutorials and exercises

- Start up mongo

- Navigate to http://localhost:8081/

  ![image-20211224182529583](./mongo-express.png)

- Use the interface to create a database manually and experiment utilising the basic UI for fun

- **GUI client's** for connecting to Mongo (MongoExpress, DataGrip, MongoDB and Compass)

- Mongo Shell is not graphical and can be used through command line

  ```powershell
  mongo mongodb://localhost:27017 -u rootuser -p rootpass
  ```

  - **NOTE**: If this does not work on the docker image install locally using https://www.mongodb.com/docs/mongodb-shell/install/

    ```bash
    # MacOS
    brew install mongosh
    ```

- Connect to the docker cli for mongdb or do it through the terminal direct if you are familiar with docker

  ![image-20211225114207850](./docker-desktop.png)

- Execute the **Mongo Shell** command from above and once connected execute `show dbs;` to get a list of the databases

  ![image-20211225114550673](./mongoshell.png)

- Create a database on Mongo Express using the UI, and than type `use <database>;` to connect to the database and `db.getName();`  make sure you are connected to the database by name

- **Create a collection**`db.createCollection("<collectionSingular>");` and then `show collections;`

- **Deleting the collection** `db.player.drop();`

- Finally getting the **stats** on the collection `db.player.stats();` can give you everything about the details if that collection, as well as help on methods

- **Deleting the database** can be done with `db.dropDatabase();`

- **Help** on all other commands `db.help();` will give you every command you need

  ![image-20211226102337319](./mongo-help.png)

- **Find** is potentially made up the collection, a query, projection of not all fields

  `db.player.find({name: {$eq: "Killa"}}, { name: 1})`

  - Find **everyone**  `db.player.find({})`

  ![image-20211226123252758](./mongo-find.png)

  - **Cursor modifiers** are ways of filtering the data returned one more step like *limit* e.g. `db.find(...).limit(5)` to return 5 records only

- **Update** follows the same patterns as all except it contains a *$set* for the values you want to update e.g. 

  ```shell
  # Example of incrementing specific players battle count, losses and totalWinnings
  db.player.update({_id: ObjectId("61c85ee6825383f6c0897182"), {$set: {$inc: {battles:1} , $inc: {losses: 0}, $inc: {totalWinnings: 350}}})
  ```

  - **$unset** to remove field which can be useful if there is a need to remove an unecessary field

    ```shell
    # Example of deleting the bountyValue field
    db.player.update({{_id: ObjectId("61c85ee6825383f6c0897182"), {$unset: {bountyValue: 1}}}})
    # or update bounty Value for all players
    db.player.updateMany({}, {$unset: {bountyValue: 1}})
    ```

- Here is a very good [cheat sheet](https://www.mongodb.com/developer/quickstart/cheat-sheet/) to keep handy when trying some other Mongo commands

  ![image-20211226104557042](./mongo-version.png)

  ## Connecting with Compass or vscode

- Install Mongo as a [vscode extension](https://docs.mongodb.com/mongodb-vscode/)

- With default settings, connect to the database using `mongodb://rootuser:rootpass@localhost:27017/<database>`

  ![image-20211227141316539](./compass.png)

  ## Basics

- [Cap Theorem](https://www.bmc.com/blogs/cap-theorem/#:~:text=The%20CAP%20theorem%20is%20a,or%20availability%E2%80%94but%20not%20both.) knowledge and why to use NoSQL and what to do to configure it

  - [Scaling mongo](https://learn.fmi.uni-sofia.bg/file.php/331/lab_practice_exercises/MongoDB_18April/Scaling_MongoDB.pdf) in detail, and is one of the most important reasons to choose NOSQL over relational databases. If you understand this, the principle of distributed computing, you will understand why you chose one over another

- Mongo stores records as **BSON documents**, which is a binary representation of JSON

- **BSON Types** (with deprecated types removed)

  | Type               | Number | Alias        | Notes               |
  | :----------------- | :----- | :----------- | :------------------ |
  | Double             | 1      | "double"     |                     |
  | String             | 2      | "string"     |                     |
  | Object             | 3      | "object"     |                     |
  | Array              | 4      | "array"      |                     |
  | Binary data        | 5      | "binData"    |                     |
  | ObjectId           | 7      | "objectId"   |                     |
  | Boolean            | 8      | "bool"       |                     |
  | Date               | 9      | "date"       |                     |
  | Null               | 10     | "null"       |                     |
  | Regular Expression | 11     | "regex"      |                     |
  | JavaScript         | 13     | "javascript" |                     |
  | 32-bit integer     | 16     | "int"        |                     |
  | Timestamp          | 17     | "timestamp"  |                     |
  | 64-bit integer     | 18     | "long"       |                     |
  | Decimal128         | 19     | "decimal"    | New in version 3.4. |
  | Min key            | -1     | "minKey"     |                     |
  | Max key            | 127    | "maxKey"     |                     |

- If you are familiar with SQL server, these are the NOSQL Mongo specific comparisons found at https://docs.mongodb.com/manual/reference/sql-comparison/

- Here is a comprehensive [cheat sheet](https://www.mongodb.com/developer/products/mongodb/cheat-sheet/) for going through the basics

## Recommended Tutorials

- [MongoDB beginner tutorial](https://www.youtube.com/watch?v=Www6cTUymCY) will give you the basics for everything above going through everything in more detail
- https://www.mongodb.com/try/download/compass for understanding how you can connect to Mongo without using express

### Node

- https://www.mongodb.com/blog/post/quick-start-nodejs-mongodb-how-to-get-connected-to-your-database
- [Setup Node with Mongo on Pluralsight](https://app.pluralsight.com/projects/using-mongodb-with-node-js/setup/46c7e2d3-8413-4a58-9515-e8e3976f66f6)


## Python

- https://www.mongodb.com/compatibility/mongodb-and-django

## Presentation

![Presentation](./Presentation/presentation.png)
