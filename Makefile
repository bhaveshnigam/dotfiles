RM = rm -rf

.PHONY: all push help

all:

help:
	@echo "Possible targets:"
	@echo "    help        - Displays this screen."
	@echo "    push        - 'git push' to all hosted repositories"

push: push-google push-github

push-google:
	@echo "Pushing repository to remote:google [code.google.com]"
	@git push google master

push-github:
	@echo "Pushing repository to remote:origin [github.com]"
	@git push origin master
