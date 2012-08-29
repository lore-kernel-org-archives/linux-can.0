From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: usb-can device
Date: Wed, 29 Aug 2012 12:55:02 +0200
Message-ID: <503DF506.5060204@hartkopp.net>
References: <1345996339.6610.10.camel@slaptop>  <503A4E9B.9060308@pengutronix.de> <503B1198.3010506@hartkopp.net> <1346164259.2466.7.camel@slaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:51279 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab2H2KzF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 29 Aug 2012 06:55:05 -0400
In-Reply-To: <1346164259.2466.7.camel@slaptop>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 28.08.2012 16:30, Max S. wrote:

> I've been reading the USB CDC specification, but i have to admit, its
> all rather dry material.
> 


Hm - yes. You are right ... i've looked myself. It's not very intuitive %-)

> I'm feeling a little lost developing on both sides of the puzzle. Can
> you provide me with a kind of lsusb printout of what the usb device is
> supposed to look like?
> 
> what I've got right now is a CDC virtual com example, figured i could
> modify it.


Better try to follow examples from cdc_ether, like this one:

https://bbs.archlinux.org/viewtopic.php?id=144056

Btw. a cdc_can driver would be located in linux/drivers/net/usb.

I would suggest to look into cdc-phonet.c and cdc_ncm.c which are doing
similar things as we need, e.g. PF_PHONET -> cdc-phonet => PF_CAN -> cdc_can

Regards,
Oliver


> 
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            2 Communications
>   bDeviceSubClass         0 
>   bDeviceProtocol         0 
>   bMaxPacketSize0        64
>   idVendor           0x03eb Atmel Corp.
>   idProduct          0x2404 
>   bcdDevice            1.00
>   iManufacturer           1 ATMEL ASF
>   iProduct                2 CDC Virtual Com
>   iSerial                 0 
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           67
>     bNumInterfaces          2
>     bConfigurationValue     1
>     iConfiguration          0 
>     bmAttributes         0xc0
>       Self Powered
>     MaxPower              100mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         2 Communications
>       bInterfaceSubClass      2 Abstract (modem)
>       bInterfaceProtocol      1 AT-commands (v.25ter)
>       iInterface              0 
>       CDC Header:
>         bcdCDC               1.10
>       CDC ACM:
>         bmCapabilities       0x02
>           line coding and serial state
>       CDC Union:
>         bMasterInterface        0
>         bSlaveInterface         1 
>       CDC Call Management:
>         bmCapabilities       0x03
>           call management
>           use DataInterface
>         bDataInterface          1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval              16
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass        10 CDC Data
>       bInterfaceSubClass      0 Unused
>       bInterfaceProtocol      0 
>       iInterface              0 
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x02  EP 2 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               0
> Device Status:     0x0001
>   Self Powered
> 
> Max S.
> 


