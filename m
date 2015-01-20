From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH] can/peak_usb: add adapter BEC callback definition
Date: Tue, 20 Jan 2015 15:46:23 +0100
Message-ID: <54BE6A3F.40405@peak-system.com>
References: <1421684127-12764-1-git-send-email-s.grosjean@peak-system.com>
 <1421684127-12764-3-git-send-email-s.grosjean@peak-system.com>
 <54BE640B.2050509@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:37810 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbbATOqb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Jan 2015 09:46:31 -0500
In-Reply-To: <54BE640B.2050509@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>


Le 20/01/2015 15:19, Marc Kleine-Budde a =C3=A9crit :
> On 01/19/2015 05:15 PM, Stephane Grosjean wrote:
>> Add the definition of a new callback that enable any PEAK-System CAN=
 USB
>> adapter to grant read access to its Bus Error Counters value.
>> This ability is not supported by all the PEAK-System adapters, thus,
>> for those, the callback pointer will be initiaized to NULL, which is
>> correct regarding the linux-can device driver specs.
>>
>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
>> ---
>>   drivers/net/can/usb/peak_usb/pcan_usb_core.c | 2 ++
>>   drivers/net/can/usb/peak_usb/pcan_usb_core.h | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/=
net/can/usb/peak_usb/pcan_usb_core.c
>> index c23609a..7a73060 100644
>> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
>> @@ -794,6 +794,8 @@ static int peak_usb_create_dev(struct peak_usb_a=
dapter *peak_usb_adapter,
>>   	dev->can.data_bittiming_const =3D &peak_usb_adapter->data_bittimi=
ng_const;
>>   	dev->can.do_set_data_bittiming =3D peak_usb_set_data_bittiming;
>>   	dev->can.do_set_mode =3D peak_usb_set_mode;
>> +	dev->can.do_get_berr_counter =3D
>> +		peak_usb_adapter->candev_get_berr_counter;
>>   	dev->can.ctrlmode_supported =3D peak_usb_adapter->ctrlmode_suppor=
ted;
>>  =20
>>   	netdev->netdev_ops =3D &peak_usb_netdev_ops;
>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/=
net/can/usb/peak_usb/pcan_usb_core.h
>> index a58d971..fb402d2 100644
>> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
>> @@ -70,6 +70,8 @@ struct peak_usb_adapter {
>>   	int (*dev_stop)(struct peak_usb_device *dev);
>>   	int (*dev_restart_async)(struct peak_usb_device *dev, struct urb =
*urb,
>>   					u8 *buf);
>> +	int (*candev_get_berr_counter)(const struct net_device *netdev,
>                ^^^^^^
>
> I think this prefix can be removed. I've done so in my series.

=46YI: I added this specific prefix because this is the only callback I=
'm=20
obliged to use with the "struct net_device *" argument.
No other way to setup a specific callback to get the BEC.

>
>> +				       struct can_berr_counter *bec);
>>   	u8 ep_msg_in;
>>   	u8 ep_msg_out[PCAN_USB_MAX_CHANNEL];
>>   	u8 ts_used_bits;
>>
> Marc

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
