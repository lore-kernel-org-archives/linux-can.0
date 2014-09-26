From: Brian Gregory <bdg@theptrgroup.com>
Subject: Re: AW: ESD CAN-USB/2 Linux Mint 16 kernel 3.11
Date: Fri, 26 Sep 2014 07:21:30 -0400
Message-ID: <D04AC383.21199%bdg@theptrgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.theptrgroup.com ([71.178.251.9]:60224 "EHLO
	mail.theptrgroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbaIZLVe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 26 Sep 2014 07:21:34 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas =?ISO-8859-1?B?S/ZycGVy?= <Thomas.Koerper@esd.eu>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Thomas,

Thanks for your response. I did have it working for Ubuntu 10.04 (kerne=
l
2.6).
That said, I think the driver came from ESD.

I will look into it and post the details to the list shortly.

-Brian

On 9/26/14 1:35 AM, "Thomas K=F6rper" <Thomas.Koerper@esd.eu> wrote:

>Hi Brian,
>
>the dmesg output shows that it's actually a "CAN USB/Mini", not a CAN
>USB/2. (The label at the back shows CAN USB instead of CAN USB/2)
>
>No SocketCAN driver for this device exists, sorry.
>
>
>Regards,
>    Thomas
>
>
>-----Urspr=FCngliche Nachricht-----
>Von: linux-can-owner@vger.kernel.org
>[mailto:linux-can-owner@vger.kernel.org] Im Auftrag von Brian Gregory
>Gesendet: Donnerstag, 25. September 2014 19:02
>An: linux-can@vger.kernel.org
>Betreff: ESD CAN-USB/2 Linux Mint 16 kernel 3.11
>
>I am having trouble trying to get this to work and I have been unable =
to
>find a relevant email on the list.
>
>I am running Linux Mint 16 64bit (kernel 3.11) and I have confirmed th=
at
>can-dev and esd_usb2 support is configured as kernel modules.
>I have loaded these modules and confirmed with lsmod:
>
>slcan 13049 0
>vcan 12726 0
>can_dev 20692 4 esd_usb2,ems_usb,peak_usb,usb_8dev
>can_raw 17120 0
>can 36503 1 can_raw
>
>The device (ESD CAN-USB/2) is recognized when plugged in (dmesg output=
):
>
>[ 1672.932148] usb 4-2: new full-speed USB device number 2 using uhci_=
hcd
>[ 1673.100268] usb 4-2: New USB device found, idVendor=3D0ab4,
>idProduct=3D0001 [ 1673.100281] usb 4-2: New USB device strings: Mfr=3D=
4,
>Product=3D22,
>SerialNumber=3D46
>[ 1673.100289] usb 4-2: Product: CAN-USB 543 [ 1673.100296] usb 4-2:
>Manufacturer: esd-gmbh [ 1673.100303] usb 4-2: SerialNumber: GL002971
>
>Although there is no output indicating that the /sys/class/net/can0 no=
de
>is created, and there are no can# nodes under /sys/class/net.
>I have confirmed that the virtual can bus works via the tutorial.
>
>What am I missing?
>
>Thanks,
>Brian Gregory
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-can" i=
n
>the body of a message to majordomo@vger.kernel.org More majordomo info=
 at
> http://vger.kernel.org/majordomo-info.html
>
>


