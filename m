From: =?iso-8859-1?Q?=22Bernd_Krumb=F6ck=22?= <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
Subject: Re: [PATCH v8] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Sat, 15 Dec 2012 11:12:08 +0100
Message-ID: <525609baa6c4f07fdacc5089b7de5e4d.squirrel@webmail.universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org, gediminas-LljXPT5IorFWk0Htik3J/w@public.gmane.org
List-Id: linux-can.vger.kernel.org

This informations could be useful for configuration scripts. Various
drivers do the same.

regards,
Bernd



2012/12/15 Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>

    On 15.12.2012 07:53, Bernd Krumboeck wrote:

    > +++ b/Documentation/ABI/testing/sysfs-driver-usb_8dev
    > @@ -0,0 +1,13 @@
    > +What:                /sys/bus/usb/devices/<busnum>-<devnum>:<config
num>.<interface num>/firmware
    > +Date:                December 2012
    > +Contact:     Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
    > +Description:
    > +             Returns the firmware version in the form
"<major>.<minor>".
    > +             This file is readonly.
    > +
    > +What:                /sys/bus/usb/devices/<busnum>-<devnum>:<config
num>.<interface num>/hardware
    > +Date:                December 2012
    > +Contact:     Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
    > +Description:
    > +             Returns the hardware version in the form
"<major>.<minor>".
    > +             This file is readonly.


    Hello Bernd,

    sorry but probably i missed the discussion about this point:

    Why do your create some extra sysfs entries for plain static
information that
    could be retrieved from the syslog too?

    E.g. when attaching the PCAN USB, i get this:

    usb 2-1.3: new full-speed USB device number 6 using ehci-pci
    usb 2-1.3: New USB device found, idVendor=0c72, idProduct=000c
    usb 2-1.3: New USB device strings: Mfr=0, Product=3, SerialNumber=0
    usb 2-1.3: Product: VER1:PEAK
    VER2:02.8.01
    DAT :06.05.2004
    TIME:09:35:37
                                 ...
    peak_usb 2-1.3:1.0: PEAK-System PCAN-USB adapter hwrev 28 serial
FFFFFFFF (1 channel)
    peak_usb 2-1.3:1.0 can2: attached to PCAN-USB channel 0 (device 67)
    usbcore: registered new interface driver peak_usb

    Don't you think it's a better idea to add an additional line to the
syslog
    telling about this *static* hw/sw information than adding the extra
complexity
    and documentation for the sysfs handling?

    Regards,
    Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
