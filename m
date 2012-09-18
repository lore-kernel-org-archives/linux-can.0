From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: sja1000: Add support for listen-only mode and one-shot
 mode
Date: Tue, 18 Sep 2012 18:20:40 +0200
Message-ID: <50589F58.8020804@pengutronix.de>
References: <1347897482-26379-1-git-send-email-andreas@gaisler.com> <50587B46.7060506@pengutronix.de> <50588115.8070907@grandegger.com> <5058994E.8000501@gaisler.com> <20120918161603.GC12449@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig14FDAF99D5BC428DD519BF90"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34581 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab2IRQU6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 12:20:58 -0400
In-Reply-To: <20120918161603.GC12449@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: Andreas Larsson <andreas@gaisler.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, software@gaisler.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig14FDAF99D5BC428DD519BF90
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/18/2012 06:16 PM, Ira W. Snyder wrote:
[...]

>>> The commit message is incomplete and confusing, I agree. The patch
>>> obviously implements listen-only and one-shot mode. From the data she=
et:
>>>
>>> LOM FUNCTION:
>>>    1: listen only; in this mode the CAN controller would
>>>    give no acknowledge to the CAN-bus, even if a message is received
>>>    successfully; the error counters are stopped at the current value
>>>    normal
>>>
>>> Single-shot:
>>>    Setting the command bits CMR.0 (TR) and CMR.1 (AT) simultaneously
>>>    results in sending the transmit message once. No re-transmission w=
ill
>>>    be performed in the event of an error or arbitration lost
>>>    (single-shot transmission).
>>
>> The limitation is that when a one-shot message transmission fails, a=20
>> Transmit Interrupt is generated and as a consequence can_get_echo_skb =
is=20
>> called. Thus a can frame is echoed back even when the transmission fai=
ls=20

The question is, can you identify somehow if the message has been
transmitted successfully or not.

>> (instead of being discarded). When one-shot mode is enabled no other=20
>> interrupts are generated on a failed transmission. Thus, as far as I c=
an=20
>> see, there is no way for the failed frames not to be echoed back local=
ly=20
>> in this case.

> I worked around this limitation in the janz-ican3 driver by writing my
> own version of the can_put_echo_skb() and can_get_echo_skb() functions.=

> Also notice the skb_dequeue() in ican3_handle_cevtind(), which handles
> the transmission failure case.
>=20
> It is probably possible to modify the SJA1000 driver to do something
> similar.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig14FDAF99D5BC428DD519BF90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBYn1wACgkQjTAFq1RaXHNGQwCgmcG0SaOkRnj3YplwdOfGqmdL
otMAn3wtR5jKdBZYzzkTCALOXQo6+Yx6
=n12H
-----END PGP SIGNATURE-----

--------------enig14FDAF99D5BC428DD519BF90--
