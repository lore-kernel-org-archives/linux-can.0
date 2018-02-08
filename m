From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Associate physical device with device name
Date: Thu, 8 Feb 2018 13:45:42 +0100
Message-ID: <87ddf56f-c829-6aad-5b86-474359d282d4@pengutronix.de>
References: <e8998556-5e13-1cec-f404-70c4679ca9c3@kvaser.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SMvKTmTq5ZVtC0Rtp9hyvvOpQGU8WTILi"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52561 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeBHMqX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Feb 2018 07:46:23 -0500
In-Reply-To: <e8998556-5e13-1cec-f404-70c4679ca9c3@kvaser.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jimmy Assarsson <extja@kvaser.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SMvKTmTq5ZVtC0Rtp9hyvvOpQGU8WTILi
Content-Type: multipart/mixed; boundary="AhqJZY93BSxnGcKa1n9TM5WLyT5veR6M2";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <extja@kvaser.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <87ddf56f-c829-6aad-5b86-474359d282d4@pengutronix.de>
Subject: Re: Associate physical device with device name
References: <e8998556-5e13-1cec-f404-70c4679ca9c3@kvaser.com>
In-Reply-To: <e8998556-5e13-1cec-f404-70c4679ca9c3@kvaser.com>

--AhqJZY93BSxnGcKa1n9TM5WLyT5veR6M2
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 03:38 PM, Jimmy Assarsson wrote:
> We would like to be able to associate physical (Kvaser) USB devices wit=
h
> their device names (can0 etc.).
> The interface's EAN (article number) combined with serial number, form =
a
> unique identifier.
>=20
> It is not possible to do this from the USB descriptor. Since the serial=

> number is not provided in the USB descriptor. And the same PID is reuse=
d
> for multiple EAN numbers. It is preferable with a solution that is
> independent of interface type (USB etc.), since we may support other
> devices in the future.
>=20
> This is somewhat similar to '"user id" for can usb adapters',
> https://marc.info/?l=3Dlinux-can&m=3D146565019622100
>=20
> What is the preferable way of solving this kind of problem? Is sysfs
> suitable?

Are your adaptors 100% idential? Then there is no way to tell them apart
in software. However you should be possible to write a custom udev rule
to rename the adapter depending on the physical USB-Port you are using.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--AhqJZY93BSxnGcKa1n9TM5WLyT5veR6M2--

--SMvKTmTq5ZVtC0Rtp9hyvvOpQGU8WTILi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlp8RnYACgkQk9IU1zQo
ZfEZbwf/WkgrRcKpfxa5Sle6sruCikzJgEtAH06+mc3c2vaxNx/cpV6uzktzRSPg
Gdf4NpFtYhRxbO5e9e16Jl/AHd5N6VeJ1STnC6c0b+HrkXEVguRYBVBN3GRE6aB8
LQHLFh7ccKimGHB5z9TU/zf7gHFy7CT9dX9GNut588J4p13pwaWcFkBkPW1MczUT
7H0AwP5weVN8QY/IEdEgmDYXgv8zr4t/8zAzFlil2vnaz6Bb3bDmGLSXEbb4ipiP
8qQ9cRh2ioe33lwlaDk694pDWW/ye19gd3v+HvV2Rfz7JETafD3Hp9eD/R/7+z5h
zMoap0mGAsoMNtTPeiw4Lnf49HfDFg==
=bpca
-----END PGP SIGNATURE-----

--SMvKTmTq5ZVtC0Rtp9hyvvOpQGU8WTILi--
