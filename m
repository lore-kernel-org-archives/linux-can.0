From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH V6 1/1] can: Add support for esd CAN PCIe/402 card
Date: Tue, 17 Mar 2015 23:55:58 +0200
Message-ID: <20150317215558.GA2378@Darwish.PC>
References: <1426592308-23817-1-git-send-email-thomas.koerper@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33333 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbbCQV4D (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 17:56:03 -0400
Received: by wgbcc7 with SMTP id cc7so19657722wgb.0
        for <linux-can@vger.kernel.org>; Tue, 17 Mar 2015 14:56:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1426592308-23817-1-git-send-email-thomas.koerper@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas =?iso-8859-1?Q?K=F6rper?= <thomas.koerper@esd.eu>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Tue, Mar 17, 2015 at 12:38:28PM +0100, Thomas K=F6rper wrote:

=2E..

> +static int pci402_probe(struct pci_dev *pdev, const struct pci_devic=
e_id *ent)
> +{
> +	struct pci402_card *card =3D NULL;
> +	int err;
> +
> +	BUILD_BUG_ON(PCI402_DMA_FIFO_ITEMSIZE !=3D sizeof(struct acc_bmmsg)=
);
> +
> +	err =3D pci_enable_device(pdev);
> +	if (err)
> +		goto failure;
> +
> +	pci_set_master(pdev);
> +
> +	card =3D kzalloc(sizeof(*card), GFP_KERNEL);
> +	if (!card)
> +		goto failure;
> +

I think there's a resource leak here: the second "goto failure"
should be a "goto failure_disable_pci" instead. That way, in
case of kzalloc() -ENOMEM we can call pci_disable_device() and
decrement the reference counter increased by pci_enable_device()
above...

If so, this can be fixed by making the recovery path be
more straightforward:

err =3D pci_enable_device(pdev);
if (err)
    return err;

card =3D kzalloc(..., GFP)
if (!card)
    goto failure_disable_pci;

err =3D pci_request_regions(...);
if (err)
    goto failure_free_card;   /* new label, above failure_disable_pci *=
/

=2E..

> +failure_release_regions:
> +	pci_release_regions(pdev);
> +
> +failure_disable_pci:
> +	pci_disable_device(pdev);
> +
> +failure:
> +	kfree(card);
> +
> +	return err;
> +}
> +

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

Keeping aside the issue outlined in earlier email where there's
no code snippet in this patch that stops the queue but returns
NETDEV_TX_OK as expected..

Is there anything I'm missing that can stop below scenario from
happening:

start_xmit [softirq context]              handle_core_msg_rxtxdone [har=
dirq]
****************************              *****************************=
*****

if (new_fifo.. || !acc_txq..) {
                              PCI IRQ!
                              -------->
                                          ...
                                          netif_wake_queue(core->net_de=
v);
                                          return;
                             <--------
  netif_stop_queue(netdev);
  return NETDEV_TX_BUSY;
}

> +	esd_len =3D can_dlc2len(cf->can_dlc);
> +	if (cf->can_id & CAN_RTR_FLAG)
> +		esd_len |=3D ACC_CAN_RTR_FLAG;
> +
> +	if (cf->can_id & CAN_EFF_FLAG) {
> +		esd_id =3D cf->can_id & CAN_EFF_MASK;
> +		esd_id |=3D ACC_CAN_EFF_FLAG;
> +	} else {
> +		esd_id =3D cf->can_id & CAN_SFF_MASK;
> +	}
> +
> +	can_put_echo_skb(skb, netdev, core->tx_fifo_head);
> +	core->tx_fifo_head =3D new_fifo_head;
> +
> +	acc_txq_put(core, esd_id, esd_len, cf->data);
> +
> +	return NETDEV_TX_OK;
> +}
> +

=2E..

> +static void handle_core_msg_rxtxdone(struct acc_core *core,
> +				     const struct acc_bmmsg_rxtxdone *msg)
> +{
> +	struct acc_net_priv *priv =3D netdev_priv(core->net_dev);
> +	struct net_device_stats *stats =3D &core->net_dev->stats;
> +
> +	if (msg->dlc.rxtx.len & ACC_BM_LENFLAG_TX) {
> +		if (core->tx_fifo_head =3D=3D core->tx_fifo_tail) {
> +			netdev_warn(core->net_dev,
> +				    "TX interrupt, but queue is empty!?\n");
> +			return;
> +		}
> +		stats->tx_packets++;
> +		stats->tx_bytes +=3D
> +				get_can_dlc(msg->dlc.tx.len & ACC_CAN_DLC_MASK);
> +
> +		can_get_echo_skb(core->net_dev, core->tx_fifo_tail);
> +		core->tx_fifo_tail++;
> +		if (core->tx_fifo_tail >=3D core->tx_fifo_size)
> +			core->tx_fifo_tail =3D 0;
> +		netif_wake_queue(core->net_dev);
> +
> +	} else {
> +		struct skb_shared_hwtstamps *skb_ts;
> +		struct can_frame *cf;
> +		struct sk_buff *skb;
> +
> +		skb =3D alloc_can_skb(core->net_dev, &cf);
> +		if (!skb) {
> +			stats->rx_dropped++;
> +			return;
> +		}
> +
> +		cf->can_id =3D msg->id & CAN_EFF_MASK;
> +		if (msg->id & ACC_CAN_EFF_FLAG)
> +			cf->can_id |=3D CAN_EFF_FLAG;
> +
> +		cf->can_dlc =3D get_can_dlc(msg->dlc.rx.len);
> +		if (msg->dlc.rx.len & ACC_CAN_RTR_FLAG)
> +			cf->can_id |=3D CAN_RTR_FLAG;
> +		else
> +			memcpy(cf->data, msg->data, cf->can_dlc);
> +
> +		skb_ts =3D skb_hwtstamps(skb);
> +		skb_ts->hwtstamp =3D acc_ts_to_ktime(priv->ov, msg->timestamp);
> +		netif_rx(skb);
> +
> +		stats->rx_packets++;
> +		stats->rx_bytes +=3D cf->can_dlc;
> +	}
> +}
> +

=2E..

Thanks,
Darwish
