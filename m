From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Canutils can not up can0
Date: Tue, 22 Jul 2014 13:43:21 +0200
Message-ID: <53CE4E59.90602@pengutronix.de>
References: <53CE4BDC.1000508@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="jndLWrIpFN6MJDa2j0JL71jgVioTq1oH5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58218 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbaGVLn2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Jul 2014 07:43:28 -0400
In-Reply-To: <53CE4BDC.1000508@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: grommerin <grommerin@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jndLWrIpFN6MJDa2j0JL71jgVioTq1oH5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/22/2014 01:32 PM, grommerin wrote:
> Hello. I downloaded your utility canutils and installed it on i.MX6
> MarsBoard but I can not configure and run the CAN interface. Usually I
> used to do it "canconfig" of other version "canutils" but in your
> version of this file is not. How can I configure CAN bitrate with your
> tool? Best regards, Dzivakou Mikita.

Which version of cantuils are you using? Which version of canutils are
working for you? Do you get any error messages? What's the output of
"dmesg"?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--jndLWrIpFN6MJDa2j0JL71jgVioTq1oH5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPOTlkACgkQjTAFq1RaXHO+egCfSenh05nSTO1xK2gg4wRuL5tI
+J4An1iBGSxpeDXYTzJaqVmROWztHb1n
=Sav7
-----END PGP SIGNATURE-----

--jndLWrIpFN6MJDa2j0JL71jgVioTq1oH5--
