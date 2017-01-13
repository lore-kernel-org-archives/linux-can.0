From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v3 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
Date: Fri, 13 Jan 2017 16:01:26 +0100
Message-ID: <16ed4fc6-9085-b128-c299-0c5f501b87bf@peak-system.com>
References: <1484136978-3823-1-git-send-email-s.grosjean@peak-system.com>
 <1484136978-3823-5-git-send-email-s.grosjean@peak-system.com>
 <aa642d9e-28a1-6494-5ad0-e7ae534a95da@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:51796 "EHLO
        mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbdAMPBw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Jan 2017 10:01:52 -0500
In-Reply-To: <aa642d9e-28a1-6494-5ad0-e7ae534a95da@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

Le 13/01/2017 à 15:00, Marc Kleine-Budde a écrit :
> On 01/11/2017 01:16 PM, Stephane Grosjean wrote:
>> This patch adds the support of the PCAN-PCI Express FD boards made
>> by PEAK-System, for computers using the PCI Express slot.
>>
>> The PCAN-PCI Express FD has one or two CAN FD channels, depending
>> on the model. A galvanic isolation of the CAN ports protects
>> the electronics of the card and the respective computer against
>> disturbances of up to 500 Volts. The PCAN-PCI Express FD can be operated
>> with ambient temperatures in a range of -40 to +85 °C.
>>
>> Such boards run an extented version of the CAN-FD IP running into USB
>> CAN-FD interfaces from PEAK-System, so this patch adds several new commands
>> and their corresponding data types to the PEAK CAN-FD common definitions
>> header file too.
>>
>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> The access of tx_pages_free seems not be be synchronized. It's accessed
> from IRQ context and from the xmit function. See more comments inline.

Arf yes, you're right. Now it's used to compute room left...

>> +		netif_start_queue(ndev);
> I think this must be wake_queue()

Yep! fixed.

> + /* should never happen */
>> +	if (!msg) {
>> +		netdev_err(ndev, "Abnormal NULL msg (CAN frame lost)\n");
>> +		stats->rx_dropped++;
> tx?

Aaargh... Yep (again!)

>
>> +		netif_stop_queue(ndev);
>> +		return NETDEV_TX_OK;
> NETDEV_TX_BUSY
Ok.
>
>> +	}
>> +
>> +	msg->size = cpu_to_le16(msg_size);
>> +	msg->type = cpu_to_le16(PUCAN_MSG_CAN_TX);
>> +	msg_flags = 0;
>> +
>> +	if (cf->can_id & CAN_EFF_FLAG) {
>> +		msg_flags |= PUCAN_MSG_EXT_ID;
>> +		msg->can_id = cpu_to_le32(cf->can_id & CAN_EFF_MASK);
>> +	} else {
>> +		msg->can_id = cpu_to_le32(cf->can_id & CAN_SFF_MASK);
>> +	}
>> +
>> +	can_dlc = can_len2dlc(cf->len);
> it's overwritten later
True...
> +struct net_device *alloc_peak_canfd_dev(int sizeof_priv, int index,
>> +					int echo_skb_max);
> Why do you have this peak_canfd abstraction here? Are there more HW
> using this chip?

Yep! And I'd really like to migrate one of these days 
"peak_usb/pcan_usb_fd.c", for example. That's also the reason of the 
renaming/moving of "peak_canfd.h" under "include/linux/can/dev".
> Marc
>

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183 
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
--
