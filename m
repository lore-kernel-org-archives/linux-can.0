From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v4] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Tue, 13 Jan 2015 14:18:36 +0100
Message-ID: <54B51B2C.3080404@peak-system.com>
References: <1420538446-8336-1-git-send-email-s.grosjean@peak-system.com>
 <54AD66C5.10908@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:45665 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbbAMN1l (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 Jan 2015 08:27:41 -0500
In-Reply-To: <54AD66C5.10908@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Hi Marc,

Le 07/01/2015 18:03, Marc Kleine-Budde a =C3=A9crit :
> On 01/06/2015 11:00 AM, Stephane Grosjean wrote:
>  =20
> @@ -750,9 +795,10 @@ static int peak_usb_create_dev(struct peak_usb_a=
dapter *peak_usb_adapter,
>   	dev->can.clock =3D peak_usb_adapter->clock;
>   	dev->can.bittiming_const =3D &peak_usb_adapter->bittiming_const;
>   	dev->can.do_set_bittiming =3D peak_usb_set_bittiming;
> +	dev->can.data_bittiming_const =3D &peak_usb_adapter->data_bittiming=
_const;
> +	dev->can.do_set_data_bittiming =3D peak_usb_set_data_bittiming;
>   	dev->can.do_set_mode =3D peak_usb_set_mode;
> -	dev->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES |
> -				      CAN_CTRLMODE_LISTENONLY;
> +	dev->can.ctrlmode_supported =3D peak_usb_adapter->ctrlmode_supporte=
d;
> All ctrlmode_supported can go into a seperate patch.

I'll try but can you please explain why?

>
>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/=
net/can/usb/peak_usb/pcan_usb_core.h
>> index 073b47f..13d44a5 100644
>> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
>> @@ -25,6 +25,8 @@
>>   /* supported device ids. */
>>   #define PCAN_USB_PRODUCT_ID		0x000c
>>   #define PCAN_USBPRO_PRODUCT_ID		0x000d
>> +#define PCAN_USBPROFD_PRODUCT_ID	0x0011
>> +#define PCAN_USBFD_PRODUCT_ID		0x0012
>>  =20
>>   #define PCAN_USB_DRIVER_NAME		"peak_usb"
>>  =20
>> @@ -44,8 +46,10 @@ struct peak_usb_device;
>>   struct peak_usb_adapter {
>>   	char *name;
>>   	u32 device_id;
>> +	u32 ctrlmode_supported;
> seperate patch

same
>
> +
> +/* handle uCAN status message */
> +static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
> +				     struct pucan_msg *rx_msg)
> +{
> +	struct pucan_status_msg *st =3D (struct pucan_status_msg *)rx_msg;
> +	struct peak_usb_device *dev =3D usb_if->dev[PUCAN_STMSG_CHANNEL(st)=
];
> +	struct pcan_usb_fd_device *pdev =3D
> +			container_of(dev, struct pcan_usb_fd_device, dev);
> +	enum can_state new_state =3D CAN_STATE_ERROR_ACTIVE;
> +	struct net_device *netdev =3D dev->netdev;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> Please talk to Wolfgang and Andri Yngvason about the state handling.

Okay.
>
> What about the following hunks (but not the .ctrlmode_supported) ? Th=
ey
> can go into a seperate patch which comes first?

So. You want me to do a serie of patches, right?
- a first patch that would change the existing files
- another one that would add the ctrl_mode_supported chanegs
- another one that would add the new files
>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/n=
et/can/usb/peak_usb/pcan_usb_pro.c
>> index 4cfa3b8..a764045 100644
>> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
>> @@ -27,14 +27,6 @@
>>  =20
>>   MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro adapter");
>>  =20
>> -/* PCAN-USB Pro Endpoints */
>> -#define PCAN_USBPRO_EP_CMDOUT		1
>> -#define PCAN_USBPRO_EP_CMDIN		(PCAN_USBPRO_EP_CMDOUT | USB_DIR_IN)
>> -#define PCAN_USBPRO_EP_MSGOUT_0		2
>> -#define PCAN_USBPRO_EP_MSGIN		(PCAN_USBPRO_EP_MSGOUT_0 | USB_DIR_IN=
)
>> -#define PCAN_USBPRO_EP_MSGOUT_1		3
>> -#define PCAN_USBPRO_EP_UNUSED		(PCAN_USBPRO_EP_MSGOUT_1 | USB_DIR_I=
N)
>> -
>>   #define PCAN_USBPRO_CHANNEL_COUNT	2
>>  =20
>>   /* PCAN-USB Pro adapter internal clock (MHz) */
>> @@ -322,8 +314,8 @@ static int pcan_usb_pro_wait_rsp(struct peak_usb=
_device *dev,
>>   	return (i >=3D PCAN_USBPRO_RSP_SUBMIT_MAX) ? -ERANGE : err;
>>   }

>>  =20
>> +extern int pcan_usb_pro_probe(struct usb_interface *intf);
>> +extern int pcan_usb_pro_send_req(struct peak_usb_device *dev, int r=
eq_id,
>> +		                                 int req_value, void *req_addr,
>> +						 int req_size);
>> +extern void pcan_usb_pro_restart_complete(struct urb *urb);
> IIRC we're killing the "extern" in function definitions in the kernel=
=2E

Ok. So I remove all "extern" keywords even from existing files, right?

> Marc=20

St=C3=A9phane.
--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
