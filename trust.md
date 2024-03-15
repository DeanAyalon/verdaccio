# @dean/trust-verdaccio
## Introduction and Purpose
<!-- This package contains my self-signed Verdaccio certificate and a quick script allowing NPM to trust it. -->
This package contains a script that allows a package manager to trust/distrust self-signed certificates<br>
This is intended to be used internally and allow me to encrypt my server without paying for certification.

<!-- I use a different SSL certificate for each of my servers, in case a key gets compromised.<br>
**Note** - The certificates may regenerate at any given time, based on security, development purposes, or other reasons. Make sure you have the latest version of [this package](https://deanayalon.com:4873/-/web/detail/@dean/trust-verdaccio) in order to trust my current certificate and be able to use the registry. -->

## Table of Contents

1. [Introduction and Purpose](#introduction-and-purpose)
2. [Security Warning](#warning)
3. [Privacy](#privacy)
4. [Usage](#usage)
    1. [Downloading packages](#simple-downloads)
    1. [Package Manager](#package-manager)
    2. [Trust](#trust)
    3. [Content Interaction](#content-interaction)
5. [Important to Note](#important-to-note)
6. [Legal](#legal)
    1. [Disclaimers](#disclaimers)
    2. [Security Measures](#security-measures)
    3. [Reporting Issues](#reporting-issues)
    4. [Legal Advice](#legal-advice)
    5. [License](#license)
9. [Contact](#contact)
10. [Thanks](#thanks)


# WARNING
As a self-signed certificate, the HTTPS requests performed to and from [my registry](https://deanayalon.com:4873) are encrypted, BUT there is no trusted third party to verify my (Dean Ayalon) identity or trustworthiness.<br>
The security warning you'll get on your browser trying to connect is not necessarily about "the line being compromised", but rather about the receiver at the end of it, me, is not to be trusted.

Since I am in the process of development, and use the sites privately, I have not paid for a verified certificate and see not need to do so at the moment. 

<!-- Allowing your package manager to trust my certificate will give you the ability to sign up to my registry and publish packages to it. <br> -->
Allowing your package manager to trust self-signed certificates will give you the ability to sign up to my registry and publish packages to it.
**Warning - This skips SSL verification and exposes you to MITM attacks using my server**

Though I am not currently able to view your password, nor do I ever intend to - I still HIGHLY recommend you **DO NOT** use a compromisable password! <br>
I recommend you choose a completely random password, preferrably auto-generated, so that even if my own security gets breached, you are not placed in danger.

## Privacy
- I do store your IPs and username, for legal purposes.<br>
- Upon request, I can hide packages from the view of the public, only to be accessed by you and specified users of your choice.<br>
Note I will still have access to it as well.

# Use
### Simple downloads
To download a package from the registry, the user may simply use the website's UI.<br>

## Package Manager
The interaction, as far as managing content is concerned, is limited on the website, and mostly performed in the command line interface (terminal/console).

In order to register or interact with this repository, you need to have a Package Manager installed, such as [npm](https://nodejs.org/en/download/) or 
[yarn](https://classic.yarnpkg.com/en/docs/install/#debian-stable).<br>

## Trust
Package Managers are configured by default not to trust self-registered certificates, as they are unvouched for.

<!-- In order to allow your package manager to trust self-signed certificates, and add my certificate to the whitelist, I have created the 'trust.sh' script within this package.<br> -->
In order to allow your package manager to trust self-signed certificates, I have created the 'trust.sh' script within this package.<br>

You may not have permissions to run the script right away, you may set them using:<br>
`chmod u+x PATH_TO_THIS_FOLDER/trust.sh`<br>
u+x means you allow only the User that owns this file, yourself, to eXecute this script.

I'd suggest running it with `-h` for detailed information:<br>
`PATH_TO_THIS_FOLDER/trust.sh -h`

**It is important to note that this script will allow the manager to trust ALL self-signed packages, and thus poses a security risk, make sure to revert it at the end of your session!**<br>
To revert and secure your manager, use:<br> 
`PATH_TO_THIS_FOLDER/trust.sh -r`

An upgraded version of the trust script, allowing use of only my own certificate, is in development, but has proven far more complex than originally believed.

The script can trust my certificate or revert the action, either with npm or yarn.<br>
Feel free and encouraged to go through the code and verify its integrity and honesty.

**PLEASE DO NOT MODIFY THIS SCRIPT**

## Content Interaction
Once your package manager trusts my certificate, you may use it to interact with the registry

### Download a package
To download a package through the terminal and automatically add it to an existing package.json as a dependency, use:<br>
- `npm --registry=https://deanayalon.com:4873 install <package>`
- `yarn --registry-https://deanayalon.com:4873 add <package>`

**Please exercise extreme causion downloading packages from my regitry!**

### Add user or login <br>
- `npm --registry=https://deanayalon.com:4873 login`
- `yarn --registry-https://deanayalon.com:4873 login`

Again, I remind you to **use a secure password!**

### Publish package <br>
- `npm --registry=https://deanayalon.com:4873 publish <path>`
- `yarn --registry-https://deanayalon.com:4873 publish <path>`

If no path is provided, npm will try publishing the working directory (The current folder your terminal/console is in).

A package is any directory which contains a 'package.json' file. If the file is not found, the publish process will crash.

### Generate package.json Template
`npm init` or `yarn init`<br>
This will open up a prompt requesting basic information about the package, and then generate a proper package.json file.

### Working With Versions
When publishing a package, the registry looks at the version provided within the package.json file.
On the site, published packages are stored along with all their versions.

Package version follows the format: `major.minor.fix-dev`<br>
Examples: `1.0.0`, `3.2.12-feat`, etc.

If the version already exists, it must be unpublished before being publishing again.<br>
- `npm --registry=https://deanayalon.com:4873 unpublish <package>@<version>`
- `yarn --registry-https://deanayalon.com:4873 unpublish <package>@<version>`

**Be warned that unpublishing packages or versions is irreversible! Unpublished data cannot be recovered**

> Note that you will need to add `--force` if this is the last remaining version of that package.<br>
> Upon trying to remove the last version of a package without using `--force`, the script will be refused and warn that removing the package will prevent from republishing a new version of it for 24 hours. That is wrong and may be ignored - The package can be republished right away.

To remove an entire package along with all its versions, use:<br>
- `npm --registry=https://deanayalon.com:4873 unpublish <package> --force`
- `yarn --registry-https://deanayalon.com:4873 unpublish <package> --force`

If no package is specified, the script searched for a 'package.json' file within the working directory, and attempts to unpublish the package version specified within

**For more options and other commands, use the `--help` flag**
- `npm --help` or `npm <command> --help`
- `yarn --help` or `yarn <command> --help`

## Important to Note
The server performs a bi-daily (twice a day) cleaning script, and removed all unprotected packages!<br>
This is to prevent clatter, junk, or malicious/illegal content.

Also important to know - By default, packages are completely public, anyone may download them, and any user may upload/remove pacakges and versions

In order to protect packages and/or restrict access, contact [Dean Ayalon](mailto:deanayalon@me.com)

# Legal
## Disclaimers
I do not hold accountability for any content on [my Verdaccio server](https://deanayalon.com:4873) (aka 'the registry'). This includes:

- **Content uploaded to the registry:** The registry is open to the public and allows anyone to upload content. I will cooperate with authorities and share any necessary information to enforce laws violated using this service.

- **Content downloaded/shared from the registry:** The site allows access to anyone. I have not checked for malware or other security measures, and as the site is not intended for public release, security checks are not a priority. Users are advised to exercise caution and not download files they do not trust.

- **Content lost or removed from the registry:** The registry is highly volatile, and content can be changed or removed at any moment without notice.

- **Content stolen from the registry:** While I take digital security seriously, I am not responsible for any data breaches or theft. If malicious parties manage to steal data, it is beyond my control. 

- **Integrity or security of the registry:** The registry is in a constant state of development and is intended for private use. If any malicious activity is detected, it will be taken down as soon as possible.

- **Wrongful, malicious, or illegal usage of any content in the registry:** I do not endorse or support any illegal activities. Just don't.

**ANY ILLEGAL CONTENT OR USAGE WILL BE ACTED AGAINST, VINDICTIVELY!**

## Security Measures
While I do not actively monitor for malware or other security threats, I have implemented basic security measures to protect the integrity of the content. These measures include:

- **Authentication:** Access to the registry requires authentication. The passwords are hashed from my view.
- **Encryption:** Communication with the registry is encrypted using SSL/TLS.
- **Access Control:** Only authorized users can upload or modify content. For package-specific access, contact me.

I do not hold accountability for the integrity of the implemented security system.

## Reporting Issues

If you encounter any security issues, illegal content, or have any concerns regarding the use of the registry, please contact me directly at [my email](mailto:deanayalon@me.com) or [WhatsApp](https://wa.me/972549009763). I will investigate any reports and take appropriate action.

## Legal Advice
This document is intended to provide a basic overview of the legal disclaimers and restrictions associated with the use of my Verdaccio server. For comprehensive legal protection, please consult with a legal professional.

## License
This package is licensed under the terms of the MIT license.<br>
**PLEASE DO NOT MODIFY ANYTHING WITHIN THIS PACKAGE**

### Restrictions
Please note that modifications to this package are not allowed. If you wish to use this package in a modified form, please [contact me](mailto:deanayalon@me.com) for permission with a good reason.

# Contact
Hi, I am Dean Ayalon, a software developer from Israel. If you don't know me, please avoid using this server. Thank you :)

[Email](mailto:deanayalon@me.com)<br>
[Phone](tel:+972549009763)<br>
[WhatsApp](https://wa.me/972549009763)

## Thanks
evab - For continuous guidance and support, through all my nagging

**All Rights Reserved to Dean Ayalon, 2024**<br>
Powered by [Verdaccio](https://verdaccio.org)