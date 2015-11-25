# uchida.miniconda

[![Ansible Role](https://img.shields.io/ansible/role/6156.svg)](https://galaxy.ansible.com/detail#/role/6156)
[![CircleCI](https://img.shields.io/circleci/project/uchida/ansible-miniconda-role.svg)](https://circleci.com/gh/uchida/ansible-miniconda-role)
[![License](https://img.shields.io/github/license/uchida/ansible-miniconda-role.svg)](https://tldrlegal.com/license/creative-commons-cc0-1.0-universal)

ansible role to install miniconda, Python-agnostic binary package manager.

## Role Variables

Available role variables are listed below, along with default values:

```yaml
miniconda_python: 3
miniconda_version: "3.16.0"
miniconda_user: "{{ ansible_user_id }}"
miniconda_prefix: "{{ ansible_user_dir }}/miniconda{{ miniconda_python if miniconda_python == 3 else '' }}"
miniconda_update_conda: False
miniconda_env: ""
```

`miniconda_python` is a variable to specify python version miniconda based on.
default: `3`: install and use python3 based miniconda.

`miniconda_version` is a variable to specify version of miniconda.
default: `"3.16.0"`.

`miniconda_user` is a variable to specify install user of miniconda.
default: `"{{ ansible_user_id }}"`.

`miniconda_prefix` is a variable to specify install prefix for miniconda.
default: `~/miniconda` or `~/miniconda3`, it depends on `miniconda_python` and `miniconda_user`.

`miniconda_update_conda` is a variable to specify wheather to run `conda update conda` or not
default: `False`: do not update conda.

`miniconda_env` is a variable to specify conda environment to create.
default is `""`, nothing will be created.
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

## Example Playbooks

```yaml
- hosts: servers
  roles:
    - role: uchida.miniconda
      miniconda_python: 2
      miniconda_user: vagrant
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
dedicated to public domain
