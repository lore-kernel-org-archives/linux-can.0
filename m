From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 7/7 v8] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Thu, 22 Jan 2015 16:41:15 +0100
Message-ID: <54C11A1B.4090100@pengutronix.de>
References: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com> <1421940266-6088-8-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="vqTMBgJVbf2iweWqixl3QI6P7b2blx6UI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54490 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbbAVPlS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Jan 2015 10:41:18 -0500
In-Reply-To: <1421940266-6088-8-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vqTMBgJVbf2iweWqixl3QI6P7b2blx6UI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/22/2015 04:24 PM, Stephane Grosjean wrote:
> Add support for the following new PEAK-System technik CANFD USB adapter=
s:
>=20
> PCAN-USB FD             single CANFD channel USB adapter
> PCAN-USB Pro FD         dual CANFD channels USB adapter
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

[...]

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_fd.c
> new file mode 100644
> index 0000000..2129549
> --- /dev/null
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c

[...]

> +/* handle device specific info used by the netdevices */
> +struct pcan_usb_fd_if {
> +	struct peak_usb_device *dev[PCAN_USB_MAX_CHANNEL];
> +	struct pcan_ufd_fw_info fw_info;
> +	struct peak_time_ref    time_ref;
> +	int                     cm_ignore_count;
> +	int                     dev_opened_count;

Please use tab for indention, not space.

> +};
> +
> +/* device information */
> +struct pcan_usb_fd_device {
> +	struct peak_usb_device  dev;
> +	struct can_berr_counter bec;
> +	struct pcan_usb_fd_if  *usb_if;
> +	u8                     *cmd_buffer_addr;

dito

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--vqTMBgJVbf2iweWqixl3QI6P7b2blx6UI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUwRobAAoJECte4hHFiupUBTwQAIqiUuhbWDQEs54getwto/6f
Yp+bbiNaqWNajfLoGUYFXEmQ7/JyVnV+lxqgwdy03fkTXpuDtHbkOvEV0d2AAN+6
HWBPVN/0/imdbB/jfWg024UT4IWVm2zkLJ+b/q8Musc8kyXigSYXCGBkGCxeTOH5
pKdF6Udw0u4/1lAUHnjvuuTcSlaM/1WQQ4VVcOGuBR7c+NM1CSbuKv4KpRVPlSSO
yhAhVIgJz4WYObEtAb31cSw2arwNvknk1iU1my5cvPGwUpg6+AaT6tYSxHRvIZtg
EUiZjDJDpr3oBAyZP5Q8G4JTUj6fTxoWKt9e+BsTHz3JxdIOZ+/Xx7ZGZ1uJgrQ9
OH8Skzf39sVTcNJK/KsO56zSj7IoHvd1Q/SP4XkCcXhxWzmtRTEbyWEldLCfcal9
ONnjtNzuQaCHKiHPT+f2F8jGm7QEfEhYcNUrS9XGSDhRz4RTw6bUu3hhYCmwGbEA
hvu5BUccCUWlsG7u2lNWNrmQ2xv+jCCIcPju/XsaF+VBYC5PBrZ42a6z948uxLwZ
4QmQAES2qs87BBc/Luhb1tqyG+gDXCBGx7eXtwgB1tGMnfOV6X9CYmOeiESwkA6j
wln85kdqtFhsHqmyBeb0XBmGy/7ZV9w37PFMzRCnX1FsHlMawWm4vSYK6HPr0n65
Ih9lY/8F2y7DWFgjaChx
=fzGM
-----END PGP SIGNATURE-----

--vqTMBgJVbf2iweWqixl3QI6P7b2blx6UI--
