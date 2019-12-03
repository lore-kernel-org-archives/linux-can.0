From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V2 1/4] can: flexcan: fix deadlock when using self wakeup
Date: Tue, 3 Dec 2019 18:25:08 +0100
Message-ID: <b77829d5-9eda-a244-3ee8-2ccdbdfb6524@pengutronix.de>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-2-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PKayGHV2gg8Z94eZQ1tNw1WwQqsSV4IO3"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191127055334.1476-2-qiangqing.zhang@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com" <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PKayGHV2gg8Z94eZQ1tNw1WwQqsSV4IO3
Content-Type: multipart/mixed; boundary="Nv7MMgsx683NBRKaM98Gg11Sfx4N7sx65";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com"
 <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <b77829d5-9eda-a244-3ee8-2ccdbdfb6524@pengutronix.de>
Subject: Re: [PATCH V2 1/4] can: flexcan: fix deadlock when using self wakeup
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-2-qiangqing.zhang@nxp.com>
In-Reply-To: <20191127055334.1476-2-qiangqing.zhang@nxp.com>

--Nv7MMgsx683NBRKaM98Gg11Sfx4N7sx65
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/27/19 6:56 AM, Joakim Zhang wrote:
> From: Sean Nyekjaer <sean@geanix.com>
>=20
> When suspending, when there is still can traffic on the interfaces the
> flexcan immediately wakes the platform again. As it should :-). But it
> throws this error msg:
> [ 3169.378661] PM: noirq suspend of devices failed
>=20
> On the way down to suspend the interface that throws the error message =
does
> call flexcan_suspend but fails to call flexcan_noirq_suspend. That mean=
s the
> flexcan_enter_stop_mode is called, but on the way out of suspend the dr=
iver
> only calls flexcan_resume and skips flexcan_noirq_resume, thus it doesn=
't call
> flexcan_exit_stop_mode. This leaves the flexcan in stop mode, and with =
the
> current driver it can't recover from this even with a soft reboot, it r=
equires
> a hard reboot.
>=20
> This patch can fix deadlock when using self wakeup, it happenes to be
> able to fix another issue that frames out-of-order in first IRQ handler=

> run after wakeup.
>=20
> In wakeup case, after system resume, frames received out-of-order in
> first IRQ handler, the problem is wakeup latency from frame reception t=
o
> IRQ handler is much bigger than the counter overflow. This means it's
> impossible to sort the CAN frames by timestamp. The reason is that cont=
roller
> exits stop mode during noirq resume, then it can receive the frame imme=
diately.
> If noirq reusme stage consumes much time, it will extend interrupt resp=
onse
> time. So exit stop mode during resume stage instead of noirq resume can=

> fix this issue.
>=20
> Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ------
> ChangeLog:
> 	V1->V2: no change.
> ---
>  drivers/net/can/flexcan.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 2efa06119f68..2297663cacb2 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -134,8 +134,7 @@
>  	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)
>  #define FLEXCAN_ESR_ALL_INT \
>  	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
> -	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
> -	 FLEXCAN_ESR_WAK_INT)
> +	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)

Why do you remove the FLEXCAN_ESR_WAK_INT from the FLEXCAN_ESR_ALL_INT?

> =20
>  /* FLEXCAN interrupt flag register (IFLAG) bits */
>  /* Errata ERR005829 step7: Reserve first valid MB */
> @@ -960,6 +959,12 @@ static irqreturn_t flexcan_irq(int irq, void *dev_=
id)
> =20
>  	reg_esr =3D priv->read(&regs->esr);
> =20
> +	/* ACK wakeup interrupt */
> +	if (reg_esr & FLEXCAN_ESR_WAK_INT) {
> +		handled =3D IRQ_HANDLED;
> +		priv->write(reg_esr & FLEXCAN_ESR_WAK_INT, &regs->esr);
> +	}
> +

If FLEXCAN_ESR_WAK_INT stays in FLEXCAN_ESR_ALL_INT, you don't need that
explicit ACK here.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--Nv7MMgsx683NBRKaM98Gg11Sfx4N7sx65--

--PKayGHV2gg8Z94eZQ1tNw1WwQqsSV4IO3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3mmnQACgkQWsYho5Hk
nSDGqwf+NGmScvoOPWrugXTvRo95qR0IXLvwNrC6qoiajnIfD4uNT5+u/Yo1JnA4
qiSN6RNzgrRKxC55ko4D6kGlLKFMEk+bhyU/dnj51C8b+1xmn/2K557uxy5ZJOu+
yHT0xaB6aC3GMXLrmsPHWVmAkjgyOlsebxYyIwyPMRR1i0bGLSNsVuaePwS3pt5x
xbkY1i+A8DI177Tzymmrqm7vNcS4X39xCFt4OCs/rluNsF5sW14ryg6RrZKfX47b
urRa7aPawe9M8phgxcJSrxEWNzCUZvXmS3jUSCEr+TgRIHu99eLTw3/fisOlOtys
2MFm6TC1jdQkLmDM7580EHtlo/P74A==
=CRL3
-----END PGP SIGNATURE-----

--PKayGHV2gg8Z94eZQ1tNw1WwQqsSV4IO3--
