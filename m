From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: git question
Date: Wed, 11 Jan 2012 12:28:21 +0100
Message-ID: <4F0D7255.5040006@pengutronix.de>
References: <20111221091948.GC314@e-circ.dyndns.org> <4EF2D0F3.6080909@hartkopp.net> <4F0D6EA9.4070708@pengutronix.de> <20120111111841.GE314@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCAD9C1CC7B44D6BBA5A4EAEE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41004 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756275Ab2AKL2a (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 06:28:30 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=[127.0.0.1])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <mkl@pengutronix.de>)
	id 1RkwM1-0002om-OP
	for linux-can@vger.kernel.org; Wed, 11 Jan 2012 12:28:29 +0100
In-Reply-To: <20120111111841.GE314@e-circ.dyndns.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCAD9C1CC7B44D6BBA5A4EAEE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2012 12:18 PM, Kurt Van Dijck wrote:
>> nitpick:
>> Oliver, please don't forget to add your S-o-b if you are pushing commi=
ts
>> to the tree.
> in that regard, I was wondering if one could add the S-o-b way after
> the actual commit?=20

Yes but no.

Yes, you can change the commit message (git commit --amend), but if you
have already pushed it to the central repo on gitorious, you should not
do it, as it changes the history.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigCAD9C1CC7B44D6BBA5A4EAEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8NclsACgkQjTAFq1RaXHNqtwCfYLWqWgIxRyLTSOkyc+TzT4cf
ytAAoJfo2VBRw9MChWOujQ9WnnoKMUbm
=85dP
-----END PGP SIGNATURE-----

--------------enigCAD9C1CC7B44D6BBA5A4EAEE--
