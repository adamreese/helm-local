PLUGIN_NAME :=  helm-local
HELM_HOME   ?= $(helm home)
HELM_HOME   := ${HOME}/.helm

.PHONY: install
install:
	cp -a . $(HELM_HOME)/plugins/$(PLUGIN_NAME)

.PHONY: link
link:
	ln -s ${PWD} $(HELM_HOME)/plugins/$(PLUGIN_NAME)

.PHONY: unlink
unlink:
	unlink $(HELM_HOME)/plugins/$(PLUGIN_NAME)
