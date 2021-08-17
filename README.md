# CIS-hardening-macOS-BigSur
## Introduction 
The purpose of the CIS-hardening-macOS-BigSur Repository is to harden machines running macOS 11.0(BigSur) according to [CIS Apple macOS 11.0 Benchmark](https://learn.cisecurity.org/benchmarks) Level 1 and Level 2 Compliance. 

Hardening tasks are executed using [Ansible](https://www.ansible.com/) playbooks.

## Instructions
### Installing Ansible 
To run Ansible playbooks, Ansible must be installed. Install Ansible for your desired OS [here](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#).

### Update Organization-defined Values
The `vars/org.yml` file contains default values derived from the CIS Benchmark, but they can be updated in this file to values that have been defined for the organization.

### Executing Playbooks 
To run both Level 1 and Level 2 hardening tasks:

`ansible-playbook cis-harden.yml`

To run Level 1 hardening tasks only, run the following:

`ansible-playbook cis-harden.yml --tags "level_1"`

To run Level 2 hardening tasks only, run the following:

`ansible-playbook cis-harden.yml --tags "level_2"`

## Caveats 

### General
- It is possible that certain user configurations that are being check in this playbook do not yet exist on an endpoint. When this is the case, we have added the `ignore_errors: yes` flag to those tasks and have coded the remediations to set the correct values when those user configuration checks have a return code of 1.
- Full Disk Access is required for some commands to be successful. It is disabled by default, and can be turn on here once full disk access has been granted to the process running the playbook.

### 1.X
- Task 1.7 _Computer Name Considerations_ is to be set to an organization's standards if applicable. Refer to page 29 of the Benchmark to conduct this manually. 
### 2.X
- Task 2.1.1 _Turn off Bluetooth, if no paired devices exist_ is functional as of July 29th 2021. However, CIS will be updating the remediation in v.1.3.0 see more information [here](https://workbench.cisecurity.org/tickets/13360).
- Task 2.5.1.1 _Enable FileVault_ requires local user name and password to be enabled via CLI. To conduct this manually, see page 91 of the Benchmark.
- Task 2.5.1.2 _Ensure all user storage APFS volumes are encrypted_ requires specific volume names that can vary for different machines based on their configurations. To conduct this manually, see page 95 of the Benchmark. 
- Task 2.5.1.3 _Ensure all user storage CoreStorage volumes are encrypted_ requires specific volume names that can vary for different machines based on their configurations. To conduct this manually, see page 99 of the Benchmark. 
- Task 2.5.4 _Monitor Location Services Access_ is based upon disabling unnecessary applications from using Location Services and allowing websites to ask for permission to use Location Services. This can depend based on your organization's policies if applicable. See page 114 of the Benchmark to conduct this manually.
- Task 2.6.1 _iCloud configuration_ involves enabling certain iCloud services and thus depends upon your organization's policies if applicable. See page 126 of the Benchmark to conduct this manually.
- Task 2.6.2 _iCloud keychain_ involves configurations that depend upon your organization's policies if applicable. See page 131 of the Benchmark to conduct this manually. 
- Task 2.6.3 _iCloud Drive_ involves configuring iCloud Drive according to your organization's policies if applicable. See page 135 of the Benchmark to conduct this manually.
- Task 2.6.4 _iCloud Drive Document and Desktop sync_ involves disabling iCloud Desktop and Document syncing that cannot be accessed via terminal and must be done manually for each user. See page 137 of the Benchmark to conduct this manually.
- Task 2.7.1 _Time Machine Auto-Backup_ requires specific volume names that can very across machines in order to function. To conduct this manually, see page 141 of the Benchmark. 
- Task 2.7.2 _Time Machine Volumes Are Encrypted_ requires specific volume names that can vary for different machines based on their configuration. To conduct this manually, see page 145 of the Benchmark. 
- Task 2.11 _Ensure EFI version is valid and being regularly checked_ has recommended remediations, including reinstalling the Operating System, that cannot be automated. Refer to your organization's requirements if applicable to direct your course of action. See page 156 of the Benchmark for more information.
- Task 2.14 _Review Sidecar Settings_ is not checked because Sidecar has no known security issues. If your organization requires it to be enabled or disabled, refer to page 167 of the Benchmark to conduct changes. 
### 3.X
- Task 3.2 _Configure Security Auditing Flags per local organizational requirements_ requires configurations based on your organizaton's policies if applicable, see page 171 of the Benchmark to conduct changes.  
- Task 3.7 _Software Inventory Considerations_ involves the removal of any "unnecessary" applications which can depend on your organization's policies if applicable. See page 183 of the Benchmark for more information. 
### 4.X
 - Task 4.3 _Create network specific locations_ involves the removal and creation of any Network locations present on a macOS machine, this can vary with your organization. To conduct this manually, see page 192 of the Benchmark.
 - Task 4.6 _Review Wi-Fi Settings_ requires specific network device numbers and the option of Enabling and Disabling wireless depends on your organization's policies if applicable. See page 198 of the Benchmark to conduct this manually. 
### 5.X
- Task 5.2.3 _Complex passwords must contian an Alphabetic Character_ has a standard of requiring at least one Alphabetic Character, however it should be modified to your organization's standards if applicable. To conduct this manually, see page 217 of the Benchmark.
- Task 5.2.4 _Complex passwords must contain a Numeric Character_ has a standard of requiring at least one Numeric Character, however it should be modified to your organization's standards if applicable. To conduct this manually, see page 219 of the Benchmark.
- Task 5.2.5 _Complex passwords must contain a Special Character_ has a standard of requiring at least one Special Character, however it should be modified to your organization's standards if applicable. To conduct this manually, see page 221 of the Benchmark.
- Task 5.2.6 _Complex passwords must uppercase and lowercase letters_ has a standard of requiring at least one mix of upper and lower case letters, however it should be modified to your organization's standards if applicable. To conduct this manually, see page 223 of the Benchmark.
- Task 5.2.7 _Password Age_ has a standard of passwords expiring after at most 365 days, however it should be modified to your organization's standards if applicable. See page 225 of the Benchmark to conduct this manually. 
- Task 5.2.8 _Password History_ has a standard of requiring a password to be different from at least the last 15 passwords, however it should be modified to your organization's standards if applicable. See page 227 of the Benchmark to conduct this manually. 
- Task 5.4 _Automatically lock the login keychain for inactivity_ has a standard of locking the keychain after 6 hours of inactivity, however, this check requires the password of the users it is modifying. To conduct this manually, see page 232 of the Benchmark. 
- Task 5.6 _Ensure login keychain is locked when the computer sleeps_ has a requirement of locking users' keychains when the computer is in sleep mode. However, this check requires the password of the users it is modifying. To conduct this manually, see page 237 of the Benchmark. 
- Task 5.10 _Ensure System is set to hibernate_ is set to CIS default, however it should be modified to your organization's standards if applicable. See page 246 of the Benchmark to conduct this manually. 
- Task 5.13 _Create a custom message for the Login Screen_ contains a placeholder message, however it should be modified to your organization's standards if applicable. See page 256 of the Benchmark to conduct this manually. 
- Task 5.14 _Create a Login window banner_ contains a placeholder message, however it should be modified to your organization's standards if applicable. 
- Task 5.17 _Secure individual keychains and items_ allows for a user's keychain to have a separate password than the user's account. This should be applied based on your organization's standards if applicable. Refer to page 266 of the Benchmark to conduct this manually. 
- Task 5.18 _System Integrity Protection status_ must be run from the Recovery OS. See page 268 of the Benchmark to conduct this manually.
- Task 5.19 _Enable Sealed System Volume (SSV)_ must be run from the Recovery OS. See page 270 of the Benchmark to conduct this manually.
### 7.X
- Task 7.1 _Extensible Firmware Interface (EFI) password_ is not a recommended practice for most use cases at this time. Refer to page 295 of the Benchmark for more information.
- Task 7.2 _FileVault and Local Account Password Reset using AppleID_ is a concern in Enterprise environments. It may be unfavorable to use Apple services instead of Enterprise services. Refer to page 297 of the Benchmark. 
- Task 7.3 _App Store Password Settings_ may vary on a use basis, it is recommended to always require a password for accessing the App Store. Refer to page 299 of the Benchmark.
- Task 7.4 _Apple Watch features with macOS_ provides a description of features that an Apple Watch contains when paired with a macOS computer. These features such as being able to unlock a computer with an Apple Watch within a certain distance should be modified based on your organization's standards if applicable. Refer to page 300 of the Benchmark for more information. 
- Task 7.5 _System information backup to remote computers_ recommends enforcing solutions to retain log and audit records outside of the local machine. Refer to page 302 of the Benchmark for more information. 
- Task 7.6 _Touch ID_ provides a description of Touch ID's capabilities. Settings regarding Touch ID should be modified based on your organization's standards if applicable. Refer to page 303 of the Benchmark for more information. 
