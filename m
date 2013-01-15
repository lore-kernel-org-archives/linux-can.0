From: =?iso-8859-1?Q?=22Bernd_Krumb=F6ck=22?= <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
Subject: Re: [PATCH v9] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Tue, 15 Jan 2013 23:05:36 +0100
Message-ID: <ae58b62ae76e6261e66774c458012a87.squirrel@webmail.universalnet.at>
References: <1355641315-15739-1-git-send-email-krumboeck@universalnet.at>
    <50F471AC.50902@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50F471AC.50902-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
Cc: Bernd Krumboeck <b.krumboeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org, gediminas-LljXPT5IorFWk0Htik3J/w@public.gmane.org, Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

Hi Oliver!

> Hi Bernd,
>
> On 16.12.2012 08:01, Bernd Krumboeck wrote:
>
>> Add device driver for USB2CAN interface from "8 devices"
>> (http://www.8devices.com).
>>
>> changes since v8:
>> * remove all sysfs files
>>
>> changes since v7:
>> * add sysfs documentation
>> * fix minor styling issue
>> * fixed can state for passive mode
>> * changed handling for crc errors
>>
>> changes since v6:
>> * changed some variable types to big endian equivalent
>> * small cleanups
>>
>> changes since v5:
>> * unlock mutex on error
>>
>> changes since v4:
>> * removed FSF address
>> * renamed struct usb_8dev
>> * removed unused variable free_slots
>> * replaced some _to_cpu functions with pointer equivalent
>> * fix return value for usb_8dev_set_mode
>> * handle can errors with separate function
>> * fix overrun error handling
>> * rewrite error handling for usb_8dev_start_xmit
>> * fix urb submit in usb_8dev_start
>> * various small fixes
>>
>> Signed-off-by: Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
>> Acked-by: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
>
>
> Tested-by: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
>
> Fortunately i got my adapter today ...
>
> [   52.984254] usb 2-1.4: new full-speed USB device number 6 using
> ehci-pci
> [   53.078690] usb 2-1.4: New USB device found, idVendor=0483,
> idProduct=1234
> [   53.078698] usb 2-1.4: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [   53.078703] usb 2-1.4: Product: USB2CAN converter
> [   53.078707] usb 2-1.4: Manufacturer: edevices
> [   53.078711] usb 2-1.4: SerialNumber: ED000212
> [   53.111990] usb_8dev 2-1.4:1.0 can2: firmware: 1.4, hardware: 255.255
> [   53.112090] usbcore: registered new interface driver usb_8dev
>
> Looks good :-)

:-)

> When detaching the device from the CAN bus when sending/receiving CAN
> traffic
> i got these dmesg infos:
>
> [  960.047130] usb_8dev 2-1.4:1.0 can2: Unknown status/error message (0)
> [  976.544343] usb_8dev 2-1.4:1.0 can2: Unknown status/error message (0)
>
> Did you check these kind of 'unfriendly user' tests?

Not really. At least I don't know what the driver should do. Let me know
if you have some suggestions.

> E.g. pulling the USB under receive load brings this output:
>
> [ 1343.786427] usb_8dev 2-1.4:1.0 can2: Rx URB aborted (-32)
> [ 1343.786640] usb_8dev 2-1.4:1.0 can2: Rx URB aborted (-32)
>
> (..) another 344 of these URB aborted messages

a bit much...

Maybe we should suppress this messages?

> [ 1343.872620] usb_8dev 2-1.4:1.0 can2: Rx URB aborted (-32)
> [ 1343.872867] usb_8dev 2-1.4:1.0 can2: Rx URB aborted (-32)
> [ 1343.873124] usb_8dev 2-1.4:1.0 can2: Rx URB aborted (-32)
> [ 1343.873269] usb 2-1.4: USB disconnect, device number 6
> [ 1343.873363] usb_8dev 2-1.4:1.0 can2: Rx URB aborted (-32)
> [ 1343.875259] usb_8dev 2-1.4:1.0 can2: device disconnected
> [ 1343.875366] usb_8dev 2-1.4:1.0 can2: sending command message failed
> [ 1343.875371] usb_8dev 2-1.4:1.0 can2: couldn't stop device
>
>
> Tomorrow i will do some more testing.

Thanks!

> The LED handling of the device is really fine:
>
> - interface down -> red
> - interface up -> green
> - interface error passive -> green blinking
>
> Regards,
> Oliver
>

regards,
Bernd

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
