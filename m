From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH V6 1/1] can: Add support for esd CAN PCIe/402 card
Date: Tue, 17 Mar 2015 09:33:09 -0400
Message-ID: <20150317133309.GA30168@linux>
References: <1426592308-23817-1-git-send-email-thomas.koerper@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37003 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535AbbCQNdN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 09:33:13 -0400
Received: by wixw10 with SMTP id w10so11190924wix.0
        for <linux-can@vger.kernel.org>; Tue, 17 Mar 2015 06:33:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1426592308-23817-1-git-send-email-thomas.koerper@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas =?iso-8859-1?Q?K=F6rper?= <thomas.koerper@esd.eu>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>

Hi,

[ Adding Marc to the CC list. Kindly add him in future submissions.. ]

On Tue, Mar 17, 2015 at 12:38:28PM +0100, Thomas K=F6rper wrote:
=2E..
> +netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *n=
etdev)
> +{
> +	struct acc_net_priv *priv =3D netdev_priv(netdev);
> +	struct acc_core *core =3D priv->core;
> +	struct can_frame *cf =3D (struct can_frame *)skb->data;
> +	u8 new_fifo_head =3D (core->tx_fifo_head + 1) % core->tx_fifo_size;
> +	u32 esd_id;
> +	u8 esd_len;
> +
> +	if ((new_fifo_head =3D=3D core->tx_fifo_tail) || !acc_txq_isready(c=
ore)) {
> +		netif_stop_queue(netdev);
> +		return NETDEV_TX_BUSY;
> +	}
> +

In that case, an error or warning message is in order. Quoting from
Documentation/networking/{driver.txt,netdevices.txt}:

  When this happens, it usually means start/stop flow control
  is broken in the driver. This is a hard error that should be logged:
  netdev_err("BUG: Tx ring full when queue awake!\n");

[ Actually it would be nice to print such message and _heavily_ test
  the driver tx/rx pathes afterwards, making sure no practical race
  conditions exist regarding the netif tx queue .. ]

On another topic, I've searched the code for the part where it stops
the queue because "we've taken the last slot in the ring, and we will
not be able to handle further transmissions" but couldn't find it at
all. AFAIK, that part calls netif_stop_queue(), but _always_ return
with NETDEV_TX_OK. Am I missing something obvious?

[...]

> +static void
> +handle_core_msg_errstatechange(struct acc_core *core,
> +			       const struct acc_bmmsg_errstatechange *msg)
> +{
> +	struct acc_net_priv *priv =3D netdev_priv(core->net_dev);
> +	struct net_device_stats *stats =3D &core->net_dev->stats;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +
> +	skb =3D alloc_can_err_skb(core->net_dev, &cf);
> +	if (skb) {
> +		enum can_state new_state;
> +		u8 txerr;
> +		u8 rxerr;
> +
> +		txerr =3D (u8)(msg->reg_status >> 8);
> +		rxerr =3D (u8)msg->reg_status;
> +
> +		cf->data[6] =3D txerr;
> +		cf->data[7] =3D rxerr;
> +
> +		if (msg->reg_status & ACC_REG_STATUS_MASK_STATUS_BS)
> +			new_state =3D CAN_STATE_BUS_OFF;
> +		else if (msg->reg_status & ACC_REG_STATUS_MASK_STATUS_EP)
> +			new_state =3D CAN_STATE_ERROR_PASSIVE;
> +		else if (msg->reg_status & ACC_REG_STATUS_MASK_STATUS_ES)
> +			new_state =3D CAN_STATE_ERROR_WARNING;
> +		else
> +			new_state =3D CAN_STATE_ERROR_ACTIVE;
> +
> +		if (new_state !=3D priv->can.state) {
> +			enum can_state tx_state, rx_state;
> +
> +			tx_state =3D (txerr >=3D rxerr) ? new_state : 0;
> +			rx_state =3D (rxerr >=3D txerr) ? new_state : 0;
> +
> +			can_change_state(core->net_dev, cf, tx_state, rx_state);
> +		}
> +

@Marc: can we set a standard for new drivers to update the CAN state
before trying an skb allocation than can fail with -ENOMEM? That way,
in the future, we will have the incentive to break can_change_state()
responsibility between 1) updating the CAN interface's state & counters=
,
and 2) setting up of CAN error frame ID and data to userspace.

@Thomas: Kindly check kvaser_usb.c::kvaser_usb_rx_err() for context.
Of course Marc will have the final word for this :-)

> +		netif_rx(skb);
> +		stats->rx_packets++;
> +		stats->rx_bytes +=3D cf->can_dlc;
> +	} else {
> +		stats->rx_dropped++;
> +	}
> +
> +	if (msg->reg_status & ACC_REG_STATUS_MASK_STATUS_BS) {
> +		acc_write32(core, ACC_CORE_OF_TX_ABORT_MASK, 0xffff);
> +		can_bus_off(core->net_dev);
> +	}
> +}

Thanks,
Darwish
