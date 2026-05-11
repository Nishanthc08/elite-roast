# Security Policy

## Supported versions

Only the latest release is supported. If you are on an older version, update first.

| Version | Supported |
| ------- | --------- |
| 1.0     | yes       |


## Reporting a vulnerability

Do not open a public GitHub issue for security vulnerabilities. Public issues are visible to everyone before a fix is ready.

Email nishanthc264@gmail.com instead. Include:

- What the vulnerability is
- How to reproduce it
- What the impact could be

You will get a response within 48 hours. Once a fix is ready and released, the vulnerability will be publicly disclosed with credit to the reporter if they want it.


## Notes on scope

elite-roast is a bash tool that runs in the user's terminal. It does not handle network traffic, store credentials, or run as a service. The main things worth reporting are:

- Anything in postinst or prerm that could be exploited during install or removal since these run as root
- Anything that could cause unintended file writes or deletions
- Privilege escalation through the sudo alias
