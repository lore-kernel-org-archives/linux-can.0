From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcba_usb: Add support for Microchip CAN BUS
 Analyzer.
Date: Thu, 5 Jan 2017 13:07:58 +0100
Message-ID: <6ceeaef3-488c-474d-6a94-2b8582c1916a@pengutronix.de>
References: <20161104080357.780-1-remigiusz.kollataj@mobica.com>
 <CAKT-o-c8vxCtmQnc+erAZ1fKr7++cMj0hLFhNTkj6Q92aph-oQ@mail.gmail.com>
 <31c2110b-f12c-b089-5595-645b16c8095f@hartkopp.net>
 <CAKT-o-fuiFvhGxRHmFptfAj2dUmy36LQR0KWhZ_u3x48p8vS1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="nshjP9iWJVrA2xG0TwSgCHcggJTM5OP7U"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44407 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757802AbdAEMIq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Jan 2017 07:08:46 -0500
In-Reply-To: <CAKT-o-fuiFvhGxRHmFptfAj2dUmy36LQR0KWhZ_u3x48p8vS1g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nshjP9iWJVrA2xG0TwSgCHcggJTM5OP7U
Content-Type: multipart/mixed; boundary="rRTmrKiB4G4w6wRxPTJbvQsmegM7tOGPB";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
 <remigiusz.kollataj@mobica.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Message-ID: <6ceeaef3-488c-474d-6a94-2b8582c1916a@pengutronix.de>
Subject: Re: [PATCH] can: mcba_usb: Add support for Microchip CAN BUS
 Analyzer.
References: <20161104080357.780-1-remigiusz.kollataj@mobica.com>
 <CAKT-o-c8vxCtmQnc+erAZ1fKr7++cMj0hLFhNTkj6Q92aph-oQ@mail.gmail.com>
 <31c2110b-f12c-b089-5595-645b16c8095f@hartkopp.net>
 <CAKT-o-fuiFvhGxRHmFptfAj2dUmy36LQR0KWhZ_u3x48p8vS1g@mail.gmail.com>
In-Reply-To: <CAKT-o-fuiFvhGxRHmFptfAj2dUmy36LQR0KWhZ_u3x48p8vS1g@mail.gmail.com>

--rRTmrKiB4G4w6wRxPTJbvQsmegM7tOGPB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/21/2016 06:18 PM, Ko=C5=82=C5=82=C4=85taj, Remigiusz wrote:
> On 20 December 2016 at 19:34, Oliver Hartkopp <socketcan@hartkopp.net> =
wrote:
>> Hi Remik,
>>
>> On 12/20/2016 07:55 AM, Ko=C5=82=C5=82=C4=85taj, Remigiusz wrote:
>>>
>>> Could someone tell me what happened with the patch below? Is there
>>> something more I shall do with it?
>>
>>
>> I'm generally fine with the patch when the debug stuff is removed
>=20
> Do you mean staff "controlled" by MCBA_*_DEBUG macros? I am wondering
> if there is a chance to refactor this part and keep it in code? It is
> very useful to learn device state.

You might use dynamic_netdev_dbg() instead.

>> agreed on a common netlink interface to configure the termination.
>=20
> Can we keep sysfs setting for now? I will update the driver once
> netlink API will be available. I will share my thoughts about the
> interfaces in the email thread you have mentioned.

No - better first add the driver without the a sysfs interfaces. Once
the netlink interface is merged, this feature can be added to the driver.=


Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--rRTmrKiB4G4w6wRxPTJbvQsmegM7tOGPB--

--nshjP9iWJVrA2xG0TwSgCHcggJTM5OP7U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlhuNx8ACgkQPTuqJayp
JWqwugf8DXdJAt95tUQfhSiB+9P0vUXh3n+EQD3LCiSaeGlVRA9QYf20xbgecWW4
txmT4Of0L6mQFxiSmGsp4alQ2yvQnG1u9EJ+swefErxG8JiRnJlG2jnMhv0iLk3T
OuAAclctNaOAJYOxQgu/u1libSIZNu6b1Ki80EuPw4KguXaTwNTG1lzfxv3Yw0CQ
DBt+6H394RnSCLSB2d4Ib3TFLzGw5tedwdYOKUdFnje8V0rNCbBCBevgCOFd0GBx
hjhSPtGQgi6tFow5Jr1MZE0EqdDez2MrWQSLWxSbY4Lln+l8Qjdul2W4u0q0J9EF
xgIXBeoAIoOYHzQHOubT8LMSA69Erw==
=nLyZ
-----END PGP SIGNATURE-----

--nshjP9iWJVrA2xG0TwSgCHcggJTM5OP7U--
