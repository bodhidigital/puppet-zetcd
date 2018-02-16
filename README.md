<!-- README.md -->
# zetcd

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with zetcd](#setup)
    * [Beginning with zetcd](#beginning-with-zetcd)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Puppet module for managing coreos/zetcd, an Apache ZooKeeper "personality" for
etcd.

Builds, installs, creates service, and configures the go command
`github.com/coreos/zetcd/cmd/zetcd`.

## Setup

### Beginning with zetcd

Declare the `::zetcd`.  This will setup zetcd to listen for ZooKeeper requests
on `127.0.0.1:2181` and reach out to etcd at `http://localhost:2379`.

```
include '::zetcd'
```

## Usage

### Use zetcd listening on `0.0.0.0:2181`.

```
class { '::zetcd':
  zkaddr  => '0.0.0.0:2181',
}
```

### Use zetcd with full TLS authentication for an etcd cluster.

```
class { '::zetcd':
  endpoints => [
    "https://infra1.${::domain}:2379",
    "https://infra2.${::domain}:2379",
    "https://infra3.${::domain}:2379",
  ],
  cafile    => '/etc/pki/tls/etcd/ca.crt',
  certfile  => "/etc/pki/tls/etcd/$::fqdn.cert",
  keyfile   => "/etc/pki/tls/etcd/private/$::fqdn.key",
}

file { [ '/etc/pki', '/etc/pki/tls', '/etc/pki/tls/etcd' ]:
  ensure  => directory,
}
File['/etc/pki'] -> File['/etc/pki/tls'] -> File['/etc/pki/tls/etcd']
file { '/etc/pki/tls/etcd/ca.crt':
  source  => '/path/to/ca.crt',
  require => File['/etc/pki/tls/etcd'],
  before  => Class['::zetcd::service']
}
file { "/etc/pki/tls/etcd/$::fqdn.crt":
  source  => '/path/to/my.crt',
  require => File['/etc/pki/tls/etcd'],
  before  => Class['::zetcd::service']
}
file { '/etc/pki/tls/etcd/private':
  ensure  => directory,
  mode    => '0750',
  owner   => 'root',
  group   => $::zetcd::zetcd_group,
  require => [
    File['/etc/pki/tls/etcd'],
    Class['::zetcd::user'],
  ],
}
file { "/etc/pki/tls/etcd/priave/$::fqdn.key":
  source  => '/path/to/my.key',
  mode    => '0640',
  owner   => 'root',
  group   => $::zetcd::zetcd_group,
  require => [
    File['/etc/pki/tls/etcd/private'],
    Class['::zetcd::user'],
  ],
  before  => Class['::zetcd::service']
}
```

### Use an alternative repository for the `zetcd` command.

```
class { '::zetcd':
  zetcd_source  => "github.com/user/zetcd/cmd/zetcd",
}
```

### Use already installed zetcd and systemd service.

```
class { '::zetcd':
  manage_command      => false,
  manage_service_file => false,
  manage_zetcd_user   => false,
  manage_zetcd_group  => false,
  service_name        => 'zetcd-custom',
}
```

## Reference

### Public Classes

#### `::zetcd`

* `manage_command` - Build and install the zetcd command with go get.
  (`Boolean`, default: `true`)
* `manage_go_package` - Manage the go package. (`Boolean`, default: `true`)
* `manage_service_file` - Generate the systemd service. (`Boolean`, default:
  `true`)
* `manage_service` - Manage starting/enabling the systemd service. (`Boolean`,
  default: `true`)
* `manage_zetcd_user` - Create the zetcd user. (`Boolean`, default: true)
* `manage_zetcd_group` - Create the zetcd group. (`Boolean`, default: true)
* `zetcd_source` - The path passed to the `go get` command to build zetcd.
  (`String`, default: `'github.com/coreos/zetcd/cmd/zkctl'`)
* `zetcd_path` - The path to the zetcd command. (`Stdlib::Absolutepath`,
  default: `'/usr/local/bin/zetcd'`)
* `go_package` - The name of the go package. (`String`, default:
  `'golang-1.8-go'`)
* `go_path` - The path to the go command. (`Stdlib::Absolutepath`, default:
  `'/usr/lib/go-1.8/bin/go'`)
* `service_name` - The name of the zetcd service. (`String`, default: `'zetcd'`)
* `zetcd_user` - The user to use for the zetcd service. (`String`, default:
  `'zetcd'`)
* `zetcd_group` - The group to use for the zetcd service. (`String`, default:
  `'zetcd'`)
* `zkaddr` - The host and port for zetcd to listen on. (`String`, default:
  `'127.0.0.1:2181'`)
* `endpoints` - The etcd endpoints to connect to. (`Array[Stdlib::Httpurl]`,
  default: `[ 'http://localhost:2379' ]`)
* `cafile` - The path to the CA certificate for TLS validation.
  (`Optional[Stdlib::Absolutepath]`)
* `certfile` - The path to the TLS certificate to offer the endpoints.
  (`Optional[Stdlib::Absolutepath]`)
* `keyfile` - The path to the key for `certfile`.
  (`Optional[Stdlib::Absolutepath]`)

### Private Classes

* `::zetcd::user` - Creates the zetcd user and groups.
* `::zetcd::command` - Builds and installs zetcd.
* `::zetcd::conf` - Configures zetcd.
* `::zetcd::service` - Creates and manages the `zetcd` service.

## Limitations

Currently only supports Debian Stretch.

## Development

Feel free to contribute to the project at
[github.com/bodhidigital/puppet-zetcd](https://github.com/bodhidigital/puppet-zetcd).

<!-- vim: set ts=2 sw=2 et syn=markdown: -->
