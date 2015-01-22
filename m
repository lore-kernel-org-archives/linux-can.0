From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 7/7 v8] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Thu, 22 Jan 2015 17:07:52 +0100
Message-ID: <54C12058.8060303@peak-system.com>
References: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com>
 <1421940266-6088-8-git-send-email-s.grosjean@peak-system.com>
 <20150122160238.12081.76464@shannon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:39467 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbbAVQIB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Jan 2015 11:08:01 -0500
In-Reply-To: <20150122160238.12081.76464@shannon>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>


Le 22/01/2015 17:02, Andri Yngvason a =C3=A9crit :
> Quoting Stephane Grosjean (2015-01-22 15:24:26)
> [...]
>> +/* handle uCAN status message */
>> +static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
>> +                                    struct pucan_msg *rx_msg)
>> +{
>> +       struct pucan_status_msg *sm =3D (struct pucan_status_msg *)r=
x_msg;
>> +       struct peak_usb_device *dev =3D usb_if->dev[pucan_stmsg_get_=
channel(sm)];
>> +       struct pcan_usb_fd_device *pdev =3D
>> +                       container_of(dev, struct pcan_usb_fd_device,=
 dev);
>> +       enum can_state new_state =3D CAN_STATE_ERROR_ACTIVE;
>> +       enum can_state rx_state, tx_state;
>> +       struct net_device *netdev =3D dev->netdev;
>> +       struct can_frame *cf;
>> +       struct sk_buff *skb;
>> +
>> +       /* nothing should be sent while in BUS_OFF state */
>> +       if (dev->can.state =3D=3D CAN_STATE_BUS_OFF)
>> +               return 0;
>> +
>> +       if (sm->channel_p_w_b & PUCAN_BUS_BUSOFF) {
>> +               new_state =3D CAN_STATE_BUS_OFF;
>> +       } else if (sm->channel_p_w_b & PUCAN_BUS_PASSIVE) {
>> +               new_state =3D CAN_STATE_ERROR_PASSIVE;
>> +       } else if (sm->channel_p_w_b & PUCAN_BUS_WARNING) {
>> +               new_state =3D CAN_STATE_ERROR_WARNING;
>> +       } else {
>> +               /* no error bit (so, no error skb, back to active st=
ate) */
>> +               dev->can.state =3D CAN_STATE_ERROR_ACTIVE;
>> +               pdev->bec.txerr =3D 0;
>> +               pdev->bec.rxerr =3D 0;
>> +               return 0;
>> +       }
>> +
>> +       /* state hasn't changed */
>> +       if (new_state =3D=3D dev->can.state)
>> +               return 0;
>> +
>> +       /* handle bus state change */
>> +       tx_state =3D (pdev->bec.txerr >=3D pdev->bec.rxerr) ?  new_s=
tate : 0;
>> +       rx_state =3D (pdev->bec.txerr <=3D pdev->bec.rxerr) ?  new_s=
tate : 0;
> You seem to have extra spaces here -------------------------^

Aaarrrrgh... F*%$ !!!
>> +
>> +       /* allocate an skb to store the error frame */
>> +       skb =3D alloc_can_err_skb(netdev, &cf);
>> +       if (skb)
>> +               can_change_state(netdev, cf, tx_state, rx_state);
>> +
>> +       /* things must be done even in case of OOM */
>> +       if (new_state =3D=3D CAN_STATE_BUS_OFF)
>> +               can_bus_off(netdev);
>> +
>> +       if (!skb)
>> +               return -ENOMEM;
>> +
>> +       peak_usb_netif_rx(skb, &usb_if->time_ref,
>> +                         le32_to_cpu(sm->ts_low), le32_to_cpu(sm->t=
s_high));
>> +
>> +       netdev->stats.rx_packets++;
>> +       netdev->stats.rx_bytes +=3D cf->can_dlc;
>> +
>> +       return 0;
>> +}
>> +
> [...]
>
> ACK, but you'll probably want to remove those extra spaces *if* you p=
ost another
> version of the patch set.
>
> Best regards,
> Andri
Thank you very much for your ACK, Andri.

Best regards,

St=C3=A9phane
--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
