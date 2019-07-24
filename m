From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ti_hecc: use timestamp based rx-offloading
Date: Wed, 24 Jul 2019 10:26:02 +0200
Message-ID: <5881cb80-883b-a96b-2939-973150cfc196@pengutronix.de>
References: <1556539376-20932-1-git-send-email-jhofstee@victronenergy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0TGN2duKhCYiG04TA8avalkRqpNrVCmIu"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556539376-20932-1-git-send-email-jhofstee@victronenergy.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeroen Hofstee <jhofstee@victronenergy.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Anant Gole <anantgole@ti.com>, AnilKumar Ch <anilkumar@ti.com>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0TGN2duKhCYiG04TA8avalkRqpNrVCmIu
Content-Type: multipart/mixed; boundary="wOe0gYcUEepxQHwDfsJDd7ZqTtKeTJmc8";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jeroen Hofstee <jhofstee@victronenergy.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Anant Gole <anantgole@ti.com>, AnilKumar Ch <anilkumar@ti.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Message-ID: <5881cb80-883b-a96b-2939-973150cfc196@pengutronix.de>
Subject: Re: [PATCH] can: ti_hecc: use timestamp based rx-offloading
References: <1556539376-20932-1-git-send-email-jhofstee@victronenergy.com>
In-Reply-To: <1556539376-20932-1-git-send-email-jhofstee@victronenergy.com>

--wOe0gYcUEepxQHwDfsJDd7ZqTtKeTJmc8
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 4/29/19 2:03 PM, Jeroen Hofstee wrote:
> As already mentioned in [1] and included in [2], there is an off by one=

> issue since the high bank is already enabled when the _next_ mailbox to=

> be read has index 12, so the mailbox being read was 13. The message can=

> therefore go into mailbox 31 and the driver will be repolled until the
> mailbox 12 eventually receives a msg. Or the message might end up in th=
e
> 12th mailbox, but then it would become disabled after reading it and on=
ly
> be enabled again in the next "round" after mailbox 13 was read, which c=
an
> cause out of order messages, since the lower priority mailboxes can
> accept messages in the meantime.
>=20
> As mentioned in [3] there is a hardware race condition when changing th=
e
> CANME register while messages are being received. Even when including a=

> busy poll on reception, like in [2] there are still overflows and out o=
f
> order messages at times, but less then without the busy loop polling.
> Unlike what the patch suggests, the polling time is not in the microsec=
ond
> range, but takes as long as a current CAN bus reception needs to finish=
,
> so typically more in the fraction of millisecond range. Since the timeo=
ut
> is in jiffies it won't timeout.
>=20
> Even with these additional fixes the driver is still not able to provid=
e a
> proper FIFO which doesn't drop packages. So change the driver to use
> rx-offload and base order on timestamp instead of message box numbers. =
As
> a side affect, this also fixes [4] and [5].
>=20
> Before this change messages with a single byte counter were dropped /
> received out of order at a bitrate of 250kbit/s on an am3517. With this=

> patch that no longer occurs up to and including 1Mbit/s.
>=20
> [1] https://linux-can.vger.kernel.narkive.com/zgO9inVi/patch-can-ti-hec=
c-fix-rx-wrong-sequence-issue#post6
> [2] http://arago-project.org/git/projects/?p=3Dlinux-omap3.git;a=3Dcomm=
it;h=3D02346892777f07245de4d5af692513ebd852dcb2
> [3] https://linux-can.vger.kernel.narkive.com/zgO9inVi/patch-can-ti-hec=
c-fix-rx-wrong-sequence-issue#post5
> [4] https://patchwork.ozlabs.org/patch/895956/
> [5] https://www.spinics.net/lists/netdev/msg494971.html
>=20
> Cc: Anant Gole <anantgole@ti.com>
> Cc: AnilKumar Ch <anilkumar@ti.com>
> Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
> ---
>  drivers/net/can/ti_hecc.c | 189 +++++++++++++-------------------------=
--------
>  1 file changed, 53 insertions(+), 136 deletions(-)
>=20
> diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
> index db6ea93..fe7ffff 100644
> --- a/drivers/net/can/ti_hecc.c
> +++ b/drivers/net/can/ti_hecc.c
> @@ -5,6 +5,7 @@
>   * specs for the same is available at <http://www.ti.com>
>   *
>   * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.c=
om/
> + * Copyright (C) 2019 Jeroen Hofstee <jhofstee@victronenergy.com>
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License as
> @@ -34,6 +35,7 @@
>  #include <linux/can/dev.h>
>  #include <linux/can/error.h>
>  #include <linux/can/led.h>
> +#include <linux/can/rx-offload.h>
> =20
>  #define DRV_NAME "ti_hecc"
>  #define HECC_MODULE_VERSION     "0.7"
> @@ -63,29 +65,16 @@ MODULE_VERSION(HECC_MODULE_VERSION);
>  #define HECC_TX_PRIO_MASK	(MAX_TX_PRIO << HECC_MB_TX_SHIFT)
>  #define HECC_TX_MB_MASK		(HECC_MAX_TX_MBOX - 1)
>  #define HECC_TX_MASK		((HECC_MAX_TX_MBOX - 1) | HECC_TX_PRIO_MASK)
> -#define HECC_TX_MBOX_MASK	(~(BIT(HECC_MAX_TX_MBOX) - 1))
> -#define HECC_DEF_NAPI_WEIGHT	HECC_MAX_RX_MBOX
> =20
>  /*
> - * Important Note: RX mailbox configuration
> - * RX mailboxes are further logically split into two - main and buffer=

> - * mailboxes. The goal is to get all packets into main mailboxes as
> - * driven by mailbox number and receive priority (higher to lower) and=

> - * buffer mailboxes are used to receive pkts while main mailboxes are =
being
> - * processed. This ensures in-order packet reception.
> - *
> - * Here are the recommended values for buffer mailbox. Note that RX ma=
ilboxes
> - * start after TX mailboxes:
> - *
> - * HECC_MAX_RX_MBOX		HECC_RX_BUFFER_MBOX	No of buffer mailboxes
> - * 28				12			8
> - * 16				20			4
> + * RX mailbox configuration
> + * The remaining mailboxes are used for reception and are delivered ba=
sed on
> + * their timestamp, to avoid a hardware race when CANME is changed whi=
le
> + * CAN-bus traffix is being received.
>   */
> =20
>  #define HECC_MAX_RX_MBOX	(HECC_MAX_MAILBOXES - HECC_MAX_TX_MBOX)
> -#define HECC_RX_BUFFER_MBOX	12 /* as per table above */
>  #define HECC_RX_FIRST_MBOX	(HECC_MAX_MAILBOXES - 1)
> -#define HECC_RX_HIGH_MBOX_MASK	(~(BIT(HECC_RX_BUFFER_MBOX) - 1))
> =20
>  /* TI HECC module registers */
>  #define HECC_CANME		0x0	/* Mailbox enable */
> @@ -123,6 +112,8 @@ MODULE_VERSION(HECC_MODULE_VERSION);
>  #define HECC_CANMDL		0x8
>  #define HECC_CANMDH		0xC
> =20
> +#define HECC_CANMOTS		0x100

It's actually 0x80

> +
>  #define HECC_SET_REG		0xFFFFFFFF
>  #define HECC_CANID_MASK		0x3FF	/* 18 bits mask for extended id's */
>  #define HECC_CCE_WAIT_COUNT     100	/* Wait for ~1 sec for CCE bit */
> @@ -193,7 +184,7 @@ static const struct can_bittiming_const ti_hecc_bit=
timing_const =3D {
> =20
>  struct ti_hecc_priv {
>  	struct can_priv can;	/* MUST be first member/field */
> -	struct napi_struct napi;
> +	struct can_rx_offload offload;
>  	struct net_device *ndev;
>  	struct clk *clk;
>  	void __iomem *base;
> @@ -203,7 +194,6 @@ struct ti_hecc_priv {
>  	spinlock_t mbx_lock; /* CANME register needs protection */
>  	u32 tx_head;
>  	u32 tx_tail;
> -	u32 rx_next;
>  	struct regulator *reg_xceiver;
>  };
> =20
> @@ -265,6 +255,11 @@ static inline u32 hecc_get_bit(struct ti_hecc_priv=
 *priv, int reg, u32 bit_mask)
>  	return (hecc_read(priv, reg) & bit_mask) ? 1 : 0;
>  }
> =20
> +static inline u32 hecc_read_stamp(struct ti_hecc_priv *priv, u32 mbxno=
)
> +{
> +	return __raw_readl(priv->hecc_ram + 0x80 + 4 * mbxno);

I've changed this function to use HECC_CANMOTS.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--wOe0gYcUEepxQHwDfsJDd7ZqTtKeTJmc8--

--0TGN2duKhCYiG04TA8avalkRqpNrVCmIu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl04FhoACgkQWsYho5Hk
nSDbcAgAowGB7FaxEXpOn0rkFgKcX+WreYg4QLIoqkXsUAZOPLSXCh40RxrwBrNj
pNQw2F/hgSwn+0raPQrbfDjufSJ37KevDZlrDZJ7+yHx7Qnm485C+QArCyIBFg+d
xbAwHX2hagaRS7dEefOVD77jULgqJ4fKCmzqZBM4hILC9Cnc11x+fM7ZnTus2d4x
VQXOoHSHa5yiyTw9r0BWDyvbC/pXADo4nA/MNCzuik2W+JOtve6zLCWJgePZKuvx
zwY0rKDJAX4dqzPclABE+4E9FbTMzuB8t892INDWQt74RDO9SWPcX7RiObE0t0Yd
oBDdvuXwzddfEu9f6L9pPQ+58dDDlg==
=hV5H
-----END PGP SIGNATURE-----

--0TGN2duKhCYiG04TA8avalkRqpNrVCmIu--
