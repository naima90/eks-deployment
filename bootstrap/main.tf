resource "aws_s3_bucket" "terraform_state" {
  bucket = "eks-app-state-bucket"

  tags = {
    Name        = "${var.project_name}-S3"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}


# resource "aws_ecr_repository" "app" {
#   name                 = var.project_name
#   image_tag_mutability = "MUTABLE"
#   force_delete         = true

#   tags = {
#     Name = "${var.project_name}-ecr"
#   }
# }