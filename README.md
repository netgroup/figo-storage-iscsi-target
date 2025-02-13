# Podman Container for iSCSI Target Service

This repository provides a Podman container for setting up an iSCSI target service using Podman. It also includes instructions for creating a systemd service to ensure the container starts on host boot, along with the necessary volume for configuration.

## Prerequisites

- Podman installed on your system.
- Basic knowledge of systemd and iSCSI.

## Getting Started

Follow the steps below to build the Podman container, create the necessary Podman volume, and set up the systemd service.

### 1. Build the Podman Container

To build the Podman container, navigate to the root of the repository and run the following command:

```bash
podman build -t tgtd-image:v1 .
```

This command will create a Podman image named `tgtd-image:v1` based on the Dockerfile provided in this repository.

### 2. Create Podman Volume for Configuration

Next, you need to create a Podman volume that will hold the iSCSI target configuration files. Run the following command:

```bash
podman volume create tgt-confd
```

This will create a volume named `tgt-confd`, where you can store your configuration files.

### 3. Prepare Configuration Files

Place your iSCSI configuration files into the `tgt-confd` volume. You can use the provided `iscsi.conf` as an example. To copy the configuration file into the volume, you can use:

```bash
podman run --rm -v tgt-confd:/etc/tgt/conf.d -v $(pwd)/etc-tgt-conf.d/:/mnt tgtd-image:v1 /bin/bash -c "[ ! -e /etc/tgt/conf.d/iscsi.conf ] && cp -v /mnt/iscsi.conf /etc/tgt/conf.d/iscsi.conf"
```

Make sure to edit `etc-tgt-conf.d/iscsi.conf` with your configuration settings.

### 4. Run the Container with Podman

Now you can run the container using the `tgtd-podman-run` command to start the iSCSI target service. Use the following command:

```bash
./tgtd-podman-run
```

This script creates run the container and automatically builds a systemd file in the current directory.

### 5. Create, enable and start the `tgtd-podman` Systemd Service

To ensure that the container starts automatically on host startup, the `tgtd-podman-run` script creates a systemd service file name `tgtd-podman.service`.
The `tgtd-podman.service` can be soft-linkedin `/etc/systemd/system/` as following:

```bash
ln -sv $(pwd)/tgtd-podman.service /etc/systemd/system
```

and at this point, you can enable and start the service:

```bash
systemctl enable --now tgtd-podman.service
```
### Conclusion

You have successfully built a Podman container for the iSCSI target service, created a Podman volume for configuration, and set up a systemd service to ensure the container runs on host startup.

For further customization, please refer to the provided configuration files and adjust the parameters as necessary. If you encounter any issues, feel free to open an issue in this repository.

### License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

### Acknowledgments

- [Podman Documentation](https://podman.io/)
- [iSCSI Target Documentation](https://www.iscsi.org/)
