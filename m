From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/4] import kernel header files into tree
Date: Wed, 11 Jan 2012 14:45:36 +0100
Message-ID: <4F0D9280.4070905@pengutronix.de>
References: <1322831813-9729-1-git-send-email-mkl@pengutronix.de> <4F0D7FF0.5020306@pengutronix.de> <20120111133707.GI314@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC63988ADC48E49774E56ACC8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59966 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757068Ab2AKNpl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 08:45:41 -0500
In-Reply-To: <20120111133707.GI314@e-circ.dyndns.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, socketcan-core@lists.berlios.de

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC63988ADC48E49774E56ACC8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2012 02:37 PM, Kurt Van Dijck wrote:
>>> this patch series imports the kernel header files into the can-utils =
tree
>>> and adopts both Makefile and autotools. The autotools complete the
>>> "make distcheck" test and are tested for cross compildation.
>>> Plain old makefile support is still working, too.
>>>
>>> Please test and comment,
>=20
> I must have missed this call. So put my questions way too late.

It's not too late, I can still answer it

> Why does commit 77de10356fe0eca7bce73e9c3ac4ed32edfc10e5
> say 'kernel headers' where it actully puts the can-modules headers
> (i.e. include/socketcan) ?

The commit imports the include files from the external kernel modules
tree [1], not the mainline kernel. (It actually is a squashed subtree
merge of the git svn imported berlios tree.)

[1] https://gitorious.org/linux-can/can-modules/trees/master/include

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigC63988ADC48E49774E56ACC8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8NkoIACgkQjTAFq1RaXHPr8QCeN0dLMTqB+GHVuHfTdMez0PqV
gc4AnjixsZ/P0pC3uqoHGAqFuQO2NZCS
=ThTr
-----END PGP SIGNATURE-----

--------------enigC63988ADC48E49774E56ACC8--
