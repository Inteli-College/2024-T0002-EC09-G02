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

resource "aws_glue_catalog_table" "north_table" {
  name          = "north_table"
  database_name = aws_glue_catalog_database.db_north.name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    "classification"  = "json"
    "compressionType" = "none"
  }

  storage_descriptor {
    location      = "s3://${var.bucket_state}/northData/AWSDynamoDB/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
      parameters = {
        "field.delim" = ","
      }
    }
  }
}

resource "aws_glue_catalog_table" "west_table" {
  name          = "west_table"
  database_name = aws_glue_catalog_database.db_west.name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    "classification"  = "json"
    "compressionType" = "none"
  }

  storage_descriptor {
    location      = "s3://${var.bucket_state}/westData/AWSDynamoDB/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
      parameters = {
        "field.delim" = ","
      }
    }
  }
}

resource "aws_glue_catalog_table" "east_table" {
  name          = "east_table"
  database_name = aws_glue_catalog_database.db_east.name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    "classification"  = "json"
    "compressionType" = "none"
  }

  storage_descriptor {
    location      = "s3://${var.bucket_state}/eastData/AWSDynamoDB/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
      parameters = {
        "field.delim" = ","
      }
    }
  }
}

resource "aws_glue_catalog_table" "south_table" {
  name          = "south_table"
  database_name = aws_glue_catalog_database.db_south.name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    "classification"  = "json"
    "compressionType" = "none"
  }

  storage_descriptor {
    location      = "s3://${var.bucket_state}/southData/AWSDynamoDB/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
      parameters = {
        "field.delim" = ","
      }
    }
  }
}

resource "aws_glue_catalog_table" "center_table" {
  name          = "center_table"
  database_name = aws_glue_catalog_database.db_center.name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    "classification"  = "json"
    "compressionType" = "none"
  }

  storage_descriptor {
    location      = "s3://${var.bucket_state}/centerData/AWSDynamoDB/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
      parameters = {
        "field.delim" = ","
      }
    }
  }
}

resource "aws_glue_crawler" "north_crawler" {
  name          = "northCrawler"
  role          = var.lab_role
  database_name = aws_glue_catalog_database.db_north.name

  s3_target {
    path = "s3://${var.bucket_state}/northData/AWSDynamoDB/"
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  schedule = "cron(0 * * * ? *)"
}

resource "aws_glue_crawler" "west_crawler" {
  name          = "westCrawler"
  role          = var.lab_role
  database_name = aws_glue_catalog_database.db_west.name

  s3_target {
    path = "s3://${var.bucket_state}/westData/AWSDynamoDB/"
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  schedule = "cron(0 * * * ? *)"
}

resource "aws_glue_crawler" "east_crawler" {
  name          = "eastCrawler"
  role          = var.lab_role
  database_name = aws_glue_catalog_database.db_east.name

  s3_target {
    path = "s3://${var.bucket_state}/eastData/AWSDynamoDB/"
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  schedule = "cron(0 * * * ? *)"
}

resource "aws_glue_crawler" "south_crawler" {
  name          = "southCrawler"
  role          = var.lab_role
  database_name = aws_glue_catalog_database.db_south.name

  s3_target {
    path = "s3://${var.bucket_state}/southData/AWSDynamoDB/"
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  schedule = "cron(0 * * * ? *)"
}

resource "aws_glue_crawler" "center_crawler" {
  name          = "centerCrawler"
  role          = var.lab_role
  database_name = aws_glue_catalog_database.db_center.name

  s3_target {
    path = "s3://${var.bucket_state}/centerData/AWSDynamoDB/"
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  schedule = "cron(0 * * * ? *)"
}