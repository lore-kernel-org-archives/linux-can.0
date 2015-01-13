From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: c_can: (newbie) high system load when frame not acked?
Date: Tue, 13 Jan 2015 16:55:53 +0100
Message-ID: <54B54009.2020407@pengutronix.de>
References: <9c72f211-becc-4c0f-94f6-0700dfb1195e@GRBSR0089.marel.net> <alpine.DEB.2.02.1501121751530.28201@login> <1735533.0yOonAfCy1@heinz> <alpine.DEB.2.02.1501121948370.28201@login> <54B472B2.4010300@optusnet.com.au> <alpine.DEB.2.02.1501131523290.12789@login> <54B536C6.6030406@pengutronix.de> <alpine.DEB.2.02.1501131650320.12789@login>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="OGT8DjWkK5UKQ3sTqGKFiHln9GJF3oB34"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48774 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbbAMP4C (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 Jan 2015 10:56:02 -0500
In-Reply-To: <alpine.DEB.2.02.1501131650320.12789@login>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Viktor Babrian <babrian.viktor@renyi.mta.hu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OGT8DjWkK5UKQ3sTqGKFiHln9GJF3oB34
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/13/2015 04:54 PM, Viktor Babrian wrote:
>> Can you send patches?
>=20
> Sure, which version shall I diff it to? (where do I get them?) I
> currently work with the one that comes in 3.19-rc3. The changes are 3
> lines though.

3.19-rc3 is probably okay...

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--OGT8DjWkK5UKQ3sTqGKFiHln9GJF3oB34
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtUAJAAoJECte4hHFiupU4K8P/1ypEK/23etFOmfzgU55pKW6
pOL1dw8STYUTPN0UiU998lVDNv+olX4j//K33VmJPAN4dt201lhDgFZ16bXH8LH1
3AwbErH6MMFikJd0517gjIRJCkSyeWn/xvhLiM1/Jyd3jb5XNhuS11YwJDgh1YCr
Xil7yat+rIZ1O1IEmq93lm/CBvFwTv1rKSJLHLgn3jEeGR4r0RwnS2MHZWrsZSSt
uakBwYqQbuz1F7L/sbg3tdKLYHxawacpZ9EfO3eAf+eQlQ+M5k9IMlw8PIlzXIAL
YIihUIXSEnkOv4gwShdreGuxFkGVOS8DXKZyZJyBFmBs/JQ10oK79udYVI0uPztk
sUwQbPt/sTolasCcGQK/s0rwyitZkbwgdlU3WqJ7348YJeroQ8amvlUR7kgnddN4
rtV72ZlZ78nd7ZowKIIY/KPmp0ypYLi54fE/nNlWVT41Mb7Kr4u6yfjyecR/wKYn
nmds7m7vX8ftE1oumaUMzam3jJqcvMifH5+om+JLpAa76f0wBRSs/F5rKv1SmiAm
EzpNk8iw28hDxaIuN/U6IBveK/w//NtSEOfZtareeTDjjAOw6gh1f/RUSKLon0aV
lAtdL8PjLWTX4p1zL4AjE9C0bjaR7oFO9g5qXxbajv0thyo9CbyePLMVPZHXKJeC
2JFFlarxdSRPoBAa99kx
=MKt6
-----END PGP SIGNATURE-----

--OGT8DjWkK5UKQ3sTqGKFiHln9GJF3oB34--
