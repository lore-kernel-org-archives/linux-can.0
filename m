From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH V6 1/1] can: Add support for esd CAN PCIe/402 card
Date: Tue, 17 Mar 2015 10:51:52 -0400
Message-ID: <20150317145152.GC30168@linux>
References: <1426592308-23817-1-git-send-email-thomas.koerper@esd.eu>
 <20150317133309.GA30168@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35523 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbbCQOv4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 10:51:56 -0400
Received: by wgdm6 with SMTP id m6so10572305wgd.2
        for <linux-can@vger.kernel.org>; Tue, 17 Mar 2015 07:51:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150317133309.GA30168@linux>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas =?iso-8859-1?Q?K=F6rper?= <thomas.koerper@esd.eu>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>

On Tue, Mar 17, 2015 at 09:33:09AM -0400, Ahmed S. Darwish wrote:
> Hi,
>=20
> [ Adding Marc to the CC list. Kindly add him in future submissions.. =
]
>=20
> On Tue, Mar 17, 2015 at 12:38:28PM +0100, Thomas K=F6rper wrote:
> ...
> > +netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device =
*netdev)
> > +{
> > +	struct acc_net_priv *priv =3D netdev_priv(netdev);
> > +	struct acc_core *core =3D priv->core;
> > +	struct can_frame *cf =3D (struct can_frame *)skb->data;
> > +	u8 new_fifo_head =3D (core->tx_fifo_head + 1) % core->tx_fifo_siz=
e;
> > +	u32 esd_id;
> > +	u8 esd_len;
> > +
> > +	if ((new_fifo_head =3D=3D core->tx_fifo_tail) || !acc_txq_isready=
(core)) {
> > +		netif_stop_queue(netdev);
> > +		return NETDEV_TX_BUSY;
> > +	}
> > +
>=20
> In that case, an error or warning message is in order. Quoting from
> Documentation/networking/{driver.txt,netdevices.txt}:
>=20
>   When this happens, it usually means start/stop flow control
>   is broken in the driver. This is a hard error that should be logged=
:
>   netdev_err("BUG: Tx ring full when queue awake!\n");
>=20
> [ Actually it would be nice to print such message and _heavily_ test
>   the driver tx/rx pathes afterwards, making sure no practical race
>   conditions exist regarding the netif tx queue .. ]
>=20
> On another topic, I've searched the code for the part where it stops
> the queue because "we've taken the last slot in the ring, and we will
> not be able to handle further transmissions" but couldn't find it at
> all. AFAIK, that part calls netif_stop_queue(), but _always_ return
> with NETDEV_TX_OK. Am I missing something obvious?
>=20

s/_always_/should always
