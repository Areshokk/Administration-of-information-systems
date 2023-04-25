# resource "aws_instance" "my-vm" {
#   ami           = "ami-02396cdd13e9a1257" # бажаний Amazon machine image
#   instance_type = "t2.micro" # бажаний тип машини

#   tags = {
#     Name = "example-instance"
#   }
# }

resource "aws_instance" "my-vm-1" {
  count = 2 # Цей операнд вказує скільки ресурсів буде створено
  ami           = lookup(var.ec2_ami,var.region) 
  instance_type = var.instance_type 
  
  tags = {
    Name = "my-vm-${count.index + 1}" # Оскільки віртуальних машин повинно створити дві, то й теги повинні відрізнятись. В даному випадку, використовуємо звичні арифметичні дії, для ітерації.
  }
}


resource "local_file" "tf_ip" { # Ресурс local_file призначений для взаємодії з локальними файлами
    content = "[ALL]\n${aws_instance.my-vm-1[0].public_ip} ansible_ssh_user=ubuntu" # В контенті ми описуємо що саме ми запишемо у файл. Якщо приглянутися, можна побачити, що структура тексту являється інвентаризацією для інструменту Ansible. Єдине чого не вистачає – це ІР адреси віртуальної машини яку ми знати не можемо, оскільки машини ще не існує. Саме тому дана конструкція ${aws_instance.my-vm[0].public_ip} звернеться до нульового створеного ресурсу aws_instance, вичитає його публічну ІР адресу та дасть змогу її записати.
  	filename = "./inventory" # Шлях до файлу який було створено в минулому кроці.
}
