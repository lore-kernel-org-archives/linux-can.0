From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ti_hecc: use timestamp based rx-offloading
Date: Fri, 26 Jul 2019 13:48:50 +0200
Message-ID: <04bdda38-79fa-c266-2a3c-1229a1fd8229@pengutronix.de>
References: <1556539376-20932-1-git-send-email-jhofstee@victronenergy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="8Vcx5zN8NAF034AJYysdQKrpAeRKXuUgg"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1556539376-20932-1-git-send-email-jhofstee@victronenergy.com>
Sender: netdev-owner@vger.kernel.org
To: Jeroen Hofstee <jhofstee@victronenergy.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Anant Gole <anantgole@ti.com>, AnilKumar Ch <anilkumar@ti.com>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8Vcx5zN8NAF034AJYysdQKrpAeRKXuUgg
Content-Type: multipart/mixed; boundary="M37tVGSr116Pwc4jJbfEdkeK6V5F6LKxb";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jeroen Hofstee <jhofstee@victronenergy.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Anant Gole <anantgole@ti.com>, AnilKumar Ch <anilkumar@ti.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Message-ID: <04bdda38-79fa-c266-2a3c-1229a1fd8229@pengutronix.de>
Subject: Re: [PATCH] can: ti_hecc: use timestamp based rx-offloading
References: <1556539376-20932-1-git-send-email-jhofstee@victronenergy.com>
In-Reply-To: <1556539376-20932-1-git-send-email-jhofstee@victronenergy.com>

--M37tVGSr116Pwc4jJbfEdkeK6V5F6LKxb
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
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

[...]

> @@ -744,8 +652,8 @@ static irqreturn_t ti_hecc_interrupt(int irq, void =
*dev_id)
>  	struct net_device *ndev =3D (struct net_device *)dev_id;
>  	struct ti_hecc_priv *priv =3D netdev_priv(ndev);
>  	struct net_device_stats *stats =3D &ndev->stats;
> -	u32 mbxno, mbx_mask, int_status, err_status;
> -	unsigned long ack, flags;
> +	u32 mbxno, mbx_mask, int_status, err_status, stamp;
> +	unsigned long flags, rx_pending;
> =20
>  	int_status =3D hecc_read(priv,
>  		(priv->use_hecc1int) ? HECC_CANGIF1 : HECC_CANGIF0);
> @@ -769,11 +677,11 @@ static irqreturn_t ti_hecc_interrupt(int irq, voi=
d *dev_id)
>  			spin_lock_irqsave(&priv->mbx_lock, flags);
>  			hecc_clear_bit(priv, HECC_CANME, mbx_mask);
>  			spin_unlock_irqrestore(&priv->mbx_lock, flags);
> -			stats->tx_bytes +=3D hecc_read_mbx(priv, mbxno,
> -						HECC_CANMCF) & 0xF;
> +			stamp =3D hecc_read_stamp(priv, mbxno);
> +			stats->tx_bytes +=3D can_rx_offload_get_echo_skb(&priv->offload,
> +									mbxno, stamp);
>  			stats->tx_packets++;
>  			can_led_event(ndev, CAN_LED_EVENT_TX);
> -			can_get_echo_skb(ndev, mbxno);
>  			--priv->tx_tail;
>  		}
> =20
> @@ -784,12 +692,11 @@ static irqreturn_t ti_hecc_interrupt(int irq, voi=
d *dev_id)
>  		((priv->tx_head & HECC_TX_MASK) =3D=3D HECC_TX_MASK)))
>  			netif_wake_queue(ndev);
> =20
> -		/* Disable RX mailbox interrupts and let NAPI reenable them */
> -		if (hecc_read(priv, HECC_CANRMP)) {
> -			ack =3D hecc_read(priv, HECC_CANMIM);
> -			ack &=3D BIT(HECC_MAX_TX_MBOX) - 1;
> -			hecc_write(priv, HECC_CANMIM, ack);
> -			napi_schedule(&priv->napi);
> +		/* offload RX mailboxes and let NAPI deliver them */
> +		while ((rx_pending =3D hecc_read(priv, HECC_CANRMP))) {
> +			can_rx_offload_irq_offload_timestamp(&priv->offload,
> +							     rx_pending);
> +			hecc_write(priv, HECC_CANRMP, rx_pending);

Can prepare a patch to move the RMP writing into the mailbox_read()
function. This makes the mailbox available a bit earlier and works
better for memory pressure situations, where no skb can be allocated.

>  		}
>  	}

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--M37tVGSr116Pwc4jJbfEdkeK6V5F6LKxb--

--8Vcx5zN8NAF034AJYysdQKrpAeRKXuUgg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl066KMACgkQWsYho5Hk
nSDQNAf/SLz1+GBIBkre422kLlWi2HhYFlWnIRc7+uk12HUKOzsnluhDcXjdOxmh
sKqlYnFgwDU1rElu2OMLcwwBOyESwm3spL+9OC/hDg2jdfvZG0M/0tGwa+/QxjIC
dMgbYK29TTwuYWtIgY9nbSKHNRAlVszUnDD3WelT+VgEoFlC3AFk9IYBxwVUEsL/
2T6ElbIWSCXOD3Ad75yoPN5zvcVb/ekFcG3QCV8w3vn2RxDEG2HG15M3Mdkk9Zcf
WRbLB4NllVnuJ3U2EfLQyrT8A1fgBKPDHRLFWcFVFYduRR5ktxvbiisY+bGebLIj
DKAKcC1qe4IEccivuscShSTAvZcXEA==
=kW2T
-----END PGP SIGNATURE-----

--8Vcx5zN8NAF034AJYysdQKrpAeRKXuUgg--
