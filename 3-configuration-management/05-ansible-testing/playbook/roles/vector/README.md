vector-role
=========

This role install Vector

Requirements
------------

* Ansible 2.19 or higher
* Debian-based system (tested on Debian 12)

Role Variables
--------------

### Defaults Variables
| Name           | Default Value | Description                      |
| -------------- | ------------- | -------------------------------- |
| vector_version | 0.44.0        | The version of Vector to install |

### Vars Variables
| Name               | Default Value           | Description                               |
| ------------------ | ----------------------- | ----------------------------------------- |
| vector_config_path | /etc/vector/vector.yaml | The path to the Vector configuration file |

Dependencies
------------
No external dependencies.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: vector-role }


Templates
----------------
| Name           | Description                   |
| -------------- | ----------------------------- |
| vector.yaml.j2 | Standard Vector configuration |

Tasks
----------------
* Downloading the distribution
* Updating the package cache
* Installing and running Vector
* Deploying the Vector configuration

Handlers
----------------
* Restarting Vector when the configuration changes

License
-------

MIT

Author Information
------------------

Osipov Dmitry
