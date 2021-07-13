# CIS-hardening-macOS-BigSur

To run both Level 1 and Level 2 hardening tasks:

`ansible-playbook cis-harden.yml`

To run Level 1 hardening tasks only, run the following:

`ansible-playbook cis-harden.yml --tags "level_1"`

To run Level 2 hardening tasks only, run the following:

`ansible-playbook cis-harden.yml --tags "level_2"`