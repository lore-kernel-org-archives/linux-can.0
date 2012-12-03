From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/5] can: Kconfig: switch on CAN_RAW by default
Date: Mon, 03 Dec 2012 14:39:09 +0100
Message-ID: <50BCAB7D.5070604@pengutronix.de>
References: <1354197491-31205-1-git-send-email-mkl@pengutronix.de> <1354197491-31205-4-git-send-email-mkl@pengutronix.de> <50B85681.8030502@hartkopp.net> <50B86BF9.6020202@pengutronix.de> <50B8E6AA.4090209@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig92E0F225EFF15291BBE2CBD0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43663 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab2LCNjR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Dec 2012 08:39:17 -0500
In-Reply-To: <50B8E6AA.4090209@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig92E0F225EFF15291BBE2CBD0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/30/2012 06:02 PM, Oliver Hartkopp wrote:
> On 30.11.2012 09:19, Marc Kleine-Budde wrote:
>=20
>> On 11/30/2012 07:47 AM, Oliver Hartkopp wrote:
>>> On 29.11.2012 14:58, Marc Kleine-Budde wrote:
>>>
>>>> As CAN_RAW is the basic CAN protocol, switch it on by default.
>>>>
>>>
>>>
>>> Hello Marc,
>>>
>>> you are probably right, that most users will at least need CAN_RAW so=
ckets.
>>> But i asked myself, what the Linux distributions will do once we poin=
t out
>>> that a specific protocol is *preferred* to be enabled?
>>
>> I hope they enable it by default. However CAN_RAW will be only switche=
d
>> on, if CAN support is enabled.
>>
>=20
> Yes, if CAN support is enabled.
>=20
> The problem is that when it's enabled - what to select then?

Sorry, I don't get what you're trying to tell me.

With my patch, if you switch on CAN support, CAN_RAW will be enabled by
default. My rationale behind is, that CAN support is pretty useless
without CAN_RAW support.

> IMO all entries (RAW/BCM/GW) should be enabled by default when CAN is
> selected. When people really know what they do, the might deselect entr=
ies at
> their own risc ...

YMMV, BCM and GW are for experienced can users. But I can change the
patch to enable RAW, BCM and GW on by default.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig92E0F225EFF15291BBE2CBD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC8q4EACgkQjTAFq1RaXHMzlACgivV+y5YPfeSUNDqM1tRpM+5+
GPIAnjZkZzdNRse5ccEmOQCAMF3I1JL1
=LE6J
-----END PGP SIGNATURE-----

--------------enig92E0F225EFF15291BBE2CBD0--
