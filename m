From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Flexcan (was: Re: Fwd: Querying current tx_queue usage of a
 SocketCAN interface)
Date: Thu, 02 Apr 2015 08:28:04 +0200
Message-ID: <551CE174.2030303@pengutronix.de>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>	<55187FF1.7020701@optusnet.com.au>	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>	<5519E5A9.7080104@optusnet.com.au>	<CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>	<551A0FF3.4070400@optusnet.com.au> <CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com> <551C7D79.50906@optusnet.com.au> <loom.20150402T022922-646@post.gmane.org> <551CA777.8070208@optusnet.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="oEaplHMBL3eM52wEqARXs3AITBqG0Aaib"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35236 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbbDBG2S (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Apr 2015 02:28:18 -0400
In-Reply-To: <551CA777.8070208@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tom_usenet@optusnet.com.au, Dan Egnor <dan.egnor@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oEaplHMBL3eM52wEqARXs3AITBqG0Aaib
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/02/2015 04:20 AM, Tom Evans wrote:
> I had to seriously rewrite the FlexCAN drivers for our i.MX53 because t=
he=20
> Ethernet driver blocked the CAN driver for so long the CAN hardware rec=
eive=20
> FIFO overflowed. Linux doesn't even support setting different interrupt=
=20
> priorities on ARM (but my problem was with NAPI).

Can you share your changes? I'll have some days to hack on a better
generic RX-FIFO implementation for the at91 and flexcan.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--oEaplHMBL3eM52wEqARXs3AITBqG0Aaib
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVHOF3AAoJECte4hHFiupUCO0P/ia3lwOIwQR6LAivYOfGnpWu
0bJPGfQBnV/i0Ywm8jUmP/rtYUPWCXoVJA2BnIwxaSshSKdbaafbqAI/cwRz4JBf
LZozrmWmBVqnbHjKcQbu7d8BNIkmsIUrtYFJMq3XrbEIlM75w5HnD+Fu2u7VhfnD
jp/0bkEqG2jUXj+W1ki1PbZYcRZJkkIRV+PQjNhnUHhVuZfNUO4NqVpN20V+MPHB
zWxiqA6J46wWlnC55QKWSFJL+IxtKz2z4KjXwn6KA/YCwUFcLautG2+AUGnOmZA5
j2hyBqy/kRN/p+nz8COg2WRyg3q24BoEpZ0sDNG/tAool0OO5o9yK5Zgt/kMVy5m
V+lnr5oVgBfzo0Gv/KPIBJ4XRsmGfDlEGKK5EHDMN1KsXtgkP1gtlGtyhrX7+w6A
YPV3kel0E6rRgnXUNoy7c9A9fC9mc2wHttfrsAYq+km6qfo+Z+vJSA8vA4Poa1B7
nr2ofLjEwtMnFwfxqpZY4WdwVYfEmzly6i58DkBTkkW2sOJ2iACtFDMWKKrCtohE
kyMsDCpEjgTW/ca2ApWniN48fBLJ9UvLymak730vf0pfCgCRqkwBtvJtFVFrkukE
eR1SjcH4vfSEVzY9mTHtkksOKMifL2P3u9ud3SPtbw83WyY/4gle98IO5d4e0wJu
WfmeEIMde01q9IZup2Ag
=3kKp
-----END PGP SIGNATURE-----

--oEaplHMBL3eM52wEqARXs3AITBqG0Aaib--
