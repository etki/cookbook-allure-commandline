# allure-commandline Cookbook

Installs [Allure Framework][allure] commandline utility.

Master branch: [![Travis/master](https://img.shields.io/travis/etki/cookbook-allure-commandline/master.svg?style=flat-square)](https://travis-ci.org/etki/cookbook-allure-commandline/branches)

Dev branch: [![Travis/dev](https://img.shields.io/travis/etki/cookbook-allure-commandline/dev.svg?style=flat-square)](https://travis-ci.org/etki/cookbook-allure-commandline/branches)

## Requirements

### Platforms

Tested:

- Ubuntu 12.04 & 14.04 & 16.04 (LTS versions)
- Debian 7.11 & 8.6
- CentOS 6.5 & 7.2
- Fedora 21 -> 25

Should work on any nix, though (doesn't explicitly depend on platform).

### Cookbooks

- [tar][tar-cookbook] to decompress downloaded package

### Chef

- Chef 12.0 or later

### Preinstalled software

This cookbook requires tar and gzip to be preinstalled. Those are 
usually present at the moment, and i've restrained from hardcoding 
logic that would install them from packages.

Allure requires Java 7+ to operate, however, installation doesn't 
depend on this.

## Attributes

| Key                                                  | Type   | Description     | Default |
|:-----------------------------------------------------|:-------|:----------------|:--------|
| `['allure_commandline']['version']`                  | String | Default version | `1.5.2` |
| `['allure_commandline']['default_install_location']` | String | Where to install Allure files using recipe-based installation | `/usr/local/allure/allure-commandline` |
| `['allure_commandline']['default_binary_location']`  | String | Where to install Allure binary using recipe-based installation | `/usr/bin/allure` |

## LWRPs

### allure_commandline

Installs Allure with specified options

```ruby
allure_commandline '/usr/bin/allure' do
  # defaults to ['allure-commandline']['version']
  version '1.5.2'
  # defaults to /usr/share/allure/allure-commandline/#{version}
  path '/usr/share/allure/allure-commandline'
  # if set, overrides name property
  # empty array allows to avoid creating symlinks at all
  links []
  # Internally GitHub API is used to find release url, so
  # you may need to supply access token to raise request
  # limit
  github_api_token 'abcd...'
  # Or just directly set url to the allure-commandline.tar.gz
  # version is ignored then
  url 'https://github.com/allure-framework/allure1/releases/download/allure-core-1.5.0/allure-commandline.tar.gz'
end
```

## Recipes

### allure-commandline::default

Installs Allure in default location 
(`/usr/share/allure/allure-commandline`), and symlinks binary to 
`/usr/local/bin/allure`.

## Drawbacks

Only 1.x versions are supported yet, at the moment of writing 2.0 
hasn't been publicly available yet.

## Contributing

1. Fork the repository on GitHub
2. Create a named feature branch (like `add-installation-option`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request to dev branch using GitHub

## License & Authors

Authors:

- Etki <etki@etki.me>

License: MIT

  [allure]: http://allure.qatools.ru/
  [tar-cookbook]: https://supermarket.chef.io/cookbooks/tar