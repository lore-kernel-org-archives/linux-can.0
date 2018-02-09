From: Jimmy Assarsson <extja@kvaser.com>
Subject: Re: Associate physical device with device name
Date: Fri, 9 Feb 2018 12:21:30 +0100
Message-ID: <35989d02-3134-1a84-8bec-61a863fa0bf3@kvaser.com>
References: <e8998556-5e13-1cec-f404-70c4679ca9c3@kvaser.com>
 <87ddf56f-c829-6aad-5b86-474359d282d4@pengutronix.de>
 <f1dbf319-eda5-6901-c5e4-d08651e2c1fe@kvaser.com>
 <464f89e6-82c8-a2fd-25e2-f847508b41a3@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:44765 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbeBILVe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Feb 2018 06:21:34 -0500
Received: by mail-lf0-f44.google.com with SMTP id u20so8529255lff.11
        for <linux-can@vger.kernel.org>; Fri, 09 Feb 2018 03:21:34 -0800 (PST)
In-Reply-To: <464f89e6-82c8-a2fd-25e2-f847508b41a3@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 2018-02-09 11:47, Marc Kleine-Budde wrote:
> On 02/08/2018 02:04 PM, Jimmy Assarsson wrote:
>> No, they are not identical. The EAN and serial number is stored on the
>> device.
> 
> How to read them?

It is part of the "kvaser_msg_cardinfo" command, see
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/tree/drivers/net/can/usb/kvaser_usb.c#n198

>> Which makes a single device unique. It is possible to fetch these
>> from the device. And same applies to all Kvaser CAN interfaces,
>> regardless if they are connected via USB, PCI-express or ethernet.
> What's the output of the udev when using the proper path to your device?
> 
> "udevadm info --path=/devices/pci0000:00/0000:00:14.0/usb1/1-2/ -a"

All devices with the same EAN look identical, since we do not set serial
number in the USB descriptor.

The output from "udevadm info 
--path=/sys/devices/pci0000:00/0000:00:02.1/usb1/1-4/1-4.1/1-4.1:1.0 -a"

   looking at device 
'/devices/pci0000:00/0000:00:02.1/usb1/1-4/1-4.1/1-4.1:1.0':
     KERNEL=="1-4.1:1.0"
     SUBSYSTEM=="usb"
     DRIVER=="kvaser_usb"
     ATTR{authorized}=="1"
     ATTR{bAlternateSetting}==" 0"
     ATTR{bInterfaceClass}=="00"
     ATTR{bInterfaceNumber}=="00"
     ATTR{bInterfaceProtocol}=="00"
     ATTR{bInterfaceSubClass}=="00"
     ATTR{bNumEndpoints}=="02"
     ATTR{supports_autosuspend}=="0"

   looking at parent device 
'/devices/pci0000:00/0000:00:02.1/usb1/1-4/1-4.1':
     KERNELS=="1-4.1"
     SUBSYSTEMS=="usb"
     DRIVERS=="usb"
     ATTRS{authorized}=="1"
     ATTRS{avoid_reset_quirk}=="0"
     ATTRS{bConfigurationValue}=="1"
     ATTRS{bDeviceClass}=="ff"
     ATTRS{bDeviceProtocol}=="00"
     ATTRS{bDeviceSubClass}=="00"
     ATTRS{bMaxPacketSize0}=="64"
     ATTRS{bMaxPower}=="132mA"
     ATTRS{bNumConfigurations}=="1"
     ATTRS{bNumInterfaces}==" 1"
     ATTRS{bcdDevice}=="0001"
     ATTRS{bmAttributes}=="c0"
     ATTRS{busnum}=="1"
     ATTRS{configuration}==""
     ATTRS{devnum}=="26"
     ATTRS{devpath}=="4.1"
     ATTRS{idProduct}=="0123"
     ATTRS{idVendor}=="0bfd"
     ATTRS{ltm_capable}=="no"
     ATTRS{manufacturer}=="Kvaser AB"
     ATTRS{maxchild}=="0"
     ATTRS{product}=="Kvaser USBcan Light"
     ATTRS{quirks}=="0x0"
     ATTRS{removable}=="unknown"
     ATTRS{speed}=="480"
     ATTRS{urbnum}=="17"
     ATTRS{version}==" 2.00"
