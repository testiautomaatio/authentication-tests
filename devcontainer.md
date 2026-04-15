# Development container

If you want to avoid installation issues and have a ready-to-use environment, you can use the provided [development container configuration](./.devcontainer/devcontainer.json). A [development container](https://code.visualstudio.com/docs/devcontainers/containers) is a [Docker container](https://www.docker.com/resources/what-container/) that has all the necessary tools and dependencies installed, allowing you to work in a consistent environment that is independent of your local setup.

To use the development container locally, you need to have [Docker](https://www.docker.com/get-started) installed on your machine and the [Visual Studio Code Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension installed. Once Docker is set up, you can open the project in VS Code and it will prompt you to reopen the folder in the container. After reopening, VS Code will build the container based on the configuration and install all the required tools and dependencies as specified in the [`postCreate.sh` script](./.devcontainer/postCreate.sh).


## Development container in the cloud

If installing Docker locally is not your preferred option, you can also use the same development container in a cloud-based environment such as [GitHub Codespaces](https://github.com/features/codespaces). GitHub Codespaces allows you to create a development environment in the cloud that is accessible through your browser or [your locally installed VS Code](https://docs.github.com/en/codespaces/developing-in-a-codespace/using-github-codespaces-in-visual-studio-code). The developer experience in Codespaces is very similar to using a local development container or a local installation.

You can open the project in GitHub Codespaces by following [this guide](https://docs.github.com/en/codespaces/developing-in-a-codespace/creating-a-codespace-for-a-repository#creating-a-codespace). After opening the repository in GitHub, you can create a new codespace by clicking on the "Code" button on the repository's front page and selecting "Open with Codespaces". This will create a new codespace that uses the same development container configuration, so you will have the same tools and dependencies available as if you were running it locally. This can be a convenient option if you want to avoid installing Docker or if you want to work from different machines without having to set up the environment each time.

Cloud based development environments are commercial services and may require a paid subscription. Be sure to check the pricing details of the service you choose to use. At the time of writing, GitHub Codespaces offers a free tier with limited hours of usage per month, and additional hours can be purchased if needed (see [docs.github.com](https://docs.github.com/en/billing/concepts/product-billing/github-codespaces)).


## Tips, troubleshooting, and resources

### Installing browser dependencies

Inside a development container, Playwright browsers need to be installed with a `--with-deps` flag. This is because the development container is minimal and does not include all system dependencies required by browsers, for example fonts.

> [!NOTE]
> ```bash
> npx playwright install chromium --with-deps
> ```
>
> In this exercise, the [`postCreate.sh` script](./.devcontainer/postCreate.sh) takes care of installing the browsers with the necessary dependencies, so you don't need to run this command manually. However, if you need to install additional browsers or if you are using a different development container setup, remember to include the `--with-deps` flag when installing browsers with Playwright.


### Opening the test report

Opening the Playwright HTML report from your own browser might not work when the report is served from the development container. This happens because Playwright will only allow the local machine to access the report for security reasons. When the report is opened inside the container, your own operating system is technically a separate host, so it should not be able to connect.

You can work around this by opening the report and setting the `--host` flag to listen to all interfaces, not just the local one. For example, you can run the following command in the terminal of the development container:

> [!NOTE]
> ```bash
> npx playwright show-report --host 0.0.0.0
> ```
>
> **⚠️ Security note**
>
> Binding to `0.0.0.0` exposes the report server to your network. Avoid doing this on untrusted networks unless you firewall it.
