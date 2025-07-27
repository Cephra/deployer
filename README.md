# Deployer

This repository is a collection of scripts and configs that I use to automatically deploy my projects. It uses webhooks to trigger the deployment process, so it can be used with any CI/CD system. I'm using it with GitHub Webhooks at the moment, but you could also use it with GitLab or Bitbucket Pipelines.

I'm using [adnanh/webhook](https://github.com/adnanh/webhook) to receive webhooks on my server.
You have to put it behind a reverse proxy like nginx or apache, for example:
```nginx
location /hooks {
  proxy_pass http://127.0.0.1:9000/;
}
```

## Structure

```
/webhook/deploy.sh      # executed by the webhook user; runs main script via sudo

/deployer/deploy.sh     # main script that checks out the latest commit

/etc/webhook/hooks.json # hook configuration for GitHub Webhooks
```

## Prerequisites

- `webhook` user and `deployer` user on your server.
- sudoers entry so `webhook` user can run `/deployer/deploy.sh` as user `deployer`.
- webhook config file in `/etc/webhook/hooks.json`
- webhook script in `/webhook/deploy.sh`
- main script in `/deployer/deploy.sh`
- secret to protect your webhook from unauthorized requests.
- `deploy.sh` inside every project you want to deploy.

## How it works

**Quick flow**: `git push origin main` → webhook fires → `/deployer/deploy.sh` runs via sudo
When the webhook is triggered, the script in `/deployer/deploy.sh` is executed. It checks out the latest commit and runs the `deploy.sh` file from the project. The `deploy.sh` file should be inside every project you want to deploy and it should handle all necessary steps for deployment. Examples can be found in two of my projects:

- [https://github.com/Cephra/blog](https://github.com/Cephra/blog)
- [https://github.com/Cephra/dummypage](https://github.com/Cephra/dummypage)

## For questions and feedback

Feel free to open an issue or contact me via email.

## License

This project is licensed under the GPL-3.0 License - see the [LICENSE](https://github.com/Cephra/deployer/blob/master/LICENSE) for details.