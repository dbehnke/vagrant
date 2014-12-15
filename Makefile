BOXCUTTER_OUTPUTPREFIX=box/virtualbox

BOXES=ol5_64 ol5_32 ol6_64 ol6_32 ol7_64 \
  ubuntu1410_64 ubuntu1410_32 ubuntu1404_64 ubuntu1404_32 \
  ubuntu1204_64 ubuntu1204_32 \
  fedora21_64 fedora21_32 fedora20_64 fedora20_32 \
  debian7_64 debian7_32

#Oracle Linux
ol5_64_repo=oel-vm
ol5_64_template=oel511.json
ol5_64_boxname=ol511-64
ol5_64_output=oel511-nocm-0.1.0.box

ol5_32_repo=oel-vm
ol5_32_template=oel511-i386.json
ol5_32_boxname=ol511-32
ol5_32_output=oel511-i386-nocm-0.1.0.box

ol6_64_repo=oel-vm
ol6_64_template=oel66.json
ol6_64_boxname=ol66-64
ol6_64_output=oel66-nocm-0.1.0.box

ol6_32_repo=oel-vm
ol6_32_template=oel66-i386.json
ol6_32_boxname=ol66-32
ol6_32_output=oel66-i386-nocm-0.1.0.box

ol7_64_repo=oel-vm
ol7_64_template=oel70.json
ol7_64_boxname=ol70-64
ol7_64_output=oel70-nocm-0.1.0.box

ubuntu1410_64_repo=ubuntu-vm
ubuntu1410_64_template=ubuntu1410.json
ubuntu1410_64_boxname=ubuntu1410-64
ubuntu1410_64_output=ubuntu1410-nocm-0.1.0.box

ubuntu1410_32_repo=ubuntu-vm
ubuntu1410_32_template=ubuntu1410-i386.json
ubuntu1410_32_boxname=ubuntu1410-32
ubuntu1410_32_output=ubuntu1410-i386-nocm-0.1.0.box

ubuntu1404_64_repo=ubuntu-vm
ubuntu1404_64_template=ubuntu1410.json
ubuntu1404_64_boxname=ubuntu1410-64
ubuntu1404_64_output=ubuntu1410-nocm-0.1.0.box

ubuntu1404_32_repo=ubuntu-vm
ubuntu1404_32_template=ubuntu1404-i386.json
ubuntu1404_32_boxname=ubuntu1404-32
ubuntu1404_32_output=ubuntu1404-i386-nocm-0.1.0.box

ubuntu1204_64_repo=ubuntu-vm
ubuntu1204_64_template=ubuntu1204.json
ubuntu1204_64_boxname=ubuntu1204-64
ubuntu1204_64_output=ubuntu1204-nocm-0.1.0.box

ubuntu1204_32_repo=ubuntu-vm
ubuntu1204_32_template=ubuntu1204-i386.json
ubuntu1204_32_boxname=ubuntu1204-32
ubuntu1204_32_output=ubuntu1204-i386-nocm-0.1.0.box

fedora21_64_repo=fedora-vm
fedora21_64_template=fedora21.json
fedora21_64_boxname=fedora21-64
fedora21_64_output=fedora21-nocm-0.1.0.box

fedora21_32_repo=fedora-vm
fedora21_32_template=fedora21-i386.json
fedora21_32_boxname=fedora21-32
fedora21_32_output=fedora21-i386-nocm-0.1.0.box

fedora20_64_repo=fedora-vm
fedora20_64_template=fedora20.json
fedora20_64_boxname=fedora20-64
fedora20_64_output=fedora20-nocm-0.1.0.box

fedora20_32_repo=fedora-vm
fedora20_32_template=fedora20-i386.json
fedora20_32_boxname=fedora20-32
fedora20_32_output=fedora20-i386-nocm-0.1.0.box

debian7_64_repo=debian-vm
debian7_64_template=debian77.json
debian7_64_boxname=debian7-64
debian7_64_output=debian77-nocm-0.1.0.box

debian7_32_repo=debian-vm
debian7_32_template=debian77-i386.json
debian7_32_boxname=debian7-32
debian7_32_output=debian77-i386-nocm-0.1.0.box


#BOXCUTTER-OL5_32=oel511-i386.json

.PHONY: all Makefile
all: vagrant packer $(BOXES)

.PHONY: vagrant
vagrant:
	@echo "Checking for vagrant in PATH"
	@which -s vagrant
	@echo "OK"

.PHONY: packer
packer:
	@echo "Checking for packer in PATH"
	@which -s packer
	@echo "OK"

%: vagrant packer
	@echo boxname=$($@_boxname)
	@echo repo=$($@_repo)
	@echo output=$($@_output)
	@echo template=$($@_template)
	vagrant box list | grep $($@_boxname); \
	if [ $$? -gt 0 ]; then \
	  cd box-cutter/$($@_repo); \
	  if [ ! -e "$(BOXCUTTER_OUTPUTPREFIX)/$($@_output)" ]; then \
	    packer build -only=virtualbox-iso $($@_template); \
	  fi; \
	  -vagrant box rm $($@_boxname); \
	  vagrant box add $($@_boxname) $(BOXCUTTER_OUTPUTPREFIX)/$($@_output); \
	fi

.PHONY: clean
clean:
	@echo "TODO"