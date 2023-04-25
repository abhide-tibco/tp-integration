# Orchestrator Helm Chart

This repository hosts the official **[Orchestrator](https://github.com/sasahoo-tibco/tp-integration/tree/main/helm/charts/orchestrator) Helm Charts** for deploying **Orchestrator** products to [Kubernetes](https://kubernetes.io/)

## Install Helm (only V3 is supported)

Get the latest [Helm release](https://github.com/helm/helm#install).

## Install Charts

### Add Orchestrator Helm repository

Before installing Orchestrator helm charts, you need to add the [Orchestrator helm repository](https://github.com/sasahoo-tibco/tp-integration/tree/main/helm/charts/orchestrator) to your helm client.

```bash
helm repo add orchestrator https://github.com/sasahoo-tibco/tp-integration/tree/main/helm/charts/orchestrator
helm repo update
```

**Note:** For instructions on how to install a chart follow instructions in its _README.md_.

## Contributing to Orchestrator Charts

Fork the `repo`, make changes and then please run `make lint` to lint charts locally, and at least install the chart to see it is working. :)

On success make a [pull request](https://help.github.com/articles/using-pull-requests) (PR) on to the `master` branch.

We will take this PR changes internally, review and test.

Upon successful review , someone will give the PR a __LGTM__ (_looks good to me_) in the review thread.

We will add PR changes in upcoming releases and credit the contributor with PR link in changelog (and also closing the PR raised by contributor).


