From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V2 1/4] can: flexcan: fix deadlock when using self wakeup
Date: Tue, 3 Dec 2019 18:42:16 +0100
Message-ID: <cad4be61-b409-093a-9f05-9de691bc4a10@pengutronix.de>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-2-qiangqing.zhang@nxp.com>
 <b77829d5-9eda-a244-3ee8-2ccdbdfb6524@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ZdprwuE3cNf2makzjCF94lWLWaF8l5zOZ"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <b77829d5-9eda-a244-3ee8-2ccdbdfb6524@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com" <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZdprwuE3cNf2makzjCF94lWLWaF8l5zOZ
Content-Type: multipart/mixed; boundary="rXgueoG2aS9fXa7QTPleYh8Uui2FgnUQM";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com"
 <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <cad4be61-b409-093a-9f05-9de691bc4a10@pengutronix.de>
Subject: Re: [PATCH V2 1/4] can: flexcan: fix deadlock when using self wakeup
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-2-qiangqing.zhang@nxp.com>
 <b77829d5-9eda-a244-3ee8-2ccdbdfb6524@pengutronix.de>
In-Reply-To: <b77829d5-9eda-a244-3ee8-2ccdbdfb6524@pengutronix.de>

--rXgueoG2aS9fXa7QTPleYh8Uui2FgnUQM
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 12/3/19 6:25 PM, Marc Kleine-Budde wrote:
> On 11/27/19 6:56 AM, Joakim Zhang wrote:
>> From: Sean Nyekjaer <sean@geanix.com>
>>
>> When suspending, when there is still can traffic on the interfaces the=

>> flexcan immediately wakes the platform again. As it should :-). But it=

>> throws this error msg:
>> [ 3169.378661] PM: noirq suspend of devices failed
>>
>> On the way down to suspend the interface that throws the error message=
 does
>> call flexcan_suspend but fails to call flexcan_noirq_suspend. That mea=
ns the
>> flexcan_enter_stop_mode is called, but on the way out of suspend the d=
river
>> only calls flexcan_resume and skips flexcan_noirq_resume, thus it does=
n't call
>> flexcan_exit_stop_mode. This leaves the flexcan in stop mode, and with=
 the
>> current driver it can't recover from this even with a soft reboot, it =
requires
>> a hard reboot.
>>
>> This patch can fix deadlock when using self wakeup, it happenes to be
>> able to fix another issue that frames out-of-order in first IRQ handle=
r
>> run after wakeup.
>>
>> In wakeup case, after system resume, frames received out-of-order in
>> first IRQ handler, the problem is wakeup latency from frame reception =
to
>> IRQ handler is much bigger than the counter overflow. This means it's
>> impossible to sort the CAN frames by timestamp. The reason is that con=
troller
>> exits stop mode during noirq resume, then it can receive the frame imm=
ediately.
>> If noirq reusme stage consumes much time, it will extend interrupt res=
ponse
>> time. So exit stop mode during resume stage instead of noirq resume ca=
n
>> fix this issue.
>>
>> Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
>> ------
>> ChangeLog:
>> 	V1->V2: no change.
>> ---
>>  drivers/net/can/flexcan.c | 19 +++++++++++--------
>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>> index 2efa06119f68..2297663cacb2 100644
>> --- a/drivers/net/can/flexcan.c
>> +++ b/drivers/net/can/flexcan.c
>> @@ -134,8 +134,7 @@
>>  	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)
>>  #define FLEXCAN_ESR_ALL_INT \
>>  	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
>> -	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
>> -	 FLEXCAN_ESR_WAK_INT)
>> +	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
>=20
> Why do you remove the FLEXCAN_ESR_WAK_INT from the FLEXCAN_ESR_ALL_INT?=

>=20
>> =20
>>  /* FLEXCAN interrupt flag register (IFLAG) bits */
>>  /* Errata ERR005829 step7: Reserve first valid MB */
>> @@ -960,6 +959,12 @@ static irqreturn_t flexcan_irq(int irq, void *dev=
_id)
>> =20
>>  	reg_esr =3D priv->read(&regs->esr);
>> =20
>> +	/* ACK wakeup interrupt */
>> +	if (reg_esr & FLEXCAN_ESR_WAK_INT) {
>> +		handled =3D IRQ_HANDLED;
>> +		priv->write(reg_esr & FLEXCAN_ESR_WAK_INT, &regs->esr);
>> +	}
>> +
>=20
> If FLEXCAN_ESR_WAK_INT stays in FLEXCAN_ESR_ALL_INT, you don't need tha=
t
> explicit ACK here.

Otherwise this patch is OK. With this patch the flexcan_suspend() and
flexcan_resume() look finally symmetric. \o/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--rXgueoG2aS9fXa7QTPleYh8Uui2FgnUQM--

--ZdprwuE3cNf2makzjCF94lWLWaF8l5zOZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3mnngACgkQWsYho5Hk
nSCbbAf9GTNY32FjDHxCFGnQ2gEBruslKHFI/9nxoXsH5SLr1gcj766MWXGsJXYO
6QpXSNpjedsL5jxeyZbDCWY2nyZeg4jYFKf5zPbH5HoOaWziVqyi+HgmJA2V2kqS
PnEqbE4pr9h3RyKB8IfUZ9PLjUH6SHWbl8EsLKhwJ+uWJh0TgUZ0b3aJz4lJEflB
am3djIVh+vu2xmY6KwgZ54uTSV8QCJEuXlfZ4sR00+SqndpbfnKuKXt0b4wSQdbR
Fc2n1JCwY4OUYYa9uDmEr24VP9eS5qpjIB1iztxjA8A3LLagRGWqmH9ZyvCoQpuy
RlTUlW9gXDYrEoeZexkxVu7rjaEs7w==
=3CZG
-----END PGP SIGNATURE-----

--ZdprwuE3cNf2makzjCF94lWLWaF8l5zOZ--
