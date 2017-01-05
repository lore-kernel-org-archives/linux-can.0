From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 4/4] can: peak: add support for PEAK PCAN-PCIe FD CAN-FD
 boards
Date: Thu, 5 Jan 2017 14:52:49 +0100
Message-ID: <421a8a25-b808-1771-63dc-df3cb7431f9b@peak-system.com>
References: <1481207924-28977-1-git-send-email-s.grosjean@peak-system.com>
 <1481207924-28977-5-git-send-email-s.grosjean@peak-system.com>
 <4b5d6e27-0680-81b8-66f3-f5ff219eab45@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:45771 "EHLO
        mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbdAENxA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Jan 2017 08:53:00 -0500
In-Reply-To: <4b5d6e27-0680-81b8-66f3-f5ff219eab45@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Hello Mark!

Thanks for your review. See below my comments.

Le 03/01/2017 à 15:01, Marc Kleine-Budde a écrit :
> On 12/08/2016 03:38 PM, Stephane Grosjean wrote:
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
>> Signed-off-by: Stephane Grosjean<s.grosjean@peak-system.com>
>> ---
>>   drivers/net/can/Kconfig                       |   1 +
>>   drivers/net/can/Makefile                      |   1 +
>>   drivers/net/can/peak_canfd/Kconfig            |  13 +
>>   drivers/net/can/peak_canfd/Makefile           |   5 +
>>   drivers/net/can/peak_canfd/peak_canfd.c       | 673 +++++++++++++++++++++
>>   drivers/net/can/peak_canfd/peak_canfd_user.h  |  47 ++
>>   drivers/net/can/peak_canfd/peak_pciefd_main.c | 820 ++++++++++++++++++++++++++
>>   include/linux/can/dev/peak_canfd.h            |  50 ++
>>   8 files changed, 1610 insertions(+)
>>   create mode 100644 drivers/net/can/peak_canfd/Kconfig
>>   create mode 100644 drivers/net/can/peak_canfd/Makefile
>>   create mode 100644 drivers/net/can/peak_canfd/peak_canfd.c
>>   create mode 100644 drivers/net/can/peak_canfd/peak_canfd_user.h
>>   create mode 100644 drivers/net/can/peak_canfd/peak_pciefd_main.c
>>

>> +
>> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
>> +		msg_flags |= PUCAN_MSG_LOOPED_BACK;
>> +
>> +	msg->flags = cpu_to_le16(msg_flags);
>> +	msg->channel_dlc = PUCAN_MSG_CHANNEL_DLC(priv->index, can_dlc);
>> +	memcpy(msg->d, cf->data, cf->len);
>> +
>> +	priv->write_tx_msg(priv);
>> +
>> +	stats->tx_bytes += can_dlc;
>> +	stats->tx_packets++;
>> +
>> +	/* put skb in rx queue as echo */
>> +	netif_rx(skb);
> Please wait until you get a tx-complete interrupt until you echo the skb.
No "tx-complete" IRQ is provided by the hw but an "LNK record 
encountered by the reader" interrupt only: this LNK record is put at the 
end of a 2K DMA page by the writer, to link this page to the next one. I 
don't imagine saving the N * CAN msgs the page might contain, in some 
temporary memory until getting (sometimes in the future) this kind of 
IRQ, for, finally echoing all of these ones in a row, do you?
>> +	if (sub_sys_id >= 0x0012)
>> +		can_count = 4;
>> +	else if (sub_sys_id >= 0x0010)
>> +		can_count = 3;
>> +	else if (sub_sys_id >= 0x0004)
>> +		can_count = 2;
>> +	else
>> +		can_count = 1;
>> +
>> +	/* allocate board structure object */
>> +	pciefd = kmalloc(sizeof(*pciefd) + sizeof(*pciefd->can) * can_count,
>> +			 GFP_KERNEL);
> devm_kzalloc?
>
> sizeof(*pciefd->can), you only want to have the memory to hold the
> pointer to can_count of struct pciefd_can, right? But you are allocating
> the actual memory for can_count of struct pciefd_can.
Nope: I currently allocate room for 'can-count' items, of 
sizeof(*pciefd->can) bytes each, while sizeof(*pciefd->can) = 
sizeof(pciefd->can[0]) = sizeof(struct pciefd_can *) (IMHO)

/* PEAK-PCIe FD board object */
struct pciefd_board {
         void __iomem *reg_base;
         struct pci_dev *pci_dev;
         spinlock_t cmd_lock;            /* 64-bits cmds must be atomic */
         struct pciefd_can *can[0];      /* array of network devices */
};

Thanks,

Stephane
--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183 
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
--
