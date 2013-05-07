From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH, RFC 01/22] can: move CONFIG_HAVE_CAN_FLEXCAN out of CAN_DEV
Date: Tue, 07 May 2013 11:18:53 +0200
Message-ID: <5188C6FD.9010903@pengutronix.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de> <1367507786-505303-2-git-send-email-arnd@arndb.de> <5183892B.8020400@pengutronix.de> <201305031724.15584.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2HNSPVJXIPHKTIRHBFOQQ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57929 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759292Ab3EGJS7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 May 2013 05:18:59 -0400
In-Reply-To: <201305031724.15584.arnd@arndb.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2HNSPVJXIPHKTIRHBFOQQ
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/03/2013 05:24 PM, Arnd Bergmann wrote:
> On Friday 03 May 2013, Marc Kleine-Budde wrote:
>> On 05/02/2013 05:16 PM, Arnd Bergmann wrote:
>>> CONFIG_HAVE_CAN_FLEXCAN is a silect symbol that is meant to be select=
ed
>>> by platforms that support this driver, but that is not possible witho=
ut
>>> also selecting CAN_DEV, unless we move it out of the "if CAN_DEV"
>>> section of the Kconfig file.
>>>
>>> warning: (SOC_IMX28 && SOC_IMX25 && SOC_IMX35 &&
>>>  IMX_HAVE_PLATFORM_FLEXCAN && SOC_IMX53 && SOC_IMX6Q) selects HAVE_CA=
N_FLEXCAN
>>>  which has unmet direct dependencies (NET && CAN && CAN_DEV)
>>
>> With the advent of multi platform kernels I like to get rid of
>> HAVE_CAN_FLEXCAN completely.
>=20
> Yes, good idea. Are there any other dependencies we need to add then?
> I assume FLEXCAN needs to depend on HAS_IOMEM and OF at least, but
> there might be more.

The driver compiles (tested on SH and blacksfin) and works without
CONFIG_OF (on non DT arm platforms).

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2HNSPVJXIPHKTIRHBFOQQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGIxv0ACgkQjTAFq1RaXHO3bQCfZP4g8Y+lK/pbe8e8m9gT4ixL
zbQAn1H1HTr0TmnFlfGJeTKy8MAPJa8Z
=37mW
-----END PGP SIGNATURE-----

------enig2HNSPVJXIPHKTIRHBFOQQ--
