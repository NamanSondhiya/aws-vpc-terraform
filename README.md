# AWS VPC Infrastructure with Terraform

## 🚀 Terraform Skills Showcase

This project demonstrates advanced Terraform skills for AWS infrastructure provisioning, featuring a production-ready VPC setup optimized for the AWS Free Tier.

### 🏗️ Architecture Overview

- **Multi-AZ VPC** with public and private subnets across 2 availability zones
- **Internet Gateway** for public subnet connectivity
- **Route Tables** with proper associations for network segmentation
- **Security Groups** with SSH access configuration
- **EC2 SSH Ready** - Pre-configured for immediate EC2 instance deployment
- **Free Tier Optimized** - $0 monthly cost

### 📊 Architecture Diagram

```
                    ┌─────────────────────────────────────┐
                    │             Internet                │
                    └─────────────────┬───────────────────┘
                                      │
                    ┌─────────────────┴───────────────────┐
                    │         Internet Gateway            │
                    │           (my-vpc-igw)              │
                    └─────────────────┬───────────────────┘
                                      │
        ┌─────────────────────────────┼────────────────────────────┐
        │                    VPC (11.0.0.0/16)                     │
        │                                                          │
        │  ┌─────────────────┐                 ┌─────────────────┐ │
        │  │  Public Route   │                 │ Private Route   │ │
        │  │     Table       │                 │     Table       │ │
        │  │   (public_rt)   │                 │  (private_rt)   │ │
        │  └─────────┬───────┘                 └─────────────────┘ │
        │            │                                             │
        │  ┌─────────┴───────┐                 ┌─────────────────┐ │
        │  │ Public Subnet   │                 │ Private Subnet  │ │
        │  │ 1A (ap-south-1a)│                 │ 1A (ap-south-1a)│ │
        │  │ 11.0.1.0/24     │                 │ 11.0.3.0/24     │ │
        │  └─────────────────┘                 └─────────────────┘ │
        │                                                          │
        │  ┌─────────────────┐                 ┌─────────────────┐ │
        │  │ Public Subnet   │                 │ Private Subnet  │ │
        │  │ 1B (ap-south-1b)│                 │ 1B (ap-south-1b)│ │
        │  │ 11.0.2.0/24     │                 │ 11.0.4.0/24     │ │
        │  └─────────────────┘                 └─────────────────┘ │
        │                                                          │
        │  ┌─────────────────────────────────────────────────────┐ │
        │  │              Security Group                         │ │
        │  │            SSH (Port 22) Access                     │ │
        │  │              (my-vpc-sg)                            │ │
        │  └─────────────────────────────────────────────────────┘ │
        └──────────────────────────────────────────────────────────┘
```

### 📋 Infrastructure Components

| Resource | Count | Purpose |
|----------|-------|---------|
| VPC | 1 | Main network container (11.0.0.0/16) |
| Public Subnets | 2 | Internet-accessible resources |
| Private Subnets | 2 | Isolated internal resources |
| Internet Gateway | 1 | Public internet access |
| Route Tables | 2 | Network traffic routing |
| Security Group | 1 | SSH access control |

### 🛠️ Prerequisites

- AWS Account with Free Tier access
- Terraform >= 1.0
- AWS CLI configured or access keys

### ⚡ Quick Setup

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd terraform/vpc
   ```

2. **Configure AWS credentials**
   ```bash
   cp variables_example.tf variables.tf
   # Edit variables.tf with your AWS credentials
   ```

3. **Deploy infrastructure**
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

### 🔐 Security Configuration

- Sensitive files are excluded via `.gitignore`
- Use `variables_example.tf` as template for your credentials
- Never commit actual AWS keys to version control

### 💰 Cost Optimization

This setup is **100% Free Tier compatible**:
- No NAT Gateway (saves ~$45/month)
- All resources included in AWS Free Tier
- Perfect for learning and development

### 🎯 Terraform Best Practices Demonstrated

- ✅ Resource tagging for organization
- ✅ Variable-driven configuration
- ✅ Proper resource dependencies
- ✅ Multi-AZ high availability
- ✅ Security-first approach
- ✅ Clean, readable code structure

### 🔄 Traffic Flow
- **Public Subnets** → Internet Gateway → Internet
- **Private Subnets** → Isolated (VPC-only communication)
- **Multi-AZ**: Resources distributed across 2 availability zones

### 🔌 Private Subnet Internet Access

**Current Setup**: Private subnets are isolated (no internet access) to maintain free tier compatibility.

**For Production Use**: To enable internet access for private subnets, add a NAT Gateway:
- Private subnets and route table are pre-configured
- Simply attach NAT Gateway to the existing `private_rt` route table
- **Note**: NAT Gateway incurs ~$45/month cost (outside free tier)

### 📊 Network Design

```
VPC (11.0.0.0/16)
├── Public Subnet 1A (11.0.1.0/24)
├── Public Subnet 1B (11.0.2.0/24)
├── Private Subnet 1A (11.0.3.0/24)
└── Private Subnet 1B (11.0.4.0/24)
```

### 🚀 EC2 Ready Configuration

**SSH Access**: Security group pre-configured with SSH (port 22) access for immediate EC2 deployment
- Launch EC2 instances in public subnets for internet-accessible servers
- Deploy in private subnets for secure, isolated applications
- Attach `my-vpc-sg` security group to your instances for SSH connectivity

### 🧹 Cleanup

```bash
terraform destroy
```

---

**Skills Demonstrated**: VPC design, subnet segmentation, routing, security groups, cost optimization, and infrastructure-as-code best practices.

*This project showcases infrastructure-as-code expertise using Terraform for AWS cloud provisioning.*