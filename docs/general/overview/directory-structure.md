# Directory Structure

## Current Directory Structure

```bash
terraform-modules/
├── docs/                              # documentation directory
│   ├── dev/                           # developer documentation, easy to edit and read
│   │   ├── README.md                  # developer guide
│   │   ├── TODO.md                    # development tasks
│   │   ├── arch.md                    # architecture documentation
│   │   ├── development.md             # development guidelines
│   │   ├── feature.md                 # feature documentation
│   │   ├── prd.md                     # product requirements
│   │   └── prompt-examples.md         # AI prompt examples
│   ├── AI/                            # AI generated documentation
│   │   └── summaries/                 # AI-generated summaries for each coding task (reference only)
│   ├── examples/                      # use cases and examples
│   ├── external/                      # external documentation and references
│   └── general/                       # general documentation for users
│       ├── overview/                  # repository overview
│       │   ├── directory-structure.md # this file - repository structure
│       │   ├── resources.md           # repository resources (log endpoints, etc.)
│       │   └── standards.md           # coding standards, design standards, doc standards
│       └── features/                  # feature documentation
├── examples/                          # Terraform usage examples
│   ├── aws/                           # AWS-specific examples
│   ├── basic/                         # basic usage examples
│   ├── huaweicloud/                   # HuaweiCloud-specific examples
│   ├── multi-cloud/                   # multi-cloud deployment examples
│   └── s3/                            # S3 storage examples
├── templates/                         # Terraform configuration templates
│   ├── terraform.tfvars.example       # example variables file
│   ├── provider.tf.aws.example        # AWS provider configuration
│   ├── provider.tf.huaweicloud.example # HuaweiCloud provider configuration
│   └── README.md                      # template documentation
├── .claude/                           # Claude AI configuration
├── main.tf                            # main Terraform configuration
├── variables.tf                       # Terraform variable definitions
├── outputs.tf                         # Terraform output definitions
└── README.md                          # repository main README
```
