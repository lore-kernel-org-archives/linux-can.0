From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: usb_8dev: USB Protocoll available?
Date: Sat, 15 Dec 2012 08:09:26 +0100
Message-ID: <50CC2226.10107@universalnet.at>
References: <20683.22879.172661.430971@elektron.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:38529 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750896Ab2LOHLG (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sat, 15 Dec 2012 02:11:06 -0500
In-Reply-To: <20683.22879.172661.430971@elektron.ikp.physik.tu-darmstadt.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: linux-can@vger.kernel.org

Hello Uwe!


Maybe this will help you (lsusb -v):


Bus 006 Device 006: ID 0483:1234 SGS Thomson Microelectronics
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass          255 Vendor Specific Class
   bDeviceSubClass       255 Vendor Specific Subclass
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x0483 SGS Thomson Microelectronics
   idProduct          0x1234
   bcdDevice            1.00
   iManufacturer           1 edevices
   iProduct                2 USB2CAN converter
   iSerial                 3 ED000202
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           46
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0x80
       (Bus Powered)
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           4
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass    255 Vendor Specific Subclass
       bInterfaceProtocol    255 Vendor Specific Protocol
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x02  EP 2 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0019  1x 25 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x04  EP 4 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0019  1x 25 bytes
         bInterval               0
Device Status:     0x0000
   (Bus Powered)


regards,
Bernd


Am 2012-12-14 17:52, schrieb Uwe Bonnes:
>
> Hello,
>
> is there some document describing the protocoll used for the usb_8dev? I
> have STM32 hardware with USB and CAN connected and think about writing some
> firmware compatible with some existing adapter.
>
> Otherwise, are the github projects
>
> saeugetier / usb2can
>
> shackspace / usb2can
>
> for usb to can hardware related to this driver??
>
> Thanks
>

