# # IAM Role to be granted ECR permissions
# data "aws_iam_role" "eks_ecr" {
#   name = "eks_ecr"
# }

# module "eks_ecr" {
#   source = "eks_ecr/aws"
#   # version     = "x.x.x"
#   namespace              = "eg"
#   stage                  = "test"
#   name                   = "ecr"
#   principals_full_access = [data.aws_iam_role.ecr.arn]
# }