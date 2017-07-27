# Atheme IRC Services in Docker
This is the Atheme Services daemon running in a Ubuntu 16.04 container.

Internally, this is installed to /services, and it expects /services/var and
/services/etc to be volumes. PID file is sitting in /services/atheme.pid

Everything is owned as 1000.
