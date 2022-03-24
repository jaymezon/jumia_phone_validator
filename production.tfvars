region                      = "ap-south-1"
vpc_name                    = "eks_jumia_phone_validator"
vpc_cidr                    = "10.2.0.0/16"
eks_cluster_name            = "eks_jumia_phone_validator_cluster"
cidr_block_igw              = "0.0.0.0/0"
node_group_name             = "eks_jumia_phone_validator_ng"
ng_instance_types           = [ "t2.micro" ]
disk_size                   = 10
desired_nodes               = 3
max_nodes                   = 3
min_nodes                   = 1
fargate_profile_name        = "eks_jumia_phone_validator_fargate"
kubernetes_namespace        = "jumia_phone_validator_rds"
deployment_name             = "jumia_phone_validator"
deployment_replicas         = 3
rds_subnet_group_name       = "rds-jumia_phone_validator_subnet"
rds_db_name                 = "jumia_phone_validator"
rds_db_identifier           = "postgresql"
rds_storage                 = 20
engine                      = "postgresql"
engine_version              = "9.6"
instance_class              = "db.t2.micro"
rds_parameter_group_name    = "default.postgresql9.6"
app_labels = { 
    "app" = "jumia_phone_validator"
    "tier" = "frontend and backend"
    } 