# Terraform

# Permissions
The minimum permission is **contributor** to the **subscription** level.

# Managed Identity
- Create a new VM
- Login through SSH and configure the GitHub runner

![image](https://user-images.githubusercontent.com/25728713/165964912-4e2d1382-d287-4c81-b128-a7941bf78ed8.png)

- Configure the VM's identity

![image](https://user-images.githubusercontent.com/25728713/165964171-bdfe9fee-3dbb-4ad9-aaaa-93a60eec2834.png)

- Assign the role of contributor to the subscription

![image](https://user-images.githubusercontent.com/25728713/165971121-b6939c4a-7801-4033-8876-2881b73b2023.png)

- Install terraform on the runner

https://www.terraform.io/cli/install/apt?msclkid=c2a0ff64c7c911ec940711c6969be54c

- Install zip

```
sudo apt install zip
```
