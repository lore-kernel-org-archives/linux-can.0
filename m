From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: RE: [PATCH V2 2/5] can: flexcan: add CAN FD mode support
Date: Tue, 9 Apr 2019 07:04:53 +0000
Message-ID: <VI1PR0402MB286355821F5C81122A7C86E2DF2D0@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190319051512.14950-3-qiangqing.zhang@nxp.com>
 <385f7948-d12b-1fc2-2ed2-23d1e76034a0@nxp.com>
 <DB7PR04MB46181D2AC261EAB6DEECEFCCE62D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB46181D2AC261EAB6DEECEFCCE62D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

> From: Joakim Zhang
> Sent: Tuesday, April 9, 2019 5:07 AM
> Hi Stefan,
>=20
> Thanks for your validation! Could you add your test tag if you can=20
> successfully validated?

Sure, no problem. Please note that I needed to replace "flexcan_read" and "=
flexcan_write" with "priv->read" and "priv->write" respectively, in PATCH V=
2 4/5.

>  [Joakim Zhang] We added can fd support in 4.9 kernel which let=20
> mailbox_read call alloc_can(fd)_skb in the past. Now the driver=20
> allocate skb before mailbox_read in rx_offload and also read the overflow=
 frames.
>               I add the "is_canfd" since I don't want to change the=20
> rx_offload framework too much. @mkl@pengutronix.de, could you give=20
> some advice, which solution is better?

This is more of a functionality issue. For example, candump from canutils 4=
.0.6 never shows CAN FD frames, but should still be able to show the CAN 2.=
0 ones regardless of whether "fd on" was supplied. I suggest the following =
separation:

can_rx_offload_offload_one:
	struct sk_buff *skb =3D NULL;
	...
	bool drop =3D unlikely(skb_queue_len(&offload->skb_queue) >
			     offload->skb_queue_len_max);

	if (offload->mailbox_read(offload, drop, &skb, &timestamp, n) && !skb)
		offload->dev->stats.rx_dropped++;

	if (skb) {
		struct can_rx_offload_cb *cb =3D can_rx_offload_get_cb(skb);

		cb->timestamp =3D timestamp;
	}

	return skb;

flexcan_mailbox_read:
	...
	if (!drop) {
		if (reg_ctrl & FLEXCAN_MB_CNT_EDL)
			*skb =3D alloc_canfd_skb(offload->dev, &cf);
		else
			*skb =3D alloc_can_skb(offload->dev,
					     (struct can_frame **)&cf);
	}
	if (*skb) {
		/* use cf */
		...
	}
	/* mark as read */

Although not visible in the FlexCAN case, the socket buffers would be also =
freed from inside mailbox_read if errors were encountered after allocation.

Regards,
Stefan
