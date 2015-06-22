From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN question: how to trace frame errors?
Date: Mon, 22 Jun 2015 15:15:54 +0200
Message-ID: <55880A8A.7010903@pengutronix.de>
References: <CAOpc7mFv6ePXqkCZxRkCOC+BuY-PC14nAopZyFpEKHvj5gN_tw@mail.gmail.com>
 <557AA7BE.6040004@pengutronix.de>
 <CAOpc7mH-xD+eesJNjhpFwUSeMwGCdsRK8Q9AZSjmE2uw=cBgsw@mail.gmail.com>
 <557AD18D.8010807@optusnet.com.au>
 <CAOpc7mG5nD1daKSkGdqoR84=W_A11s+oQfzc_i4pUsHoVd42Tw@mail.gmail.com>
 <557C4C83.3020501@optusnet.com.au>
 <CAOpc7mHYiX3SAJSEHM32PA1gRFA+BQ0DxCC3U6Aux15Swy06sQ@mail.gmail.com>
 <557CEA2E.5060904@optusnet.com.au>
 <CAOpc7mGxpjUoV1iMcU0CAfaPYf0z-9ZjHgenH+ocSdBykfnutA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hSqsA1gkc7m6tOH1EwSpE8w4CwSm70riE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40312 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbbFVNQD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 22 Jun 2015 09:16:03 -0400
In-Reply-To: <CAOpc7mGxpjUoV1iMcU0CAfaPYf0z-9ZjHgenH+ocSdBykfnutA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Holger Schurig <holgerschurig@gmail.com>, Tom Evans <tom_usenet@optusnet.com.au>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hSqsA1gkc7m6tOH1EwSpE8w4CwSm70riE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/22/2015 02:17 PM, Holger Schurig wrote:
> Just a little feedback. Tom sent me his flexcan-ringbuffer patch. I
> modified this patch to use not a self-written ringbuffer, but kfifo.
> If someone wants it, I can post that here. However, this only helped a
> little bit.

Please post it here.

Thanks,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hSqsA1gkc7m6tOH1EwSpE8w4CwSm70riE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJViAqKAAoJEP5prqPJtc/He8EIAL+2r6v8dn+lb5KLctrYj5fZ
gN2NtmV5NRNlEpK+UUsAKCTqW63g8J5RNJAq9Ysm206eRq9CxYheeWEqgW75+VKg
IYF1DNmYsosABcsBR5ikUfj4cVbVeBTo6IxhPTgTh9k3/3XCgTmjOWwVJTShs9jC
X/PvSx6DtN9ShoM3fplrPu9j0lnnGiJ/oJfYOEIyc1XPIMVyTWO9FszXQNAFf3pI
5xiED/hwhWH2EtJ9vwvJS7k+9WRl4C2V6oILsyBUT0nmY1HGuw/GMN/x7qpbtMFU
PsK0L1QBIeQ/xe2ZNdBHMSq2Ws58POX2vCEdFyaXYDs3cDRKwWJzYLB4Z3LeKfg=
=7g2I
-----END PGP SIGNATURE-----

--hSqsA1gkc7m6tOH1EwSpE8w4CwSm70riE--
--
To unsubscribe from this list: send the line "unsubscribe linux-can" in
