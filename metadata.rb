name             'allure-commandline'
maintainer       'Etki'
maintainer_email 'etki@etki.me'
source_url       'https://github.com/etki/cookbook-allure-commandline'
issues_url       'https://github.com/etki/cookbook-allure-commandline/issues'
license          'MIT'
description      'Installs Allure Framework commandline utility'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'ubuntu', '>= 14.04'
supports 'centos', '>= 6.5'
supports 'debian', '>= 7'

depends 'tar', '~> 2.0.0'
