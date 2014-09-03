From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: RFC: [PATCH v2 1/2] can: flexcan: Correctly initialize mailboxes
Date: Wed, 03 Sep 2014 11:18:22 +0200
Message-ID: <5406DCDE.6000404@pengutronix.de>
References: <1409670216-25674-1-git-send-email-mkl@pengutronix.de>	<1409670216-25674-2-git-send-email-mkl@pengutronix.de> <20140903085856.3a7e1e9a@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Eb5tMbw8vWtfxOspTaDKWho5AtaNCHbGo"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52111 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbaICJYK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Sep 2014 05:24:10 -0400
In-Reply-To: <20140903085856.3a7e1e9a@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Eb5tMbw8vWtfxOspTaDKWho5AtaNCHbGo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/03/2014 08:58 AM, David Jander wrote:
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
>> +		flexcan_write(FLEXCAN_MB_CNT_CODE(0),
>> +		      &regs->cantxfg[i].can_ctrl);
>> +	}
>> =20
>>  	/* acceptance mask/acceptance code (accept everything) */
>>  	flexcan_write(0x0, &regs->rxgmask);
>=20
> This assumes that FLEXCAN_TX_BUF_ID is the ID of the first available MB=
=2E Other
> than that, it should work I believe.
> OTOH, since this loop is more like a memset(...0...), wouldn't it be ni=
ce to
> just clear all MB's CODE registers and then initialize TX_BUF (and othe=
rs)
> afterwards?

See patch v3, I've changed the order, first do the loop, then initialize
FLEXCAN_TX_BUF_ID as 0x4. I've pushed this series to the testing branch
of the linux-can repo on gitorious. Make your imx6 errata fix patch
based on this branch.

You probably have to change FLEXCAN_TX_BUF_ID and/or introduce a new
define for the invalid mailbox. When your patch is ready we can look at
the patches and see if it makes sense to shuffle some changes around.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Eb5tMbw8vWtfxOspTaDKWho5AtaNCHbGo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQG3N4ACgkQjTAFq1RaXHN3iACfR7mcRGnHwye6PUDGmhjHWRbY
lgwAn1f/Wz5cgRA/VJpPMwTFxMPfEneB
=0u9T
-----END PGP SIGNATURE-----

--Eb5tMbw8vWtfxOspTaDKWho5AtaNCHbGo--
