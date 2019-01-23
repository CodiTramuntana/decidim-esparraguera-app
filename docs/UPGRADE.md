# HOW TO UPGRADE DECIDEIX.ESPARRAGUERA.CAT

## Decidim 0.12.2
- Before to deploy this version,
 Please execute this code on production before upgrading so the pages get created correctly and the migrations don't fail.
 ```
 Decidim::Organization.find_each { |organization| Decidim::System::CreateDefaultPages.call(organization) }
 ```
- Change DECIDIM_VERSION to the next stable version, in that case 0.12.2
- bundle update decidim
- bin/rails decidim:upgrade
- bin/rails db:migrate
- check the changelog changes for any important change https://github.com/decidim/decidim/blob/0.12-stable/CHANGELOG.md
- Execute next on rails console
```
Decidim::Meetings::Meeting.find_each(&:add_to_index_as_search_resource)
Decidim::Proposals::Proposal.find_each(&:add_to_index_as_search_resource)
```

## Decidim 0.11.2
- Change DECIDIM_VERSION to the next stable version, in that case 0.11.2
- bundle update decidim
- bin/rails decidim:upgrade
- bin/rails db:migrate
- check the changelog changes for any important change https://github.com/decidim/decidim/blob/0.11-stable/CHANGELOG.md

## Decidim 0.10.1
- Change DECIDIM_VERSION to the next stable version, in that case 0.10.1
- bundle update decidim
- bin/rails decidim:upgrade
- bin/rails db:migrate
- check the changelog changes for any important change https://github.com/decidim/decidim/blob/0.10-stable/CHANGELOG.md

## Decidim 0.9.3

- First of all, Install ruby 2.5.0 on server
- Change DECIDIM_VERSION to the next stable version, in that case 0.9.3
- bundle update decidim
- bin/rails decidim:upgrade
- bin/rails db:migrate
- check the changelog changes for any important change https://github.com/decidim/decidim/blob/0.9-stable/CHANGELOG.md
