From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V2 1/4] can: flexcan: fix deadlock when using self wakeup
Date: Wed, 4 Dec 2019 09:31:05 +0100
Message-ID: <b4ce5a7a-7fc0-edb2-608e-4030ce6428a2@pengutronix.de>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-2-qiangqing.zhang@nxp.com>
 <b77829d5-9eda-a244-3ee8-2ccdbdfb6524@pengutronix.de>
 <DB7PR04MB46183730127339DAC15ABF33E65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gNfDjcm1x9HHDAIkEGdoHJkH587wTN8L3"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB46183730127339DAC15ABF33E65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com" <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gNfDjcm1x9HHDAIkEGdoHJkH587wTN8L3
Content-Type: multipart/mixed; boundary="RsU4ZEJsDnWk1wNwXlT3btpEzfioQ0U3D";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com"
 <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <b4ce5a7a-7fc0-edb2-608e-4030ce6428a2@pengutronix.de>
Subject: Re: [PATCH V2 1/4] can: flexcan: fix deadlock when using self wakeup
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-2-qiangqing.zhang@nxp.com>
 <b77829d5-9eda-a244-3ee8-2ccdbdfb6524@pengutronix.de>
 <DB7PR04MB46183730127339DAC15ABF33E65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB46183730127339DAC15ABF33E65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>

--RsU4ZEJsDnWk1wNwXlT3btpEzfioQ0U3D
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/4/19 2:58 AM, Joakim Zhang wrote:
> [...]
>>>  drivers/net/can/flexcan.c | 19 +++++++++++--------
>>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>>> index 2efa06119f68..2297663cacb2 100644
>>> --- a/drivers/net/can/flexcan.c
>>> +++ b/drivers/net/can/flexcan.c
>>> @@ -134,8 +134,7 @@
>>>  	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)  #define
>>> FLEXCAN_ESR_ALL_INT \
>>>  	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
>>> -	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
>>> -	 FLEXCAN_ESR_WAK_INT)
>>> +	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
>>
>> Why do you remove the FLEXCAN_ESR_WAK_INT from the
>> FLEXCAN_ESR_ALL_INT?
>>
>>>
>>>  /* FLEXCAN interrupt flag register (IFLAG) bits */
>>>  /* Errata ERR005829 step7: Reserve first valid MB */ @@ -960,6
>>> +959,12 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>>>
>>>  	reg_esr =3D priv->read(&regs->esr);
>>>
>>> +	/* ACK wakeup interrupt */
>>> +	if (reg_esr & FLEXCAN_ESR_WAK_INT) {
>>> +		handled =3D IRQ_HANDLED;
>>> +		priv->write(reg_esr & FLEXCAN_ESR_WAK_INT, &regs->esr);
>>> +	}
>>> +
>>
>> If FLEXCAN_ESR_WAK_INT stays in FLEXCAN_ESR_ALL_INT, you don't need
>> that explicit ACK here.
>=20
> Hi Marc,
>=20
> I remove the FLEXCAN_ESR_WAK_INT from the FLEXCAN_ESR_ALL_INT since
> FLEXCAN_ESR_ALL_INT is for all bus error and state change IRQ
> sources, wakeup interrupt does not belong to these. If you think this
> does not need, I can remove this change.

I see, makes sense.

Make this a separate patch. Move the FLEXCAN_ESR_WAK_INT from the
FLEXCAN_ESR_ALL_INT, but add it to the existing ack of the interrupts.
Like this:

> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index b6f675a5e2d9..74f622b40b61 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -960,10 +960,10 @@ static irqreturn_t flexcan_irq(int irq, void *dev=
_id)
> =20
>         reg_esr =3D priv->read(&regs->esr);
> =20
> -       /* ACK all bus error and state change IRQ sources */
> -       if (reg_esr & FLEXCAN_ESR_ALL_INT) {
> +       /* ACK all bus error, state change and wake IRQ sources */
> +       if (reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT)) {
>                 handled =3D IRQ_HANDLED;
> -               priv->write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);=

> +               priv->write(reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ES=
R_WAK_INT), &regs->esr);
>         }
> =20
>         /* state change interrupt or broken error state quirk fix is en=
abled */

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--RsU4ZEJsDnWk1wNwXlT3btpEzfioQ0U3D--

--gNfDjcm1x9HHDAIkEGdoHJkH587wTN8L3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3nbskACgkQWsYho5Hk
nSCM+Qf+O704RSvmyOPEQZDym+oL1w3DRt7iDaIrOET+5giecvKBt+xRX2ogTzqI
BQnYlT4wf40FNlEi62/TJ3EBLEQS8FBH54hEtofn+JKm0yyf3ITpO/xSX0sGqr/+
gC7a8eWCCo6Ypmdtw7kELWiKANXDmgd2RQMXLxwMKMiEa99DPrh/Bxf0kjZ/cVfm
ptkQxARsOVxii03vlwA7w86bkHRLU15XZVhDMuXnI5YRTdL0+z85BR6lzW3CPFR3
XifJ3jlWnDLh4g8BUG6OsJHhoj8HMuC0El2vcVTKEJBx6MUYvpU5Csl8AvbNmAAi
MRTSL0LuB9cuQMCvPv55PY1+NRsBTg==
=5XGv
-----END PGP SIGNATURE-----

--gNfDjcm1x9HHDAIkEGdoHJkH587wTN8L3--
