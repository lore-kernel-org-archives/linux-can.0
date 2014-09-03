From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: RFC: [PATCH v2 1/2] can: flexcan: Correctly initialize mailboxes
Date: Wed, 03 Sep 2014 16:36:45 +0200
Message-ID: <5407277D.7060802@pengutronix.de>
References: <1409670216-25674-1-git-send-email-mkl@pengutronix.de>	<1409670216-25674-2-git-send-email-mkl@pengutronix.de> <20140903163424.60f72a00@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hMAihMQ4NT6iCsEes3iCns4qQ8vf8S9FT"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37917 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932402AbaICOgx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Sep 2014 10:36:53 -0400
In-Reply-To: <20140903163424.60f72a00@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hMAihMQ4NT6iCsEes3iCns4qQ8vf8S9FT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/03/2014 04:34 PM, David Jander wrote:
> On Tue,  2 Sep 2014 17:03:35 +0200
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
>> From: David Jander <david@protonic.nl>
>>
>> Apparently mailboxes may contain random data at startup, causing some =
of
>> them being prepared for message reception. This causes overruns being
>> missed or even confusing the IRQ check for trasmitted messages, increa=
sing
>> the transmit counter instead of the error counter.
>>
>> Signed-off-by: David Jander <david@protonic.nl>
>> [mkl: adjust starting value of loop]
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Changes since v1:
>> - don't remove existing initialization of FLEXCAN_TX_BUF_ID
>> - start loop at FLEXCAN_TX_BUF_ID + 1
>>
>> Marc
>>
>>  drivers/net/can/flexcan.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>> index 630c7bf..6ec49bd 100644
>> --- a/drivers/net/can/flexcan.c
>> +++ b/drivers/net/can/flexcan.c
>> @@ -801,6 +801,7 @@ static int flexcan_chip_start(struct net_device *d=
ev)
>>  	struct flexcan_regs __iomem *regs =3D priv->base;
>>  	int err;
>>  	u32 reg_mcr, reg_ctrl;
>> +	int i;
>> =20
>>  	/* enable module */
>>  	err =3D flexcan_chip_enable(priv);
>> @@ -870,6 +871,11 @@ static int flexcan_chip_start(struct net_device *=
dev)
>>  	/* Abort any pending TX, mark Mailbox as INACTIVE */
>>  	flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
>>  		      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
>> +	/* Clear and invalidate all mailboxes first */
>> +	for (i =3D FLEXCAN_TX_BUF_ID + 1; i < ARRAY_SIZE(regs->cantxfg; i++)=
 {
>=20
> Oops! You are missing a closing parenthesis in this line.
> I will assume you amend this commit and base mine on top of that...

Doh! I introduced this problem, when converting the 64 to
ARRAY_SIZE(...without the closing ).

Fixed.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hMAihMQ4NT6iCsEes3iCns4qQ8vf8S9FT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQHJ30ACgkQjTAFq1RaXHOVMQCdHFZ2sMj66ryfJ/iZRWxE81aN
lqEAoIyZHRtrjHY5wOPKUJ8HiMjdqi/P
=snfe
-----END PGP SIGNATURE-----

--hMAihMQ4NT6iCsEes3iCns4qQ8vf8S9FT--
