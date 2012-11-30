From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC v2 4/7] c_can_pci: introduce board specific PCI bar
Date: Fri, 30 Nov 2012 10:19:04 +0100
Message-ID: <50B87A08.10205@pengutronix.de>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <1354199987-10350-5-git-send-email-wg@grandegger.com> <50B8723D.4080300@pengutronix.de> <50B8782A.7070709@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig916B552AC5A10E7FFD79201F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55702 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269Ab2K3JTL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Nov 2012 04:19:11 -0500
In-Reply-To: <50B8782A.7070709@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig916B552AC5A10E7FFD79201F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/30/2012 10:11 AM, Wolfgang Grandegger wrote:
> On 11/30/2012 09:45 AM, Marc Kleine-Budde wrote:
>> On 11/29/2012 03:39 PM, Wolfgang Grandegger wrote:
>>> Also fix minor issue with pci_iomap specifying size 0 for
>>> mapping the full range.
>>
>> If I understand the code correct, using pci_resource_len(pdev, 0) for
>> the max len (of BAR 0) instead of 0 isn't a bug, it's just more
>> complicated than it needs to be. If it really is a bug, I think a
>> separate patch will be good.
>=20
> It's a minor issue, not a bug. Both do the same thing. See:
>=20
> http://lxr.linux.no/#linux+v3.6.8/lib/pci_iomap.c#L23

I've looked at the code, too. Just wanted to be sure :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig916B552AC5A10E7FFD79201F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC4egsACgkQjTAFq1RaXHMIygCfbWagsq966gmxki68XJc6a/+m
wu4AnRjcj5DpB+bSC6KjshbwYZ/TAt+m
=6KS9
-----END PGP SIGNATURE-----

--------------enig916B552AC5A10E7FFD79201F--
