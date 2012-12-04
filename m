From: Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
Subject: Re: [PATCH v3] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Tue, 04 Dec 2012 23:20:47 +0100
Message-ID: <50BE773F.6060409@universalnet.at>
References: <50BE6092.9050602@universalnet.at> <50BE60AD.10307@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50BE60AD.10307-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org, gediminas-LljXPT5IorFWk0Htik3J/w@public.gmane.org
List-Id: linux-can.vger.kernel.org

Hi Wolfgang!


Am 2012-12-04 21:44, schrieb Wolfgang Grandegger:
> On 12/04/2012 09:44 PM, krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org wrote:
>> Add device driver for USB2CAN interface from "8 devices"
>> (http://www.8devices.com).
>>
>> Signed-off-by: Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
>> ---
>>   drivers/net/can/usb/Kconfig    |    6 +
>>   drivers/net/can/usb/Makefile   |    1 +
>>   drivers/net/can/usb/usb_8dev.c | 1093
>> ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 1100 insertions(+)
>>   create mode 100644 drivers/net/can/usb/usb_8dev.c
>>
>> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
>> index a4e4bee..2162233 100644
>> --- a/drivers/net/can/usb/Kconfig
>> +++ b/drivers/net/can/usb/Kconfig
>> @@ -48,4 +48,10 @@ config CAN_PEAK_USB
>>         This driver supports the PCAN-USB and PCAN-USB Pro adapters
>>         from PEAK-System Technik (http://www.peak-system.com).
>>   +config CAN_8DEV_USB
>> +    tristate "8 devices USB2CAN interface"
>> +    ---help---
>> +      This driver supports the USB2CAN interface
>> +      from 8 devices (http://www.8devices.com).
>> +
>>   endmenu
>> diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
>> index 80a2ee4..becef46 100644
>> --- a/drivers/net/can/usb/Makefile
>> +++ b/drivers/net/can/usb/Makefile
>> @@ -6,5 +6,6 @@ obj-$(CONFIG_CAN_EMS_USB) += ems_usb.o
>>   obj-$(CONFIG_CAN_ESD_USB2) += esd_usb2.o
>>   obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb.o
>>   obj-$(CONFIG_CAN_PEAK_USB) += peak_usb/
>> +obj-$(CONFIG_CAN_8DEV_USB) += usb_8dev.o
>>    ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
>
> The patch looks white-space mangled.

The patch is correct, only thunderbird hates me.
Sorry, I will try it again.

>> +        switch (state) {
>> +        case USB_8DEV_STATUSMSG_ACK:
>> +            cf->can_id |= CAN_ERR_ACK;
>> +            tx_errors = 1;
>> +            break;
>> +        case USB_8DEV_STATUSMSG_CRC:
>> +            cf->data[2] |= CAN_ERR_PROT_BIT;
>> +            rx_errors = 1;
>> +            break;
>> +        case USB_8DEV_STATUSMSG_BIT0:
>> +            cf->data[2] |= CAN_ERR_PROT_BIT0;
>> +            tx_errors = 1;
>> +            break;
>> +        case USB_8DEV_STATUSMSG_BIT1:
>> +            cf->data[2] |= CAN_ERR_PROT_BIT1;
>> +            tx_errors = 1;
>> +            break;
>> +        case USB_8DEV_STATUSMSG_FORM:
>> +            cf->data[2] |= CAN_ERR_PROT_FORM;
>> +            rx_errors = 1;
>> +            break;
>> +        case USB_8DEV_STATUSMSG_STUFF:
>> +            cf->data[2] |= CAN_ERR_PROT_STUFF;
>> +            rx_errors = 1;
>> +            break;
>> +        case USB_8DEV_STATUSMSG_OVERRUN:
>> +            cf->data[1] = (txerr > rxerr) ?
>> +                CAN_ERR_CRTL_TX_OVERFLOW :
>> +                CAN_ERR_CRTL_RX_OVERFLOW;
>> +            cf->data[2] |= CAN_ERR_PROT_OVERLOAD;
>> +            stats->rx_over_errors++;
>> +            break;
>> +        case USB_8DEV_STATUSMSG_BUSLIGHT:
>> +            cf->data[1] = (txerr > rxerr) ?
>> +                CAN_ERR_CRTL_TX_WARNING :
>> +                CAN_ERR_CRTL_RX_WARNING;
>> +            dev->can.can_stats.error_warning++;
>> +            break;
>> +        case USB_8DEV_STATUSMSG_BUSHEAVY:
>> +            cf->data[1] = (txerr > rxerr) ?
>> +                CAN_ERR_CRTL_TX_PASSIVE :
>> +                CAN_ERR_CRTL_RX_PASSIVE;
>> +            dev->can.can_stats.error_passive++;
>> +            break;
>> +        default:
>> +            cf->data[2] |= CAN_ERR_PROT_UNSPEC;
>
> Did you see this happen?

No. I'll remove default case.


regards,
Bernd

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
