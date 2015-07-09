From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: SV: Setting up flexcan mailboxes in Linux
Date: Thu, 9 Jul 2015 10:38:04 +0200
Message-ID: <559E32EC.5060006@pengutronix.de>
References: <81C1BF6140F61847A49020308B539A57128B21@MBX01.hosting.local>
 <559BA424.5010106@pengutronix.de>
 <81C1BF6140F61847A49020308B539A57128EFA@MBX01.hosting.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="8v5EJULMcmm2txhOoOmmLhAC7tjcGdV8J"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58237 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbbGIIiK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jul 2015 04:38:10 -0400
In-Reply-To: <81C1BF6140F61847A49020308B539A57128EFA@MBX01.hosting.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Emil Fors <emil@koenigsegg.se>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8v5EJULMcmm2txhOoOmmLhAC7tjcGdV8J
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Emil,

please just use the mailinglist (CC'ed).

On 07/09/2015 10:33 AM, Emil Fors wrote:
> thank you. I am trying out the software filtering now. It doesn't
> work (lets everything throuh regardless of what filters I set), but I
> won't bother you with that. Going to check out that mailing list you
> mentioned, see if anyone knows what the problem might be.

Please share your filter setup code. The software filters are working in
general. Older version have the limitation that you might get a CAN
frame twice, if you've set up multiple filters that match.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--8v5EJULMcmm2txhOoOmmLhAC7tjcGdV8J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVnjLsAAoJEP5prqPJtc/H8egH/ArCSWslmyFXKNQhZKF6xzl1
pTB/BbO9HTrZrRK/lYMyS/d3bjO3nP6zKKv6RNaThJISycUGRycxsDo6eIdiBMGq
BievbGjO/Adek/kKlxhsjJUBxhKkRSHS4R85tt/iJBQkf+woJSC1TnrHLMcLgzF6
2cLql8V7sVzDUfcVdA7MnAjWxck29JrCdGjx3sXT2chNOMrOT5vhe7Ee8fYlwBjh
h8+ABVD6k8RYwRoZfMR+WmFfXENJgTnKgobP5vt9/sBFx4YMF/RRGFBWjf0T4bpY
eoC4A+O4iTB/NqU/nofuUpv4Argg8+ooFehbyIVYeHCE2x1Ko9+qvYKRdyefjF0=
=csHL
-----END PGP SIGNATURE-----

--8v5EJULMcmm2txhOoOmmLhAC7tjcGdV8J--
