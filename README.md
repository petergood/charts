# Onedata Helm Charts

A collection of of Onedata helm charts for running Onedata services as well as tools used by Onedata team.

The Charts in this repository are organized into two folders:

- stable: charts used daily in Onedata development cycle
- drafts: experimental charts that might be moved to stable in the future
- utils: usefull tools and plain kubernetes objects.

Stable Charts meet the criteria in the [technical requirements](https://github.com/kubernetes/charts/blob/master/CONTRIBUTING.md#technical-requirements).

Stable charts are packed and published in Onedata chart [repository](https://github.com/onedata/charts/tree/gh-pages).

## How do I install these charts?

First you need to add the Onedata charts for your local client, run `helm repo add`:

```
$ helm repo add onedata https://onedata.github.io/charts/
"onedata" has been added to your repositories
```

You can then run `helm search onedata` to see the charts.

Then run `helm install onedata/<chart>`.

For more information on using Helm, refer to the [Helm's documentation](https://github.com/kubernetes/helm#docs).