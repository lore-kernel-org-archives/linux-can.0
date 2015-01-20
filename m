From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can/peak_usb: add adapter BEC callback definition
Date: Tue, 20 Jan 2015 15:19:55 +0100
Message-ID: <54BE640B.2050509@pengutronix.de>
References: <1421684127-12764-1-git-send-email-s.grosjean@peak-system.com> <1421684127-12764-3-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1SmBtU8BO5Kn5MQGALix0JjvTqIcmqQCv"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53336 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbbATOT6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Jan 2015 09:19:58 -0500
In-Reply-To: <1421684127-12764-3-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1SmBtU8BO5Kn5MQGALix0JjvTqIcmqQCv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2015 05:15 PM, Stephane Grosjean wrote:
> Add the definition of a new callback that enable any PEAK-System CAN US=
B
> adapter to grant read access to its Bus Error Counters value.
> This ability is not supported by all the PEAK-System adapters, thus,
> for those, the callback pointer will be initiaized to NULL, which is
> correct regarding the linux-can device driver specs.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c | 2 ++
>  drivers/net/can/usb/peak_usb/pcan_usb_core.h | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net=
/can/usb/peak_usb/pcan_usb_core.c
> index c23609a..7a73060 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -794,6 +794,8 @@ static int peak_usb_create_dev(struct peak_usb_adap=
ter *peak_usb_adapter,
>  	dev->can.data_bittiming_const =3D &peak_usb_adapter->data_bittiming_c=
onst;
>  	dev->can.do_set_data_bittiming =3D peak_usb_set_data_bittiming;
>  	dev->can.do_set_mode =3D peak_usb_set_mode;
> +	dev->can.do_get_berr_counter =3D
> +		peak_usb_adapter->candev_get_berr_counter;
>  	dev->can.ctrlmode_supported =3D peak_usb_adapter->ctrlmode_supported;=

> =20
>  	netdev->netdev_ops =3D &peak_usb_netdev_ops;
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net=
/can/usb/peak_usb/pcan_usb_core.h
> index a58d971..fb402d2 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
> @@ -70,6 +70,8 @@ struct peak_usb_adapter {
>  	int (*dev_stop)(struct peak_usb_device *dev);
>  	int (*dev_restart_async)(struct peak_usb_device *dev, struct urb *urb=
,
>  					u8 *buf);
> +	int (*candev_get_berr_counter)(const struct net_device *netdev,
              ^^^^^^

I think this prefix can be removed. I've done so in my series.

> +				       struct can_berr_counter *bec);

>  	u8 ep_msg_in;
>  	u8 ep_msg_out[PCAN_USB_MAX_CHANNEL];
>  	u8 ts_used_bits;
>=20

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1SmBtU8BO5Kn5MQGALix0JjvTqIcmqQCv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUvmQLAAoJECte4hHFiupUrxYQAIKiSAdAp+qd6o80xRGEyY5x
lwtTANxclt6kFuUp3a6mwhpQpoMtwVru+nLDlhac9Lu8hcWS8Qt7kWLInobatZSb
nmWG+ZfT2JRWNU6npYlHCKVWNl18WzyxJgur35r1WmDfsJUaVsCgT7zu7GVMfU76
SOPRpwC/0NJpO+oVf/dm6efoMw/C71VFKufJuGu7UYhZPoLkQuxYVr0nvSLq2QQ7
AkWHiVd5i1vNx3p1MiVnPBgLuEOBvORayPI3VUagR2Qj2vugb+5rtjYa/tbirXIe
SkTZviEXQTIRIenzVRD1pM686/FiN6Rp0A5Wc3dUjIYSX00hGZg5FKbcMLl9ZwmW
hsQgTzEy7oOdSU4pCKQc7SKGlpOdVhDGmvkknL4bYcUSCKxWwNNzot2nsTU+5pM9
gyoQ/Jpbr4bHpRN34QVtVV7NmKb8SN8eex93TnyIE3/rLLk2sqURjzhLfLZAfpr2
f8UjzB+uLz3XEYIEt1XIRrCu6DAJqIB0X1jOjbHVYqpf3CLB8s8JT5S4taycnXZq
pgxJMUiBGo+wkDYaDQ3NKMYhm7jCEC/oIEju96YnQ9ll41g8oAAlscTHaFZf6/1E
KqzMeABSmSjn1+9HjKS3R9SJ92tCzGVwMIWs6mNMPSsmh8Yj2ZJyIkFX8Lkkio8d
a40ZugwVliPYNTMXFI1x
=DQpy
-----END PGP SIGNATURE-----

--1SmBtU8BO5Kn5MQGALix0JjvTqIcmqQCv--
