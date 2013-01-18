From: =?iso-8859-1?Q?=22Bernd_Krumb=F6ck=22?= <krumboeck@universalnet.at>
Subject: Re: [PATCH v10] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Fri, 18 Jan 2013 23:13:57 +0100
Message-ID: <68a22096310608794036b3cb26018bce.squirrel@webmail.universalnet.at>
References: <1358519049-13551-1-git-send-email-krumboeck@universalnet.at>
    <50F9AE66.8010602@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:33127 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751574Ab3ARWOG (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 18 Jan 2013 17:14:06 -0500
In-Reply-To: <50F9AE66.8010602@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com, Bernd Krumboeck <krumboeck@universalnet.at>

> On 18.01.2013 15:24, Bernd Krumboeck wrote:
>
>> Add device driver for USB2CAN interface from "8 devices"
>> (http://www.8devices.com).
>
>>
>
>> Signed-off-by: Bernd Krumboeck <krumboeck@universalnet.at>
>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>
>
>
> You can add my
>
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
>
> in the v11 post :-)
>
> I have only one small cosmetic change request:
>
> Please remove/split up this #define block.
>
>
>> +
>> +/* bittiming constants */
>> +#define USB_8DEV_ABP_CLOCK		32000000
>
>
> /* device CAN clock */
> #define USB_8DEV_ABP_CLOCK		32000000
>
>> +#define USB_8DEV_BAUD_MANUAL		0x09
>
>
> -> moved down, see below
>
>> +#define USB_8DEV_TSEG1_MIN		1
>> +#define USB_8DEV_TSEG1_MAX		16
>> +#define USB_8DEV_TSEG2_MIN		1
>> +#define USB_8DEV_TSEG2_MAX		8
>> +#define USB_8DEV_SJW_MAX		4
>> +#define USB_8DEV_BRP_MIN		1
>> +#define USB_8DEV_BRP_MAX		1024
>> +#define USB_8DEV_BRP_INC		1
>
>
> It makes no sense to define these values when you can specify them
> directly in
> the const struct can_bittiming_const below.
>
> This is usual and does not reduce the readability.
>
>> +
>> +/* setup flags */
>> +#define USB_8DEV_SILENT			0x01
>> +#define USB_8DEV_LOOPBACK		0x02
>> +#define USB_8DEV_DISABLE_AUTO_RESTRANS	0x04
>> +#define USB_8DEV_STATUS_FRAME		0x08
>> +
>> +/* commands */
>> +enum usb_8dev_cmd {
>> +	USB_8DEV_RESET = 1,
>> +	USB_8DEV_OPEN,
>> +	USB_8DEV_CLOSE,
>> +	USB_8DEV_SET_SPEED,
>> +	USB_8DEV_SET_MASK_FILTER,
>> +	USB_8DEV_GET_STATUS,
>> +	USB_8DEV_GET_STATISTICS,
>> +	USB_8DEV_GET_SERIAL,
>> +	USB_8DEV_GET_SOFTW_VER,
>> +	USB_8DEV_GET_HARDW_VER,
>> +	USB_8DEV_RESET_TIMESTAMP,
>> +	USB_8DEV_GET_SOFTW_HARDW_VER
>> +};
>
>
> /* command options */
> #define USB_8DEV_BAUD_MANUAL		0x09
>
>> +
>> +#define USB_8DEV_CMD_START		0x11
>> +#define USB_8DEV_CMD_END		0x22
>> +
>
> (..)
>
>> +
>> +static const struct can_bittiming_const usb_8dev_bittiming_const = {
>> +	.name = "usb_8dev",
>> +	.tseg1_min = USB_8DEV_TSEG1_MIN,
>> +	.tseg1_max = USB_8DEV_TSEG1_MAX,
>> +	.tseg2_min = USB_8DEV_TSEG2_MIN,
>> +	.tseg2_max = USB_8DEV_TSEG2_MAX,
>> +	.sjw_max = USB_8DEV_SJW_MAX,
>> +	.brp_min = USB_8DEV_BRP_MIN,
>> +	.brp_max = USB_8DEV_BRP_MAX,
>> +	.brp_inc = USB_8DEV_BRP_INC,
>> +};
>> +
>
>
> insert values directly here.
>
> Regards,
> Oliver
>
>

Thank you.

regards,
Bernd

