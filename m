From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 7/7 v9] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Mon, 26 Jan 2015 22:04:33 +0100
Message-ID: <54C6ABE1.8000504@hartkopp.net>
References: <1422009085-11858-1-git-send-email-s.grosjean@peak-system.com> <1422009085-11858-8-git-send-email-s.grosjean@peak-system.com> <54C64633.9080204@pengutronix.de> <54C65912.5020309@peak-system.com> <54C659C0.4040207@pengutronix.de> <54C66063.9050500@peak-system.com> <54C6628D.7010902@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:54366 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058AbbAZVE5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Jan 2015 16:04:57 -0500
In-Reply-To: <54C6628D.7010902@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org

On 26.01.2015 16:51, Marc Kleine-Budde wrote:
> On 01/26/2015 04:42 PM, Stephane Grosjean wrote:
>> Le 26/01/2015 16:14, Marc Kleine-Budde a =C3=A9crit :
>>> On 01/26/2015 04:11 PM, Stephane Grosjean wrote:
>>>> Hi Mark,
>>>>
>>>> Well, the ISO/non-ISO feature is not available for all USB devices=
 and
>>>> is currently always under development.
>>>> So, we think that it's a bit early to add it in the peak_usb drive=
r.
>>> Which mode do the controller support then?
>>>
>>> Marc
>>>
>> Current versions of the fw run in non-ISO mode.
>
> So we have to set .ctrlmode =3D CAN_CTRLMODE_FD_NON_ISO, analogue to
>
>      6cfda7fbebe8 can: m_can: tag current CAN FD controllers as non-I=
SO

Ack.

>
> e.g.:
>
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/n=
et/can/usb/peak_usb/pcan_usb_core.c
> index b2f2694d7d5b..d00bc094b91d 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -799,6 +799,7 @@ static int peak_usb_create_dev(struct peak_usb_ad=
apter *peak_usb_adapter,
>          dev->can.do_set_data_bittiming =3D peak_usb_set_data_bittimi=
ng;
>          dev->can.do_set_mode =3D peak_usb_set_mode;
>          dev->can.do_get_berr_counter =3D peak_usb_adapter->do_get_be=
rr_counter;
> +       dev->can.ctrlmode =3D peak_usb_adapter->ctrlmode;
>          dev->can.ctrlmode_supported =3D peak_usb_adapter->ctrlmode_s=
upported;
>
>          netdev->netdev_ops =3D &peak_usb_netdev_ops;
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/n=
et/can/usb/peak_usb/pcan_usb_core.h
> index 7c213b26f3fb..a8a71ebaa0b4 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
> @@ -46,6 +46,7 @@ struct peak_usb_device;
>   struct peak_usb_adapter {
>          char *name;
>          u32 device_id;
> +       u32 ctrlmode;
>          u32 ctrlmode_supported;
>          struct can_clock clock;
>          const struct can_bittiming_const bittiming_const;
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net=
/can/usb/peak_usb/pcan_usb_fd.c
> index 8aad8f79fc1b..73c4be840dc7 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -960,6 +960,7 @@ struct peak_usb_adapter pcan_usb_fd =3D {
>          .name =3D "PCAN-USB FD",
>          .device_id =3D PCAN_USBFD_PRODUCT_ID,
>          .ctrl_count =3D PCAN_USBFD_CHANNEL_COUNT,
> +       .ctrlmode =3D CAN_CTRLMODE_FD_NON_ISO,
>          .ctrlmode_supported =3D CAN_CTRLMODE_FD |
>                          CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTEN=
ONLY,
>          .clock =3D {
> @@ -1028,6 +1029,7 @@ struct peak_usb_adapter pcan_usb_pro_fd =3D {
>          .name =3D "PCAN-USB Pro FD",
>          .device_id =3D PCAN_USBPROFD_PRODUCT_ID,
>          .ctrl_count =3D PCAN_USBPROFD_CHANNEL_COUNT,
> +       .ctrlmode =3D CAN_CTRLMODE_FD_NON_ISO,
>          .ctrlmode_supported =3D CAN_CTRLMODE_FD |
>                          CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTEN=
ONLY,
>          .clock =3D {
>
> Correct, Oliver?

No.

I assume it is better to set the ctrlmode directly in the struct can_pr=
iv=20
element in  pcan_usb_fd_init() after retrieving the firmware version.

IMO it doesn't make sense to transport this info through the mechanic a=
bove=20
which mostly initialized quasi constant settings for the adapter.


Btw.

Should

+/* describes the PCAN-USB Pro FD adapter */
+struct peak_usb_adapter pcan_usb_pro_fd =3D {

be

+/* describes the PCAN-USB Pro FD adapter */
+const struct peak_usb_adapter pcan_usb_pro_fd =3D {

???

Cheers from Stockholm,
Oliver

