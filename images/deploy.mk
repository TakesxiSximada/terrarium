PROFILE := .profile
BASE_ISO_URL := http://releases.ubuntu.com/16.04.1/ubuntu-16.04.1-server-amd64.iso
ISO_CHECKSUM := de5ee8665048f009577763efbf4a6f0558833e59
ISO_CHECKSUM_TYPE := sha1

ISO_DIR := .iso
ISO_NAME := ubuntu-16.04.1-server-amd64.iso
ISO_PATH := $(ISO_DIR)/$(ISO_NAME)

.PHONY: build
build: $(ISO_PATH)
	source $(PROFILE) && packer build -force -var-file=gatekeeper.json \
		-var="iso_path=$(ISO_PATH)" \
		-var="iso_checksum_type=$(ISO_CHECKSUM_TYPE)" \
		-var="iso_checksum=$(ISO_CHECKSUM)" \
		-var="ssh_username=$$SSH_USERNAME" \
		-var="ssh_password=$$SSH_PASSWORD" \
		ubuntu.json

$(ISO_PATH):
	mkdir -p $(ISO_DIR)
	curl -L $(BASE_ISO_URL) -o $(ISO_PATH)
