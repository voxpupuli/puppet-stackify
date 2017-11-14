# stackify

[![License](https://img.shields.io/github/license/voxpupuli/puppet-stackify.svg)](https://github.com/voxpupuli/puppet-stackify/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/voxpupuli/puppet-stackify.png?branch=master)](https://travis-ci.org/voxpupuli/puppet-stackify)
[![Puppet Forge](https://img.shields.io/puppetforge/v/puppet/stackify.svg)](https://forge.puppetlabs.com/puppet/stackify)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/puppet/stackify.svg)](https://forge.puppetlabs.com/puppet/stackify)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/puppet/stackify.svg)](https://forge.puppetlabs.com/puppet/stackify)

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with stackify](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with stackify](#beginning-with-stackify)
1. [Usage - Configuration options and additional functionality](#usage)
    * [Install stackify only](#install_stackify_only)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

The stackify module installs and manages the stackify agent and service on Windows systems.

Stackify is an APM tools that uses an agent on nodes that need to be monitored.

## Setup

### Setup Requirements

The stackify module requires the following:

* Puppet Agent 4.7.1 or later.
* Access to the internet.
* Stackify account setup and a license/activation key in hand.
* Windows Server 2012/2012R2/2016.

### Beginning with stackify

To get started with the stackify module simply include the following in your manifest:

```puppet
class { 'stackify':
    package_ensure                        => 'present',
    package_install_options_environment   => 'development',
    package_install_options_activationkey => 'XXXXXXXXXXXXXXXXXXXXXXXXXX',
}
```

This example downloads and installs the latest version of the stackify agent and ensures the stackify services are running and in the desired state.  After running this you should see your node pop up in the stackify servers list from the web ui.

A more advanced configuration including all attributes available:

```puppet
class { 'stackify':
   package_ensure                        => 'present',
   package_install_options_environment   => 'development',
   package_install_options_activationkey => 'XXXXXXXXXXXXXXXXXXXXXXXXXX',
   file_download_directory               => 'C:\\Temp',
   service_manage                        => true,
   service_ensure                        => true,
   service_enable                        => true,
 }
```

The above is just an example of the flexibility you have with this module.  You will generally never need to specify every or even so many parameters as shown.

## Usage

### Install Stackify only

Sometimes you might want to install the stackify agent but not manage the service.

```puppet
class { 'stackify':
    package_ensure                        => 'present',
    package_install_options_environment   => 'development',
    package_install_options_activationkey => 'XXXXXXXXXXXXXXXXXXXXXXXXXX',
    service_manage                        => false,
}
```

## Reference

### Classes

Parameters are optional unless otherwise noted.

#### `stackify`

Installs, configures, and manages the stackify agent.

#### `package_ensure`

Specifies whether the stackify package resource should be present. Valid options: 'present' and 'absent'.

Default: 'present'.

#### `package_install_options_environment`

*Required.*

Sets the stackify environment for this node.

#### `package_install_options_activationkey`

*Required.*

Your stackify license/activation key so the node can be associated with your stackify account.

#### `file_download_directory`

Specifies which directory to store the downloaded stackify agent installer in.

Default: 'C:\Temp'.

#### `service_manage`

Specifies whether or not to manage the desired state of the stackify windows services.

Default: true.

#### `service_ensure`

Whether or not the stackify services should be running or stopped. Valid options: true, false

Default: true.

#### `service_enable`

Whether or not the stackify services should be enabled at boot or disabled. Valid options: true, false

Default: true.

## Limitations

This module is only available for Windows 2012 or 2012 R2 and works with Puppet 4.0 and later.

## Development

## Contributing

1. Fork it ( https://github.com/voxpupuli/puppet-stackify/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
