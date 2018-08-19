.PHONY: $(shell find * -type d -depth 0)

PREFIX = onedata-makefile-test-release

all: stress-nfs stress-job stress-suite

stress-nfs: build-stress-nfs
stress-job: build-stress-job
stress-suite: build-stress-suite

build-%:
	if [ -f $*/requirements.yaml ]; then helm dependency update --skip-refresh $*; fi
	helm package $*

install-%:
	if [ -f $*/requirements.yaml ]; then helm dependency update $*; fi
	helm install $*

test-%: build-onedata-chart-utils
	helm dependency build $*
	helm lint --strict --debug $*
	helm install --dry-run  --debug $*

helm-test-%:
	if [ ! -f $*/templates/test.yaml ]; then helm install $* --name $(PREFIX)-$* ; fi
	if [ ! -f $*/templates/test.yaml ]; then helm test --cleanup $(PREFIX)-$* ; fi
	if [ ! -f $*/templates/test.yaml ]; then helm delete --purge $(PREFIX)-$* ; fi

clean-%:
	helm delete --purge `helm ls --all -q | grep $(PREFIX)`

clean:
	if [ "`helm ls --all -q | grep $(PREFIX)`" != "" ]; then helm delete --purge `helm ls --all -q | grep $(PREFIX)`; fi
	find . -name "*.tgz" -exec rm '{}' +