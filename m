From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue
 instead of FIFO
Date: Mon, 06 Oct 2014 12:00:03 +0200
Message-ID: <54326823.7030000@pengutronix.de>
References: <1411995175-13540-1-git-send-email-david@protonic.nl>	<4712537.n1vM034J9B@ws-stein>	<20141001110741.0e8e5ffb@archvile>	<5856354.jaFqUxgnZF@ws-stein>	<20141001113432.18ec8bed@archvile>	<542BD038.2070106@pengutronix.de> <20141006092825.765bd50d@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fS0fOFf2A6wSxxjqVaT1I3mGp9i6PhaKL"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60448 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbaJFKAP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Oct 2014 06:00:15 -0400
In-Reply-To: <20141006092825.765bd50d@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fS0fOFf2A6wSxxjqVaT1I3mGp9i6PhaKL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/06/2014 09:28 AM, David Jander wrote:
>>> 2.- Since the problem addressed by my patch to at91_can is very simil=
ar,
>>> what about solving these problems in the SocketCAN framework (if that=
 is
>>> possible)?
>>
>> Have you had a look at my rx-fifo branch in
>> https://gitorious.org/linux-can/linux-can-next? It already tries to
>> abstract the simulation of the FIFO with the linear mailboxes.
>=20
> Looks interesting. I think it is a good idea to do this in dev.c, since=
 there
> are obviously more CAN drivers that can use this. Unfortunately it seem=
s you
> are still pretending the napi-poll handler to call can_rx_fifo_poll().
> Wouldn't it be better to just empty all MBs into a circular buffer or k=
fifo
> from the interrupt handler instead?

Yes probably, I started the rx-fifo patch before you came up with that id=
ea.

> I still don't understand the results Alexander is getting, though....
>=20
> What are you going to do with the rx-fifo work? Do you recommend to bas=
e my
> patch on that? In that case, calling can_rx_fifo_poll() from the interr=
upt
> handler will look a little awkward... but it should work. Or should I p=
ropose
> an extension to rx-fifo?

My plans, or rather the points that need to be addressed for the rx-fifo
are:
- improve to work with more than 32 mailboxes. 64 are probably enough
  for everybody :)
- make it work with the flexcan linear buffers
- make it work with the ti_hecc driver
- add option or convert to run from interrupt handler and copy to
  kfifo/cyclic buffer/...

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--fS0fOFf2A6wSxxjqVaT1I3mGp9i6PhaKL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQyaCMACgkQjTAFq1RaXHNzgwCdH2REvz6ri8R+UmWufpbMoDE5
GVUAoJYXexDVhlhy/wsctjhKcv+wss0g
=T9xs
-----END PGP SIGNATURE-----

--fS0fOFf2A6wSxxjqVaT1I3mGp9i6PhaKL--
