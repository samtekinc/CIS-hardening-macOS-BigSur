# CIS-hardening-macOS-BigSur
## Introduction 
The purpose of the CIS-hardening-macOS-BigSur Repository is to harden machines running macOS 11.0(BigSur) according to [CIS Apple macOS 11.0 Benchmark](https://learn.cisecurity.org/benchmarks) Level 1 and Level 2 Compliance. 

These compliances are executed using [Ansible](https://www.ansible.com/) playbooks when applicable. Bash scripts are used when Ansible is not feasible, see [2.X](https://github.com/samtekinc/CIS-hardening-macOS-BigSur/tree/main/bash/2.X/tasks) for example.

## Instructions
### Installing Ansible 
To run Ansible playbooks, Ansible must be installed. Install Ansible for your desired OS [here](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#).

### Executing Playbooks 
To run both Level 1 and Level 2 hardening tasks:

`ansible-playbook cis-harden.yml`

To run Level 1 hardening tasks only, run the following:

`ansible-playbook cis-harden.yml --tags "level_1"`

To run Level 2 hardening tasks only, run the following:

`ansible-playbook cis-harden.yml --tags "level_2"`

## Caveats 
### 2.X
- Task 2.5.1.2 _Ensure all user storage APFS volumes are encrypted_ requires specific volume names that can vary for different machines based on their configurations. To conduct this manually, see page 95 of the Benchmark. 
- Task 2.5.1.3 _Ensure all user storage CoreStorage volumes are encrypted_ requires specific volume names that can vary for different machines based on their configurations. To conduct this manually, see page 99 of the Benchmark. 
- Task 2.7.2 _Time Machine Volumes Are Encrypted_ requires specific volume names that can vary for different machines based on their configuration. To conduct this manually, see page 147 of the Benchmark. 
- Task 2.11 _Ensure EFI version is valid and being regularly checked_ has recommended remediations, including reinstalling the Operating System, that cannot be automated. Refer to your organization's requirements if applicable to direct your course of action. 
- Task 2.14 _Review Sidecar Settings_ is not checked because Sidecar has no known security issues. If your organization requires it to be enabled or disabled, refer to page 167 of the Benchmark to conduct changes. 
### 5.X
- Task 5.2.3 _Complex passwords must contian an Alphabetic Character_ has a standard of requiring at least one Alphabetic Character, however it should be modified to your organization's standards if applicable. 
- Task 5.2.4 _Complex passwords must contain a Numeric Character_ has a standard of requiring at least one Numeric Character, however it should be modified to your organization's standards if applicable. 
- Task 5.2.5 _Complex passwords must contain a Special Character_ has a standard of requiring at least one Special Character, however it should be modified to your organization's standards if applciable. 
- Task 5.2.6 _Complex passwords must uppercase and lowercase letters_ has a standard of requiring at least one mix of upper and lower case letters, however it should be modified to your organization's standards if applicable. 
- Task 5.2.7 _Password Age_ has a standard of passwords expiring after at most 365 days, however it should be modified to your organization's standards if applicable.
- Task 5.2.8 _Password History_ has a standard of requiring a password to be different from at least the last 15 passwords, however it should be modified to your organization's standards if applicable. 
- Task 5.4 _Automatically lock the login keychain for inactivity_ has a standard of locking the keychain after 6 hours of inactivity, however this should be modified to your organizaiton's standards if applicable. 
- Task 5.10 _Ensure System is set to hibernate_ is set to CIS' example, however it should be modified to your organization's standards if applicable. 
- Task 5.13 _Create a custom message for the Login Screen_ contains a placeholder message, however it should be modified to your organization's standards if applicable. 
- Task 5.14 _Create a Login window banner_ contains a placeholder message, however it should be modified to your organization's standards if applicable. 
- Task 5.17 _Secure individual keychains and items_ allows for a user's keychain to have a separate password than the user's account. This applied based on your organization's standards if applicable, refer to page 266 of the Benchmark. 
### 7.X
- Task 7.1 _Extensible Firmware Interface (EFI) password_ is not a recommended practice for most use cases at this time. Refer to page 295 of the Benchmark for more information.
- Task 7.2 _FileVault and Local Account Password Reset using AppleID_ is a concern in Enterprise environments. It may be unfavorable to use Apple services instead of Enterprise services. Refer to page 297 of the Benchmark. 
- Task 7.3 _App Store Password Settings_ may vary on a use basis, it is recommended to always require a password for accessing the App Store. Refer to page 299 of the Benchmark.
- Task 7.4 _Apple Watch features with macOS_ provides a description of features that an Apple Watch contains when paired with a macOS computer. These features such as being able to unlock a computer with an Apple Watch within a certain distance should be modified based on your organization's standards if applicable. Refer to page 300 of the Benchmark for more information. 
- Task 7.5 _System information backup to remote computers_ recommends enforcing solutions to retain log and audit records outside of the local machine. Refer to page 302 of the Benchmark for more information. 
- Task 7.6 _Touch ID_ provides a description of Touch ID's capabilities. Settings regarding Touch ID should be modified based on your organization's standards if applicable. Refer to page 303 of the Benchmark for more information. 
