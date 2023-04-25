#Platform Integration Capabilities helm charts

## Overview

This directory contains the recipes to build and examples to use the [**TIBCO Platform Intgration Capabilties**](https://github.com/sasahoo-tibco/tp-integration) Helm charts:

- [bw-provisioner](helm/charts/bwprovisoner/README.md): TIBCO Platform bw-provisioner helm chart.
- [orchestrator](helm/charts/orchestrator/README.md): TIBCO Platform Integration Orchestrator helm chart.
- [apiserver](helm/charts/apisrver/README.md): TIBCO Platform Integration Apisrver  helm chart.

See the respective README files for details and usage examples.

**Note**: There are other recipes in the `charts` directory not listed here.
They are used internally for better template reusability, and they include common software requirements and functions.

**Note**: You can build each chart on its own as described in the respective READMEs, or you can use the provided `Makefile` within this directory to build all the charts with just one single command. (This  `Makefile` also takes care of their internal dependencies.)

## Prerequisites

- Kubernetes 1.23+, a working kubernetes cluster from a ([certified k8s distro](https://www.cncf.io/certification/software-conformance/)).
- Helm 3+, for building and deploying the charts.

## Building the charts

To package all the charts in this directory, run `make` from the helm directory.
The included `Makefile` builds each of the charts, taking care of any dependencies.

```bash
make
```

**Note**: The built charts are saved into the directory `<this-repo>/helm/packages`.

### Alternative: Building the charts one by one

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

**Note**: The helm chart packages have dependencies; check the provided `Makefile` for more details.

### Customize and extend the charts

These recipes provide a standard, canonical, typical, or vanilla deployment for the TIBCO Spotfire® Platform.
They are suitable for most of the use case scenarios.

You are welcome to use and modify the recipes and adapt them to your specific use case, in compliance with the Apache License 2.0.
However, we recommend that you extend these charts, rather than modify them.
To extend the charts, create charts that import these official charts.
This way, it is easier for you to update your charts when new official recipes are released.
