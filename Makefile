infra:
	git pull
	terraform init
	terraform apply -auto-approve -var ssh_username=venkat -var ssh_password=Devops123456
	# Username and Password should not be hardcoded, Here we just hardcoding because to avoid the passing of input. This needs to be parsed as input in real time

ansible:
	#ansible code is to install hashicorp vault
	git pull
	ansible-playbook -i $(tool_name)-internal.azdevopsv82.online, tool-setup.yml -e ansible_user=venkat -e ansible_password=Devops123456 -e tool_name=$(tool_name) -e vault_token=$(vault_token)
	## Username and Password should not be hardcoded, Here we just hardcoding because to avoid the passing of input. This needs to be parsed as input in real time