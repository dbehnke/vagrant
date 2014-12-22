BOXCUTTER_OUTPUTPREFIX=box/virtualbox

BOXES=fedora21 fedora21-gui

fedora21_repo=fedora-vm
fedora21_template=fedora21-dbehnke.json
fedora21_boxname=fedora21-64
fedora21_output=fedora21-nocm-0.1.0.box

fedora21-gui_repo=fedora-vm
fedora21-gui_template=fedora21-dbehnke-gui.json
fedora21-gui_boxname=fedora21-gui-64
fedora21-gui_output=fedora21-gui-nocm-0.1.0.box

.PHONY: all Makefile
all: vagrant packer $(BOXES)

.PHONY: vagrant
vagrant:
	@echo "Checking for vagrant in PATH"
	@which vagrant
	@echo "OK"

.PHONY: packer
packer:
	@echo "Checking for packer in PATH"
	@which packer
	@echo "OK"

%: vagrant packer
	@echo boxname=$($@_boxname)
	@echo repo=$($@_repo)
	@echo output=$($@_output)
	@echo template=$($@_template)
	vagrant box list | grep $($@_boxname); \
	if [ $$? -gt 0 ]; then \
	  cd $($@_repo); \
	  if [ ! -e "$(BOXCUTTER_OUTPUTPREFIX)/$($@_output)" ]; then \
	    packer build -only=virtualbox-iso $($@_template); \
	  fi; \
	  -vagrant box rm $($@_boxname); \
	  vagrant box add $($@_boxname) $(BOXCUTTER_OUTPUTPREFIX)/$($@_output); \
	fi

.PHONY: clean
clean:
	@echo "TODO"
