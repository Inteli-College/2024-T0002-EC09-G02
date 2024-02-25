resource "aws_glue_catalog_database" "db_north" {
  name = "db_north"
}

resource "aws_glue_catalog_database" "db_west" {
  name = "db_west"
}

resource "aws_glue_catalog_database" "db_east" {
  name = "db_east"
}

resource "aws_glue_catalog_database" "db_south" {
  name = "db_south"
}

resource "aws_glue_catalog_database" "db_center" {
  name = "db_center"
}

resource "aws_glue_crawler" "north_crawler" {
  name          = "northCrawler"
  role          = var.lab_role
  database_name = aws_glue_catalog_database.db_north.name

  dynamodb_target {
    path = "sensorNorth"
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  schedule = "cron(*/5 * * * ? *)"
}

resource "aws_glue_crawler" "west_crawler" {
  name          = "westCrawler"
  role          = var.lab_role
  database_name = aws_glue_catalog_database.db_west.name

  dynamodb_target {
    path = "sensorWest"
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  schedule = "cron(*/5 * * * ? *)"
}

resource "aws_glue_crawler" "east_crawler" {
  name          = "eastCrawler"
  role          = var.lab_role
  database_name = aws_glue_catalog_database.db_east.name

  dynamodb_target {
    path = "sensorEast"
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  schedule = "cron(*/5 * * * ? *)"
}

resource "aws_glue_crawler" "south_crawler" {
  name          = "southCrawler"
  role          = var.lab_role
  database_name = aws_glue_catalog_database.db_south.name

  dynamodb_target {
    path = "sensorSouth"
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  schedule = "cron(*/5 * * * ? *)"
}

resource "aws_glue_crawler" "center_crawler" {
  name          = "centerCrawler"
  role          = var.lab_role
  database_name = aws_glue_catalog_database.db_center.name

  dynamodb_target {
    path = "sensorCenter"
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  schedule = "cron(*/5 * * * ? *)"
}