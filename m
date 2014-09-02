From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: flexcan.c: Correctly initialize mailboxes
Date: Tue, 02 Sep 2014 15:54:06 +0200
Message-ID: <5405CBFE.5070207@pengutronix.de>
References: <1409133487-23367-1-git-send-email-david@protonic.nl>	<1409133487-23367-2-git-send-email-david@protonic.nl>	<54059ADC.60309@pengutronix.de>	<20140902123725.01808f36@archvile>	<5405A31E.1060403@pengutronix.de> <20140902131543.13b7268b@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="d6V8PU2us1jJbSF0jTAk7QJW4tnTUCGLN"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49646 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972AbaIBNyJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Sep 2014 09:54:09 -0400
In-Reply-To: <20140902131543.13b7268b@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: wg@grandegger.com, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d6V8PU2us1jJbSF0jTAk7QJW4tnTUCGLN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/02/2014 01:15 PM, David Jander wrote:

>> Yes, 0d1862e was not complete, the initialisation was fixes with:
>>
>> d5a7b40 can: flexcan: flexcan_chip_start: fix regression,
>>                        mark one MB for TX and abort pending TX
>>
>> Which sets FLEXCAN_MCR_MAXMB to 8, which is the only mailbox used for =
tx
>> and the code of the tx mailbox is set to 0x4 =3D=3D tx, inactive.
>>
>> This should be enough in FIFO mode, correct?
>=20
> AFAICS not. There could still be other MB's with reception or transmiss=
ion
> enabled (randomly) causing potential data loss, extra frames sent and/o=
r errors
> in the statistics.

> If the FIFO is full for example it should overflow with the next messag=
e, but
> if the next message instead hits an (randomly) empty and readied RX MB
> somewhere, the overflow is undetected and one (or more) frame(s) is los=
t.

Is FIFO to normal mailbox overflow a new feature of the imx6 flexcan
core? The mx35 data sheet states:

> If the FIFO is full and more frames continue to be received, an
> OVERFLOW interrupt is issued to the ARM and subsequent frames are not
> accepted until the ARM creates space in the FIFO by reading one or
> more frames.

While the mx6 states:

> Note that the flag will not be asserted when the Rx FIFO is
> full and the message was captured by a Mailbox.

But later in the imx35:

> In the event that the FIFO is full, the matching algorithm always
> looks for a matching message buffer outside the FIFO region.

This probably means even on the mx35 the _FIFO_ does not accept any more
message if it's full, but the other mailboxes may....

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--d6V8PU2us1jJbSF0jTAk7QJW4tnTUCGLN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQFy/4ACgkQjTAFq1RaXHNOaQCgkp7hi+2x2ULqfBCQRm88e7yE
Vp4An0GRO3/hyBl0KzFb0nzQqoMd5Z+t
=d4lV
-----END PGP SIGNATURE-----

--d6V8PU2us1jJbSF0jTAk7QJW4tnTUCGLN--
