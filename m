From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4] can: flexcan: Re-write receive path to use MB queue
 instead of FIFO
Date: Tue, 23 Sep 2014 15:34:35 +0200
Message-ID: <542176EB.6050308@pengutronix.de>
References: <1411048090-16837-1-git-send-email-david@protonic.nl> <54216E5F.2010804@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="0QN6iHPAxFngUHDf3pGKRX3wXueSac0js"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33007 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbaIWNen (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 23 Sep 2014 09:34:43 -0400
In-Reply-To: <54216E5F.2010804@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0QN6iHPAxFngUHDf3pGKRX3wXueSac0js
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/23/2014 02:58 PM, Marc Kleine-Budde wrote:
> On 09/18/2014 03:48 PM, David Jander wrote:
>> > The FlexCAN controller has a RX FIFO that is only 6 messages deep, a=
nd a
>> > mailbox space capable of holding up to 63 messages.
>> > This space was largely unused, limiting the permissible latency from=

>> > interrupt to NAPI to only 6 messages. This patch uses all available =
MBs
>> > for message reception and frees the MBs in the IRQ handler to greatl=
y
>> > decrease the likelihood of receive overruns.
>> >=20
>> > Signed-off-by: David Jander <david@protonic.nl>
> I think we can improve the algorithm a bit.
>=20
> I see a problem when you receive 4 CAN frames:
>=20
> 0-1-2-3
>=20
> then the irq handler starts, 0 gets processed and is empty (E)
>=20
> E-1-2-3
>=20
> while in the interrupt handler another two frames come in:
>=20
> 4-1-2-3-5
>=20
> I suggest add a variable to the priv which indicates the next MB to rea=
d
> from. Further, don't clear the mailbox direclty after it's been read,
> wait until a certain amount of read mailboxes accumulate, .e.g. when th=
e
> rx_next point to 32. I have a work-in-progress code which to abstract
> this algorithm, but it limited to 32 mailboxes. It should work on the
> at91 but I don't know if it's flexible enought yet to work on the
> flexcan, too.

For the algorithm see the rx-fifo branch on linux-can-next. Feel free to
comment.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--0QN6iHPAxFngUHDf3pGKRX3wXueSac0js
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQhdusACgkQjTAFq1RaXHMO0gCfWv/iCXiwn3HaW7rhmOnMo14r
kywAoJJIcWzkSfcX8K6g4T6g1WqkUI29
=QlyJ
-----END PGP SIGNATURE-----

--0QN6iHPAxFngUHDf3pGKRX3wXueSac0js--
