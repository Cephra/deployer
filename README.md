# Deployer

This repository is a collection of scripts and configs that I use to automatically deploy my projects. It uses webhooks to trigger the deployment process, so it can be used with any CI/CD system. I'm using it with GitHub Webhooks at the moment, but you could also use it with GitLab or Bitbucket Pipelines.

## Structure

```
# this is the main script that runs on the server and checks out the latest commit
/deployer:
deploy.sh 

# this is an example of a hook configuration for GitHub Webhooks
/etc/webhook:
hooks.json 

# this script is executed by the webhook user
/webhook:
deploy.sh 
```

## Prerequisites

- A webhook to trigger the deployment process on the server.
- A secret to protect your webhook from unauthorized requests.
- A `deploy.sh` inside every project you want to deploy.
- A sudo config so the `webhook` user can run the deploy script as user `deployer`.

## How it works

When the webhook is triggered, the script in `deployer/deploy.sh` is executed. It checks out the latest commit and runs the `deploy.sh` file from the project. The `deploy.sh` file should be inside every project you want to deploy and it should handle all necessary steps for deployment. Examples can be found in two of my projects:

- [https://github.com/Cephra/blog](https://github.com/Cephra/blog)
- [https://github.com/Cephra/dummypage](https://github.com/Cephra/dummypage)

## For questions and feedback

Feel free to open an issue or contact me via email.

## License

This project is licensed under the GPL-3.0 License - see the [LICENSE](https://github.com/Cephra/deployer/blob/master/LICENSE) file for details.