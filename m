From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can/peak_pci: fix FPGA potential frame loss issue
Date: Wed, 20 Jan 2016 15:33:41 +0100
Message-ID: <569F9AC5.6020706@pengutronix.de>
References: <1453288532-15034-1-git-send-email-s.grosjean@peak-system.com>
 <569F9588.2090809@pengutronix.de> <569F99BE.70001@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="qguLV2CoCAoKMQWAwIeU3oLv1ognP56JC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40139 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932261AbcATOdr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Jan 2016 09:33:47 -0500
In-Reply-To: <569F99BE.70001@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qguLV2CoCAoKMQWAwIeU3oLv1ognP56JC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/20/2016 03:29 PM, Stephane Grosjean wrote:
>=20
> Le 20/01/2016 15:11, Marc Kleine-Budde a =C3=A9crit :
>> On 01/20/2016 12:15 PM, Stephane Grosjean wrote:
>>> This patch installs a workaround when the driver detects one of the
>>> following PEAK-System CAN interfaces, running a firmware < v1.3.0:
>> Is the problem fixed on FW >=3D 1.3.0? Is it possible to update the
>> firmware? If so, what about printing a warning message about known
>> problem with the firmware?
>=20
> Yes, problem is fixed with 1.3.0.
> And yes, firmware can be updated.
> What kind of warning message are you talking about? Do you mean that=20
> peak_pci could dev_warn() a text msg to inform about the fact that the =

> current FW is able to be upgraded?
>=20
> If yes, since peak_pci prints a single info line per CAN channel, what =

> would you prefer?
>=20
> - the same warning about the old FW version, for each candev, something=
=20
> like:
>=20
> [ 2200.129168] peak_pci 0000:05:01.0: can0 at=20
> reg_base=3D0xffffc90000678000 cfg_base=3D0xffffc90000676000 irq=3D22 FW=
=3D1.2.0=20
> should be updated
> [ 2200.129307] peak_pci 0000:05:01.0: can1 at=20
> reg_base=3D0xffffc90000678400 cfg_base=3D0xffffc90000676000 irq=3D22 FW=
=3D1.2.0=20
> should be updated
>=20
> - or a single warning msg for the hardware device, something like:
>=20
> [ 2200.129168] peak_pci 0000:05:01.0: Warning: FW v1.2.0 needs a=20
> workaround; update is available

One per hardware device is enough.
"Warning: FW v1.2.0 workaround active; Please update device Firmeware."

=2E..and a webpage displaying this message, so that you will find it.
Maybe even add a link to the website in the commit message.

> [ 2200.129168] peak_pci 0000:05:01.0: can0 at=20
> reg_base=3D0xffffc90000678000 cfg_base=3D0xffffc90000676000 irq=3D22
> [ 2200.129307] peak_pci 0000:05:01.0: can1 at=20
> reg_base=3D0xffffc90000678400 cfg_base=3D0xffffc90000676000 irq=3D22

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--qguLV2CoCAoKMQWAwIeU3oLv1ognP56JC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWn5rFAAoJEP5prqPJtc/HNKYH/RV+BEHZlSOXNqtcHj1dgzOM
iuy7i5QJgg1+P6ki17aqxqQAvQb3CWl9NOoekKCBb/3+LJhNrbwjupFp7HtUmfXg
CjYdmhsyHqXSPdYEmoMUCMalxwWpdukNj3e1YrSYkhYHZAwUqN/ZB7S+gZ8hEJ57
UWdhYvTHfl81JQaN4uX97S+bY2wHHwrXIeUCR4pwsK3w4t+XGDYw23vfEvpm4tpk
us1F/x4K6XtTIigevF8W+m27DfoMPHMhWEF7HEWszUn2QxwmbvOaqvokki/qZrKK
dX2NY6Yh3ybIQCR1lFZfj8J0Wz0faV8vlH52zoz4VyMmxJW8tZH2JnYuyFaP6CI=
=WT23
-----END PGP SIGNATURE-----

--qguLV2CoCAoKMQWAwIeU3oLv1ognP56JC--
