From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Wed, 05 Dec 2012 08:24:09 +0100
Message-ID: <50BEF699.8000402@grandegger.com>
References: <50BE6092.9050602@universalnet.at> <50BE60AD.10307@grandegger.com> <50BE773F.6060409@universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:60478 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab2LEHYY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Dec 2012 02:24:24 -0500
In-Reply-To: <50BE773F.6060409@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <krumboeck@universalnet.at>
Cc: linux-can@vger.kernel.org, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

On 12/04/2012 11:20 PM, Bernd Krumboeck wrote:
> Hi Wolfgang!
> 
> 
> Am 2012-12-04 21:44, schrieb Wolfgang Grandegger:
>> On 12/04/2012 09:44 PM, krumboeck@universalnet.at wrote:
>>> Add device driver for USB2CAN interface from "8 devices"
>>> (http://www.8devices.com).
>>>
>>> Signed-off-by: Bernd Krumboeck <krumboeck@universalnet.at>
>>> ---
>>>   drivers/net/can/usb/Kconfig    |    6 +
>>>   drivers/net/can/usb/Makefile   |    1 +
>>>   drivers/net/can/usb/usb_8dev.c | 1093
>>> ++++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 1100 insertions(+)
>>>   create mode 100644 drivers/net/can/usb/usb_8dev.c
>>>
>>> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
>>> index a4e4bee..2162233 100644
>>> --- a/drivers/net/can/usb/Kconfig
>>> +++ b/drivers/net/can/usb/Kconfig
>>> @@ -48,4 +48,10 @@ config CAN_PEAK_USB
>>>         This driver supports the PCAN-USB and PCAN-USB Pro adapters
>>>         from PEAK-System Technik (http://www.peak-system.com).
>>>   +config CAN_8DEV_USB
>>> +    tristate "8 devices USB2CAN interface"
>>> +    ---help---
>>> +      This driver supports the USB2CAN interface
>>> +      from 8 devices (http://www.8devices.com).
>>> +
>>>   endmenu
>>> diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
>>> index 80a2ee4..becef46 100644
>>> --- a/drivers/net/can/usb/Makefile
>>> +++ b/drivers/net/can/usb/Makefile
>>> @@ -6,5 +6,6 @@ obj-$(CONFIG_CAN_EMS_USB) += ems_usb.o
>>>   obj-$(CONFIG_CAN_ESD_USB2) += esd_usb2.o
>>>   obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb.o
>>>   obj-$(CONFIG_CAN_PEAK_USB) += peak_usb/
>>> +obj-$(CONFIG_CAN_8DEV_USB) += usb_8dev.o
>>>    ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
>>
>> The patch looks white-space mangled.
> 
> The patch is correct, only thunderbird hates me.
> Sorry, I will try it again.

I use the add-on "Toggle Word Wrap". Anyway, git send-email is better.

>>> +        switch (state) {
>>> +        case USB_8DEV_STATUSMSG_ACK:
>>> +            cf->can_id |= CAN_ERR_ACK;
>>> +            tx_errors = 1;
>>> +            break;
>>> +        case USB_8DEV_STATUSMSG_CRC:
>>> +            cf->data[2] |= CAN_ERR_PROT_BIT;
>>> +            rx_errors = 1;
>>> +            break;
>>> +        case USB_8DEV_STATUSMSG_BIT0:
>>> +            cf->data[2] |= CAN_ERR_PROT_BIT0;
>>> +            tx_errors = 1;
>>> +            break;
>>> +        case USB_8DEV_STATUSMSG_BIT1:
>>> +            cf->data[2] |= CAN_ERR_PROT_BIT1;
>>> +            tx_errors = 1;
>>> +            break;
>>> +        case USB_8DEV_STATUSMSG_FORM:
>>> +            cf->data[2] |= CAN_ERR_PROT_FORM;
>>> +            rx_errors = 1;
>>> +            break;
>>> +        case USB_8DEV_STATUSMSG_STUFF:
>>> +            cf->data[2] |= CAN_ERR_PROT_STUFF;
>>> +            rx_errors = 1;
>>> +            break;
>>> +        case USB_8DEV_STATUSMSG_OVERRUN:
>>> +            cf->data[1] = (txerr > rxerr) ?
>>> +                CAN_ERR_CRTL_TX_OVERFLOW :
>>> +                CAN_ERR_CRTL_RX_OVERFLOW;
>>> +            cf->data[2] |= CAN_ERR_PROT_OVERLOAD;
>>> +            stats->rx_over_errors++;
>>> +            break;
>>> +        case USB_8DEV_STATUSMSG_BUSLIGHT:
>>> +            cf->data[1] = (txerr > rxerr) ?
>>> +                CAN_ERR_CRTL_TX_WARNING :
>>> +                CAN_ERR_CRTL_RX_WARNING;
>>> +            dev->can.can_stats.error_warning++;
>>> +            break;
>>> +        case USB_8DEV_STATUSMSG_BUSHEAVY:
>>> +            cf->data[1] = (txerr > rxerr) ?
>>> +                CAN_ERR_CRTL_TX_PASSIVE :
>>> +                CAN_ERR_CRTL_RX_PASSIVE;
>>> +            dev->can.can_stats.error_passive++;
>>> +            break;
>>> +        default:
>>> +            cf->data[2] |= CAN_ERR_PROT_UNSPEC;
>>
>> Did you see this happen?
> 
> No. I'll remove default case.

I would prefer adding a netdev_warn message here. Sending an empty bus
error message upstream is ok as we konw that is an error.

Wolfgang.

