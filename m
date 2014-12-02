From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 1/3] can/peak_usb: CAN-FD: existing source files
 modifications
Date: Tue, 02 Dec 2014 14:55:26 +0100
Message-ID: <547DC4CE.8080504@peak-system.com>
References: <54779735.8030809@pengutronix.de>
 <547DBADC.2020009@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:46784 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbaLBNzd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Dec 2014 08:55:33 -0500
In-Reply-To: <547DBADC.2020009@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>


> -------- Original Message --------
> Subject: Re: [PATCH 1/3] can/peak_usb: CAN-FD: existing source files
> modifications
> Date: Thu, 27 Nov 2014 22:27:17 +0100
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> To: Stephane Grosjean <s.grosjean@peak-system.com>,
> linux-can@vger.kernel.org
> CC: Oliver Hartkopp <socketcan@hartkopp.net>
>
> On 11/27/2014 11:32 AM, Stephane Grosjean wrote:
>> This patch does some modifications to the existing files that suppor=
t the
>> PEAK-System Technik CAN 2.0b USB adapters, for preparing the support=
 of CAN-FD.
>>
>> In particular, this patch changes some static identifiers into globa=
l ones, to
>> share common functionalities with the further incoming CAN-FD specif=
ic source
>> files.
> The subject of this patch should describe what it does and the
> description why. You should not split your patches by source files it
> touches but thematically. Only handle one problem per patch.

Ok.

>
>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
>> ---
>>   drivers/net/can/usb/peak_usb/pcan_usb.c     |  1 +
>>   drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 22 +++++++----------=
-----
>>   drivers/net/can/usb/peak_usb/pcan_usb_pro.h |  8 ++++++++
>>   3 files changed, 16 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb.c
>> index 925ab8e..10a4ceb 100644
>> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
>> @@ -858,6 +858,7 @@ struct peak_usb_adapter pcan_usb =3D {
>>   	.name =3D "PCAN-USB",
>>   	.device_id =3D PCAN_USB_PRODUCT_ID,
>>   	.ctrl_count =3D 1,
>> +	.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LIST=
ENONLY,
> This change seems unrelated to the make functions non static.

Ok.

>
> and FTBFS:
>
>> linux/drivers/net/can/usb/peak_usb/pcan_usb.c:861:2: error: unknown =
field =E2=80=98ctrlmode_supported=E2=80=99 specified in initializer
>>    .ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LIS=
TENONLY,
>>    ^
>> linux/drivers/net/can/usb/peak_usb/pcan_usb.c:861:2: warning: initia=
lization makes pointer from integer without a cast
>> linux/drivers/net/can/usb/peak_usb/pcan_usb.c:861:2: warning: (near =
initialization for =E2=80=98pcan_usb.intf_probe=E2=80=99)

well, this FTBS is "normal" while you doesn't apply PATCH 3/3. I though=
t=20
a "serie" of patches was not cleavable... Can u confirm, please?

>>   	.clock =3D {
>>   		.freq =3D PCAN_USB_CRYSTAL_HZ / 2 ,
>>   	},
>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/n=
et/can/usb/peak_usb/pcan_usb_pro.c
>> index 263dd92..10887b0 100644
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
>> -static int pcan_usb_pro_send_req(struct peak_usb_device *dev, int r=
eq_id,
>> -				 int req_value, void *req_addr, int req_size)
>> +int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
>> +			  int req_value, void *req_addr, int req_size)
>>   {
>>   	int err;
>>   	u8 req_type;
>> @@ -333,8 +325,6 @@ static int pcan_usb_pro_send_req(struct peak_usb=
_device *dev, int req_id,
>>   	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
>>   		return 0;
>>  =20
>> -	memset(req_addr, '\0', req_size);
>> -
>>   	req_type =3D USB_TYPE_VENDOR | USB_RECIP_OTHER;
>>  =20
>>   	switch (req_id) {
>> @@ -345,6 +335,7 @@ static int pcan_usb_pro_send_req(struct peak_usb=
_device *dev, int req_id,
>>   	default:
>>   		p =3D usb_rcvctrlpipe(dev->udev, 0);
>>   		req_type |=3D USB_DIR_IN;
>> +		memset(req_addr, '\0', req_size);
> Why is this memset moved?

It isn't part of this patch since v2.

>
>>   		break;
>>   	}
>>  =20
>> @@ -476,7 +467,7 @@ static int pcan_usb_pro_set_bittiming(struct pea=
k_usb_device *dev,
>>   	return pcan_usb_pro_set_bitrate(dev, ccbt);
>>   }
>>  =20
>> -static void pcan_usb_pro_restart_complete(struct urb *urb)
>> +void pcan_usb_pro_restart_complete(struct urb *urb)
>>   {
>>   	/* can delete usb resources */
>>   	peak_usb_async_complete(urb);
>> @@ -932,7 +923,7 @@ static int pcan_usb_pro_init(struct peak_usb_dev=
ice *dev)
>>  =20
>>   	return 0;
>>  =20
>> - err_out:
>> +err_out:
> Please don't change this.

ok.
>
>>   	kfree(bi);
>>   	kfree(fi);
>>   	kfree(usb_if);
>> @@ -978,7 +969,7 @@ static void pcan_usb_pro_free(struct peak_usb_de=
vice *dev)
>>   /*
>>    * probe function for new PCAN-USB Pro usb interface
>>    */
>> -static int pcan_usb_pro_probe(struct usb_interface *intf)
>> +int pcan_usb_pro_probe(struct usb_interface *intf)
>>   {
>>   	struct usb_host_interface *if_desc;
>>   	int i;
>> @@ -1016,6 +1007,7 @@ struct peak_usb_adapter pcan_usb_pro =3D {
>>   	.name =3D "PCAN-USB Pro",
>>   	.device_id =3D PCAN_USBPRO_PRODUCT_ID,
>>   	.ctrl_count =3D PCAN_USBPRO_CHANNEL_COUNT,
>> +	.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LIST=
ENONLY,
>>   	.clock =3D {
>>   		.freq =3D PCAN_USBPRO_CRYSTAL_HZ,
>>   	},
>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h b/drivers/n=
et/can/usb/peak_usb/pcan_usb_pro.h
>> index 32275af..1101c9c 100644
>> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
>> @@ -27,6 +27,14 @@
>>   #define PCAN_USBPRO_INFO_BL		0
>>   #define PCAN_USBPRO_INFO_FW		1
>>  =20
>> +/* PCAN-USB Pro (FD) Endpoints */
>> +#define PCAN_USBPRO_EP_CMDOUT		1
>> +#define PCAN_USBPRO_EP_CMDIN		(PCAN_USBPRO_EP_CMDOUT | USB_DIR_IN)
>> +#define PCAN_USBPRO_EP_MSGOUT_0		2
>> +#define PCAN_USBPRO_EP_MSGIN		(PCAN_USBPRO_EP_MSGOUT_0 | USB_DIR_IN=
)
>> +#define PCAN_USBPRO_EP_MSGOUT_1		3
>> +#define PCAN_USBPRO_EP_UNUSED		(PCAN_USBPRO_EP_MSGOUT_1 | USB_DIR_I=
N)
>> +
>>   /* Vendor Request value for XXX_FCT */
>>   #define PCAN_USBPRO_FCT_DRVLD		5 /* tell device driver is loaded *=
/
>>   #define PCAN_USBPRO_FCT_DRVLD_REQ_LEN	16
>>
> Marc
>

St=C3=A9phane
--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
