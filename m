From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] cangen: use long long in time computation for -g to support
 >2.1s
Date: Thu, 07 Feb 2013 14:02:52 +0100
Message-ID: <5113A5FC.4000404@pengutronix.de>
References: <20130207101708.B072CFC0@ratt.gitorious.c.bitbit.net> <1360233489-14471-1-git-send-email-mkl@pengutronix.de> <511384F4.703@pengutronix.de> <51138A44.5090306@awinia.de> <5113A4A3.70003@pengutronix.de> <5113A525.2030208@awinia.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2HRGSVKKNAVUHKPFMPKVH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56846 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab3BGNDP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 Feb 2013 08:03:15 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=bjornoya.do.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <mkl@pengutronix.de>)
	id 1U3R8E-00015K-1g
	for linux-can@vger.kernel.org; Thu, 07 Feb 2013 14:03:14 +0100
Received: from [IPv6:2001:6f8:105b:1122:21d:e0ff:fe39:f61b] (hardanger.wlan.blackshift.org [IPv6:2001:6f8:105b:1122:21d:e0ff:fe39:f61b])
	(using TLSv1 with cipher ECDHE-ECDSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: frogger)
	by bjornoya.do.blackshift.org (Postfix) with ESMTPSA id D3FC75E860
	for <linux-can@vger.kernel.org>; Thu,  7 Feb 2013 14:03:13 +0100 (CET)
In-Reply-To: <5113A525.2030208@awinia.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Konrad Anton <konrad.anton@awinia.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2HRGSVKKNAVUHKPFMPKVH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/07/2013 01:59 PM, Konrad Anton wrote:
> On 07.02.2013 13:57, Marc Kleine-Budde wrote:
>=20
>>
>> Thanks for the details. Looks good. Can I add your Signed-off-by[1] to=

>> the patch?
>>
>> Marc
>> [1]
>> http://lxr.free-electrons.com/source/Documentation/SubmittingPatches#L=
298
>=20
> Yes.

Pushed to master.

Tnx,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2HRGSVKKNAVUHKPFMPKVH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlETpf0ACgkQjTAFq1RaXHM1VgCdF7cmW9J/ttVQt3Am2mdDH+Uf
/4cAmwapEKQwYonTNvZ6IdCM+a43isH/
=zT3O
-----END PGP SIGNATURE-----

------enig2HRGSVKKNAVUHKPFMPKVH--
