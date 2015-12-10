From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 5/5] can: flexcan: Add support for non RX-FIFO mode
Date: Thu, 10 Dec 2015 13:19:20 +0100
Message-ID: <56696DC8.8020708@pengutronix.de>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
 <1431603215-25546-6-git-send-email-bhupesh.sharma@freescale.com>
 <5554C244.80809@pengutronix.de>
 <BY1PR0301MB130358076C3A5969406DE69182D80@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <BY1PR0301MB130384E91308C49A850DEC4782E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GnKnExSCuspSC3PEBEWWpQ8LSFk9rmrj2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33590 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750814AbbLJMTj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Dec 2015 07:19:39 -0500
In-Reply-To: <BY1PR0301MB130384E91308C49A850DEC4782E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sharma Bhupesh <bhupesh.sharma@freescale.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arora Sakar <Sakar.Arora@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GnKnExSCuspSC3PEBEWWpQ8LSFk9rmrj2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/10/2015 12:05 PM, Sharma Bhupesh wrote:
>>> -----Original Message-----
>>> From: Marc Kleine-Budde [mailto:mkl@pengutronix.de]
>>> Sent: Thursday, May 14, 2015 9:12 PM
>>> To: Sharma Bhupesh-B45370; arnd@arndb.de; linux-can@vger.kernel.org
>>> Cc: bhupesh.linux@gmail.com; Arora Sakar-B45205; linux-arm-
>>> kernel@lists.infradead.org
>>> Subject: Re: [PATCH v2 5/5] can: flexcan: Add support for non RX-FIFO=

>>> mode
>>>
>>> On 05/14/2015 01:33 PM, Bhupesh Sharma wrote:
>>>> This patch adds support for non RX-FIFO (legacy) mode in the flexcan=

>>>> driver.
>>>>
>>>> On certain SoCs, the RX-FIFO support might be broken, as a result we=

>>>> need to fall-back on the legacy (non RX-FIFO) mode to receive CAN
>>>> frames.
>>>>
>>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
>>>> Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>
>>>
>>> The non FIFO mode doesn't guarantee the order of the incoming frames,=

>>> not does not even try to...this is not acceptable. I'm currently
>>> working on a patch by David Jander that brings in non FIFO mode, but
>>> tries to keep the order of the frames.
>>
>> That is already WIP at our end. V3 will contain the same change.
>> If you are already working on it, I don't know how to proceed further =
as
>> we had already v1 of this patchset with the non FIFO mode out since a
>> month or so.
>=20
> I don't remember seeing a patch from you which supports non-FIFO mode f=
or flexcan IP.
> Since we now have Freescale LS1021A chip out in the field on which the =
FIFO mode broken,
> we cannot use the upstream flexcan driver for enabling flexcan IP on th=
ese chips.
>=20
> Do you still have plans to work on this? Or should I submit my v3 with =
in-order reception
> supported for rx frames.

The problem is, that the current code triggers a ordering issue (at
least on the imx6) in non FIFO mode. The frames are not received as the
documentation states. If you have access, take a look at "SR#
1-4074792564 : CAN Ordering Issues". It seems the freescale support
doesn't have much interest in confirming the issue, nor bringing us in
touch with the people who have access to the IP core source to see
what's going on.

If we have to rely on the timestamps the next logical step is to add
sorting by timestamp to the rx-fifo implementation. I'll send a patch
series of the current state.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--GnKnExSCuspSC3PEBEWWpQ8LSFk9rmrj2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWaW3KAAoJEP5prqPJtc/HEWwH/1avfMrKRh89HdLXYK43uUcK
4/DmI5XpqOO0yE5Y2R1nn2VWWXX3yKCYeFikYpUow2E7/xoYIR4psgYJ5ftFzkVS
lfkw/GjxoyJrKg/zmtkh2c266Es5iA4tuMM7QCCCzB9eHwLW7ULvlkPkfsRNJonv
TwRNbTVZ4kUrxSaoeCIo6hSzQtZ1+iYoR8z5GkF63JKNma3AFug7yKqMB1T9362w
sl4XMcup5VN7zTIYDauRfLusz17U5+/POsM3Gb2SR3PTnKMNvZJ9NXIRCySjBECk
G2MkkjxQvXYwFDpICz5gCUZC6+Jt5J2RDjBrgyYx4zdaLb//66HHDsZ+FjKuHdk=
=kM3n
-----END PGP SIGNATURE-----

--GnKnExSCuspSC3PEBEWWpQ8LSFk9rmrj2--
