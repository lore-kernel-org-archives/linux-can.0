From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Getting manufacturer/product name for CAN interface
Date: Tue, 18 Jul 2017 08:23:35 +0200
Message-ID: <18d6c6fc-fcc2-34d9-a98a-1d2ae4d1e0b1@pengutronix.de>
References: <c3904508-14b9-1ffb-8507-9196fa193f56@gmx.de>
 <955344be-5991-5de9-a705-5f2e480c765d@grandegger.com>
 <5c9a4542-aa3d-c54f-7f83-d7cd3f594a65@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="L2mLURmabM4N4FsaNDorLAurgft2cMrS1"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48587 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750931AbdGRGXo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2017 02:23:44 -0400
In-Reply-To: <5c9a4542-aa3d-c54f-7f83-d7cd3f594a65@gmx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Marcel.Birthelmer@microchip.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L2mLURmabM4N4FsaNDorLAurgft2cMrS1
Content-Type: multipart/mixed; boundary="ggxEcRkWMdBWkl3gPPWxRGHoeVn0o9WID";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 Marcel.Birthelmer@microchip.com
Message-ID: <18d6c6fc-fcc2-34d9-a98a-1d2ae4d1e0b1@pengutronix.de>
Subject: Re: Getting manufacturer/product name for CAN interface
References: <c3904508-14b9-1ffb-8507-9196fa193f56@gmx.de>
 <955344be-5991-5de9-a705-5f2e480c765d@grandegger.com>
 <5c9a4542-aa3d-c54f-7f83-d7cd3f594a65@gmx.de>
In-Reply-To: <5c9a4542-aa3d-c54f-7f83-d7cd3f594a65@gmx.de>

--ggxEcRkWMdBWkl3gPPWxRGHoeVn0o9WID
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 09:36 PM, Andr=C3=A9 Hartmann wrote:
> thanks for your hints! I've investigated a bit (with PEAK and SYSTEC
> adapters) and I'm partly satisfied.
>=20
> Wolfgangs tip with ip -d gives me indeed the driver associated to a
> CAN interface. And in /sys/class/net/can0/subsystem/can0/device/
> interface I found the device string, thanks Marcel. (Full logs are
> appended).
>=20
> However, the most important infos are still only visible in dmesg.
> It's the drivers output which CAN channel is associated with each
> hardware interface, e.g.:
>=20
> peak_usb 2-1.4:1.0: PEAK-System PCAN-USB Pro [...] (2 channels)
> peak_usb 2-1.4:1.0 can0: attached to PCAN-USB Pro channel 0 (device 1)
> peak_usb 2-1.4:1.0 can1: attached to PCAN-USB Pro channel 1 (device 0)
>=20
> So if there is no way to get these infos from userspace now, I think it=

> would be a good addition to have this possibility. Especially if there
> is more than one CAN adapter connected.

Does the udev property dev_id help? See
http://permalink.gmane.org/gmane.linux.can/5227 for more information.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ggxEcRkWMdBWkl3gPPWxRGHoeVn0o9WID--

--L2mLURmabM4N4FsaNDorLAurgft2cMrS1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlltqWcACgkQHv7KIOw4
HPbkOAf9Gzwms2KqzCAbnEUrF9pH7U16XkRuftNPb9og8z/yGQOHZoVJjEcPyk1g
nrOtVdKdYIPa7nU1bsYfKdVl2LUYqv0xe2HB5mDsAV8JrPZUv/G0kb3F/e15/PdX
o1EMDqylQoxqbMQ/DYETyYfNwbpcMS+fXrFRkVG5b6CdG6VOyCzJHE1dx0K7hfPb
EqAsTHBUv0kiUTYTrUoAlWi2M/gyNSxZgD9N2HoDmdqqdYyoVJitCUZIa2xtpK/q
e+l0XZAMAOr0EXBcB9g1nxRKnQfDwdZsU9vvHzh/NNB2pNhEYFZoBRYibKV554dT
FPXmGQvUBlbvjy2mYVAG9EcNg7LTsQ==
=R2zH
-----END PGP SIGNATURE-----

--L2mLURmabM4N4FsaNDorLAurgft2cMrS1--
