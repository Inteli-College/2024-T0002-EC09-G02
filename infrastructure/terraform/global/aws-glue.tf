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

  schedule = "cron(*/60 * * * ? *)"
}

resource "aws_glue_crawler" "west_crawler" {
  name          = "westCrawler"
  role          = var.lab_role
  database_name = aws_glue_catalog_database.db_west.name

  s3_target {
    path = "s3://${aws_s3_bucket.data_storage.bucket}/"
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  schedule = "cron(*/60 * * * ? *)"
}

resource "aws_glue_crawler" "east_crawler" {
  name          = "eastCrawler"
  role          = var.lab_role
  database_name = aws_glue_catalog_database.db_east.name

  s3_target {
    path = "s3://${aws_s3_bucket.data_storage.bucket}/"
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  schedule = "cron(*/60 * * * ? *)"
}

resource "aws_glue_crawler" "south_crawler" {
  name          = "southCrawler"
  role          = var.lab_role
  database_name = aws_glue_catalog_database.db_south.name

  s3_target {
    path = "s3://${aws_s3_bucket.data_storage.bucket}/"
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  schedule = "cron(*/60 * * * ? *)"
}

resource "aws_glue_crawler" "center_crawler" {
  name          = "centerCrawler"
  role          = var.lab_role
  database_name = aws_glue_catalog_database.db_center.name

  s3_target {
    path = "s3://${aws_s3_bucket.data_storage.bucket}/"
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  schedule = "cron(*/60 * * * ? *)"
}