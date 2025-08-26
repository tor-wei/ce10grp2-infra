resource "aws_ecr_repository" "lingo_api" {
  name                 = "lingo-game-api"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
}

resource "aws_ecr_repository" "lingo_frontend" {
  name                 = "lingo-game-frontend"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
}