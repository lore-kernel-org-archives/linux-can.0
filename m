From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/6] CAN FD support
Date: Mon, 18 Jun 2012 21:38:42 +0200
Message-ID: <4FDF83C2.6020407@pengutronix.de>
References: <4FDF67B2.1090004@hartkopp.net> <4FDF7D0E.1000802@pengutronix.de> <4FDF7E10.9050301@hartkopp.net> <4FDF8122.8050608@pengutronix.de> <4FDF81C3.9050108@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig07165D43E4E42875C530E17C"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34420 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab2FRTio (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 15:38:44 -0400
In-Reply-To: <4FDF81C3.9050108@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig07165D43E4E42875C530E17C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/18/2012 09:30 PM, Oliver Hartkopp wrote:
> On 18.06.2012 21:27, Marc Kleine-Budde wrote:
>=20
>> On 06/18/2012 09:14 PM, Oliver Hartkopp wrote:
>>>>> You can also pull the series ;-)
>>>>
>>>> I can pull, but David want's to have a clean tree. So I have to pull=
 and
>>>> rebase it on my tree.
>>>
>>>
>>> I created a branch 'canfd' on a clone of *your* can-next.
>>
>> No need for that. git pull --rebase works.
>>>
>>> What's not clean there?
>>>
>>> You can pull Daves net-next and then pull the canfd branch, right?
>>
>> Yes, but David wants to have a clean linear series of patches, not wit=
h
>> merges in it.
>=20
>=20
> What can i do now to support this?

No work on your side needed. I'll just rebase all patches on my tree
(and add my S-o-b).

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig07165D43E4E42875C530E17C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/fg8IACgkQjTAFq1RaXHPeOgCeIZcppM/MhywJg5lKGw8LSl3b
iUIAmgKbtQfA0acN74N+2lGaR4DBHFll
=PULG
-----END PGP SIGNATURE-----

--------------enig07165D43E4E42875C530E17C--
