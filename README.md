# uchida.miniconda

[![Ansible Role](https://img.shields.io/ansible/role/6156.svg?maxAge=2592000)](https://galaxy.ansible.com/detail#/role/6156)
![Version](https://img.shields.io/github/tag/uchida/ansible-miniconda-role.svg)
[![License](https://img.shields.io/github/license/uchida/ansible-miniconda-role.svg?maxAge=2592000)](https://tldrlegal.com/license/creative-commons-cc0-1.0-universal)
[![Travis](https://img.shields.io/travis/uchida/ansible-miniconda-role.svg)](https://travis-ci.org/uchida/ansible-miniconda-role)

ansible role to install miniconda, Python-agnostic binary package manager.

## Role Variables

Available role variables are listed below, along with default values:

```yaml
miniconda_python: 3
miniconda_version: "3.16.0"
miniconda_installer: Miniconda{{ "3" if miniconda_python == 3 or miniconda_version not in miniconda_oldversions else "" }}-{{ miniconda_version }}-{{ miniconda_systems[ansible_system] }}-{{ miniconda_architecture[ansible_architecture] }}.sh
miniconda_installer_checksum: ""
miniconda_prefix: "{{ ansible_env.HOME }}/miniconda{{ miniconda_python if miniconda_python == 3 else '' }}"
miniconda_manage_dependencies: True
miniconda_update_conda: False
miniconda_env: ""
```

`miniconda_python` is a variable to specify python version miniconda based on.
default: `3`: install and use python3 based miniconda.

`miniconda_version` is a variable to specify version of miniconda.
default: `"3.16.0"`.

`miniconda_installer` is a variable to specify the miniconda installer filename.
default: defined by variables `miniconda_python`,`miniconda_version` and facts `ansible_system`,`ansible_architecture`

`miniconda_installer_checksum` is a variable to checksum for miniconda_installer.
default: `""`, do not check the digest.

`miniconda_prefix` is a variable to specify install prefix for miniconda.
default: `~/miniconda` or `~/miniconda3`, it depends on `miniconda_python`.

`miniconda_manage_dependencies` is a variable to specify whether to install `tar` and `bzip` or not,
these are required to run miniconda_installer.
default: `True`, install `tar` and `bzip`.

`miniconda_update_conda` is a variable to specify whether to run `conda update conda` or not.
default: `False`, do not update conda.

`miniconda_env_create_opts` is a variable to specify extra options for the `conda env create` task
default: `"-q"`, quiet mode (is recommended to ensure the create works)

`miniconda_env_update_opts` is a variable to specify extra options for the `conda env update` task
default: `""`, no additional opts
useful to set '--prune' (remove installed packages not defined in environment)

`miniconda_env` is a variable to specify conda environment to create.
default: `""`, nothing will be created.
its format is exactly same as conda env spec file, for example:
```yaml
miniconda_env:
  name: stats
  channels:
    - javascript
  dependencies:
    - python=3.4   # or 2.7 if you are feeling nostalgic
    - bokeh=0.9.2
    - numpy=1.9.*
    - nodejs=0.10.*
    - flask
    - pip:
      - Flask-Testing
```
you can install/update default environment by setting `root` to `miniconda_env.name`.

If you run this role with `gather_facts: no`, manually setting the following variables is required:

- `ansible_system`: choice of `['Linux', 'Darwin']`
- `ansible_architecture`: choice of `['x86_64', 'i386', 'armv7l', 'armv6l', 'ppc64le']`,
  check `miniconda_version` and availability in [miniconda installer archive](https://repo.continuum.io/miniconda/)
- `ansible_pkg_mgr`: package system, e.g, `apt` or `yum`, `dnf`, etc.

## Example Playbooks

```yaml
- hosts: servers
  roles:
    - role: uchida.miniconda
      miniconda_python: 2
      miniconda_prefix: /opt/miniconda
      miniconda_env:
        name: scipy
        dependencies:
          - python=2
          - numpy=1.9
          - scipy=0.14.0
          - matplotlib=1.4.0
```


## License

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed)
dedicated to public domain, no rights reserved.
