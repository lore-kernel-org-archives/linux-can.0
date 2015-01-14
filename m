From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v4] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Wed, 14 Jan 2015 11:50:00 +0100
Message-ID: <54B649D8.40006@peak-system.com>
References: <1420538446-8336-1-git-send-email-s.grosjean@peak-system.com>
 <54AD66C5.10908@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:35600 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbbANKuH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Jan 2015 05:50:07 -0500
In-Reply-To: <54AD66C5.10908@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Hi Marc,

Sorry, I don't have got Andri's e-mail address... Could you give it to=20
me, please?

Thx in advance,

St=C3=A9phane

Le 07/01/2015 18:03, Marc Kleine-Budde a =C3=A9crit :
>> +/* handle uCAN status message */
>> >+static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if=
,
>> >+				     struct pucan_msg *rx_msg)
>> >+{
>> >+	struct pucan_status_msg *st =3D (struct pucan_status_msg *)rx_msg=
;
>> >+	struct peak_usb_device *dev =3D usb_if->dev[PUCAN_STMSG_CHANNEL(s=
t)];
>> >+	struct pcan_usb_fd_device *pdev =3D
>> >+			container_of(dev, struct pcan_usb_fd_device, dev);
>> >+	enum can_state new_state =3D CAN_STATE_ERROR_ACTIVE;
>> >+	struct net_device *netdev =3D dev->netdev;
>> >+	struct can_frame *cf;
>> >+	struct sk_buff *skb;
> Please talk to Wolfgang and Andri Yngvason about the state handling.
>

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
