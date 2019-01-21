# HOW TO UPGRADE DECIDEIX.ESPARRAGUERA.CAT

## Decidim 0.9.3

- First of all, Install ruby 2.5.0 on server
- Change DECIDIM_VERSION to the next stable version, in that cas 0.9.3
- bundle update decidim
- bin/rails decidim:upgrade
- bin/rails db:migrate
- check the changelog changes for any important change https://github.com/decidim/decidim/blob/0.9-stable/CHANGELOG.md
