From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcp251x: Fix regulators operation without CONFIG_REGULATOR
Date: Fri, 14 Mar 2014 11:15:14 +0100
Message-ID: <5322D6B2.90904@pengutronix.de>
References: <1394786780-24083-1-git-send-email-shc_work@mail.ru> <1394790917.548655659@f79.i.mail.ru> <5322D303.8000601@pengutronix.de> <1394791904.45849417@f382.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ps15lccDIpXOgiwileG3acIfxlNOW13tU"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37964 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbaCNKPX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 14 Mar 2014 06:15:23 -0400
In-Reply-To: <1394791904.45849417@f382.i.mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ps15lccDIpXOgiwileG3acIfxlNOW13tU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2014 11:11 AM, Alexander Shiyan wrote:
> =D0=9F=D1=8F=D1=82=D0=BD=D0=B8=D1=86=D0=B0, 14 =D0=BC=D0=B0=D1=80=D1=82=
=D0=B0 2014, 10:59 +01:00 =D0=BE=D1=82 Marc Kleine-Budde <mkl@pengutronix=
=2Ede>:
>> On 03/14/2014 10:55 AM, Alexander Shiyan wrote:
>>> =D0=9F=D1=8F=D1=82=D0=BD=D0=B8=D1=86=D0=B0, 14 =D0=BC=D0=B0=D1=80=D1=82=
=D0=B0 2014, 10:49 +01:00 =D0=BE=D1=82 Marc Kleine-Budde <mkl@pengutronix=
=2Ede>:
>>>> On 03/14/2014 09:46 AM, Alexander Shiyan wrote:
>>>>> If CONFIG_REGULATOR is not set, devm_regulator_get() returns NULL,
>>>>> so use IS_ERR_OR_NULL() macro for checks.
>>>>>
>>>>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>>>>
>>>> This should probably go into net, right?
>>
>> I mean this is a patch for David Miller's net tree, not for net-next.
>=20
> This is not a critical patch, patch just makes the right checks.

Okay, applied to can-next, that goes via net-next into v3.15.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ps15lccDIpXOgiwileG3acIfxlNOW13tU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMi1rIACgkQjTAFq1RaXHPAHgCfYQcGLbpSNKF10A/ve6bNKheM
bQcAn1MBbnnEQoYsgtpodQ3mNLmLqJ3e
=CiOI
-----END PGP SIGNATURE-----

--ps15lccDIpXOgiwileG3acIfxlNOW13tU--
