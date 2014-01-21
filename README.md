LocalPuppet
===

A system for running Puppet from a local directory.

## The Setup

The configuration for localpuppet is defined by a small `yaml` hash.  Each of
the keys are symbolized with a leading colon.

### Build your configs

To begin, copy the existing templates in `var/templates/` and the sample config
in `etc/`.  Edit to suit, then run the setup command.

```
./bin/localpuppet -c /etc/localpuppet.yaml setup -v
```

This will build the configuration items for `puppet.conf`, `r10k.yaml`, and
`hiera.yaml` and place place them in `:basedir`, as defined by the config.

### Deploy R10k

This will deploy `r10k` to the `:basedir` directory.

```
./bin/localpuppet -c /etc/localpuppet.yaml deploy -v
```

### Execute Puppet

Puppet is now ready to execute with `puppet apply`.

```
puppet apply --config puppet.conf -v
```

## Vagrant

If you are looking to use vagrant, the templates for `hiera` and `puppet` need to be modified to use the `/vagrant` directory.

### Hiera

For `hiera`, this means modifying the `:datadir` to use `/vagrant.

### Puppet

For `puppet`, this means modifying the `confdir` to be `/vagrant`.


