.PHONY: $(shell find * -type d -depth 0)

# #{{/*            for dashboard in /results/{{ $job.name }}-dashboard-*.json; do sed -i -e "s/CHANGE_ME_FROM_TIME/$submision_time/" -e "s/CHANGE_ME_TO_TIME/$completion_time/" $dashboard ; curl -v  -H "Content-Type: application/json" -H "Authorization: Bearer {{ $.Values.grafanaSnapshots.grafanaAPIKey }}" --data @${dashboard} http://{{ $.Values.grafanaGUIUrl }}/api/snapshots | sed -r 's#http://localhost:3000#http://{{ $.Values.grafanaGUIUrl }}#g' | jq -r ".url"  | xargs printf "- %s\n" >> $resultsPath ; done ; */}}

PREFIX = onedata-makefile-test-release

all: stress-nfs stress-job stress-suite

stress-nfs: build-stress-nfs
stress-job: build-stress-job
stress-suite: build-stress-suite
stress-experiment: build-stress-experiment

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