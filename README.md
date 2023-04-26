# Platform Integration Applications Capabilities helm charts

## Overview

This directory contains the recipes to build and examples to use the [**TIBCO Platform Intgration Capabilties**](https://github.com/sasahoo-tibco/tp-integration) Helm charts:

- [bw-provisioner](https://github.com/sasahoo-tibco/tp-integration/blob/main/helm/charts/bwprovisioner/README.md): TIBCO Platform bw-provisioner helm chart.
- [orchestrator](https://github.com/sasahoo-tibco/tp-integration/blob/main/helm/charts/orchestrator/README.md): TIBCO Platform Integration Orchestrator helm chart.
- [apiserver](https://github.com/sasahoo-tibco/tp-integration/blob/main/helm/charts/apiserver/README.md): TIBCO Platform Integration Apisrver  helm chart.

See the respective README files for details and usage examples.

**Note**: There are other recipes in the `charts` directory not listed here.
They will be added here whenver there is requirement for new capabilities addition.

## Prerequisites

- Kubernetes 1.23+, a working kubernetes cluster from a ([certified k8s distro](https://www.cncf.io/certification/software-conformance/)).
- Helm 3+, for building and deploying the charts.

## Building the charts

You can package the provided charts, one by one, by following these steps from each of the provided charts directories:

1. Go to the chart directory. For example:
    ```bash
    cd <this-repo>/helm/chart/<tibco-platform-integration-capabilities-chart>
    ```

2. Update the chart dependencies:
    ```bash
    helm dependency update .
    ```

3. Package the chart:
    ```bash
    helm package . -d <helm-charts-destination-path>
    ```

Repeat for each of the charts.

### Customize and extend the charts

These recipes provide a standard, canonical, typical, or vanilla deployment for the TIBCO Spotfire® Platform.
They are suitable for most of the use case scenarios.

You are welcome to use and modify the recipes and adapt them to your specific use case, in compliance with the Apache License 2.0.
However, we recommend that you extend these charts, rather than modify them.
To extend the charts, create charts that import these official charts.
This way, it is easier for you to update your charts when new official recipes are released.
