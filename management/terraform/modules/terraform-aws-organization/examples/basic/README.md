# Basic example

This example configures a simple organization with the following structure:

```
root/
├── Infrastructure
├── Suspended
└── Workloads
    ├── development
    ├── production
    └── qa
```

The `Suspended` OU has a SCP attached, `scp_deny_all.json`.
