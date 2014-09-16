From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: RFC: [PATCH v2] can: flexcan: Implement errata ERR005829
Date: Tue, 16 Sep 2014 14:58:01 +0200
Message-ID: <541833D9.2060607@pengutronix.de>
References: <1409755642-28233-1-git-send-email-david@protonic.nl>	<54081940.6060402@pengutronix.de>	<20140904104440.5766d764@archvile>	<5418238B.6010600@pengutronix.de> <20140916142846.2ae8335c@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CsM6huEsf83WItbKp0hMn5wxAhic16tJE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36241 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000AbaIPM6H (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 16 Sep 2014 08:58:07 -0400
In-Reply-To: <20140916142846.2ae8335c@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CsM6huEsf83WItbKp0hMn5wxAhic16tJE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/16/2014 02:28 PM, David Jander wrote:

>>> Please note that if the silicon bug didn't exist, none of the two wri=
tes
>>> would be necessary.
>>> Once you create a quirk for this, how are we supposed to know which
>>> versions need this quirk, and which don't? Can we trust the existence=
 of
>>> erratas for the different i.MX Soc's, and should we just go and check=
 them
>>> all?
>>
>> I had a patch with the quirk, but I removed it, as you suggested, just=

>> in case.
>=20
> I did not directly suggest to NOT use a quirk, I only had some concerns=
=2E In

Not directly, but between the lines :D

> the meantime I have checked a few of the SoCs for erratas, and found th=
is
> errata only for i.MX6 and Vybrid VF6xx, which makes me suspect this pro=
blem is
> unique to IP version 10 (if the IP version table at the beginning of th=
e
> source-code is to be trusted).

We don't even know the IP version of the flexcan core on the vybrid, it
has different features than the imx6 one.

> OTOH, if you decided to leave the unconditional writes in there, I am f=
ine
> with that. I don't think they do much harm.
>=20
> Is it time to revisit my other patch(es) yet? If so, from where should =
I pull
> the base?

Sorry, no time yet, but I've found another (luckily only a minor)
problem with the mailboxes. After sending a RTR frame the TX mailbox
gets automatically converted into a RX one.

See imx6 data sheet Table 26-5. Message Buffer Code for Tx buffers:

> Transmit remote request frame unconditionally once. After
> transmission, the MB automatically becomes an Rx Empty MB
> with the same ID.

I'll prepare a patch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--CsM6huEsf83WItbKp0hMn5wxAhic16tJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQYM9kACgkQjTAFq1RaXHPwBgCgjRcti2NJwQA9rnVgzYfe3N1o
4qEAoJc5tvb8TU0hOtGGEEcQCuIbl7R2
=9HGZ
-----END PGP SIGNATURE-----

--CsM6huEsf83WItbKp0hMn5wxAhic16tJE--
