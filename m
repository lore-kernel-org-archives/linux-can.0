From: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Subject: Re: Getting manufacturer/product name for CAN interface
Date: Tue, 16 Jan 2018 22:47:12 +0100
Message-ID: <6dd00020-05b9-65eb-73a1-880cbc23f4c2@gmx.de>
References: <c3904508-14b9-1ffb-8507-9196fa193f56@gmx.de>
 <955344be-5991-5de9-a705-5f2e480c765d@grandegger.com>
 <5c9a4542-aa3d-c54f-7f83-d7cd3f594a65@gmx.de>
 <18d6c6fc-fcc2-34d9-a98a-1d2ae4d1e0b1@pengutronix.de>
 <q10u44.otcmiv.1hge1d1-qmf@gmx.com>
 <baddf3da-d44b-d326-1289-7cd6d0f387a4@gmx.de>
 <1adef5d5-8607-7c50-38e6-80135094c778@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:63352 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752199AbeAPVrU (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 16 Jan 2018 16:47:20 -0500
In-Reply-To: <1adef5d5-8607-7c50-38e6-80135094c778@pengutronix.de>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Marcel.Birthelmer@microchip.com, wg@grandegger.com

Hi Marc,

Am 15.01.2018 um 11:02 schrieb Marc Kleine-Budde:
> On 01/13/2018 04:54 PM, André Hartmann wrote:
>> Hi all,
>>
>> and a (late) Happy New Year!
>>
>> I finally managed to finish my patch over christmas, which is now
>> included in QtSerialBus [1]. Thanks for all your help on this topic!
>>
>> To summarize, I was able to get the CAN adapter description and the CAN
>> channel by parsing the SysFS.
> 
> Why not use libudev?

So far all I needed was in sysfs, and I didn't need an extra dependecy. 
And honestly, I did not even think about libudev.

Thanks for your pointer, I'll have a look.

Regards,
André

> 
>> It would have been nice to extract the adapters serial number and/or an
>> user-programmable device ID too (I know that Peak and SYS-TEC have such
>> features), but I did not find such a property in the SysFS tree.
>>
>> So if you have one more hot tip for me ... I'd appreciate it.
> 
> At least with my candelight and udev I can read the serial number and
> other information. I suppose it's accessible via libudev somehow.
> 
>> udevadm info --path=/devices/pci0000:00/0000:00:14.0/usb1/1-2/
>> P: /devices/pci0000:00/0000:00:14.0/usb1/1-2
>> N: bus/usb/001/095
>> E: BUSNUM=001
>> E: DEVNAME=/dev/bus/usb/001/095
>> E: DEVNUM=095
>> E: DEVPATH=/devices/pci0000:00/0000:00:14.0/usb1/1-2
>> E: DEVTYPE=usb_device
>> E: DRIVER=usb
>> E: ID_BUS=usb
>> E: ID_MODEL=candleLight_USB_to_CAN_adapter
>> E: ID_MODEL_ENC=candleLight\x20USB\x20to\x20CAN\x20adapter
>> E: ID_MODEL_ID=606f
>> E: ID_REVISION=0000
>> E: ID_SERIAL=bytewerk_candleLight_USB_to_CAN_adapter_000000000002
>> E: ID_SERIAL_SHORT=000000000002
>> E: ID_USB_INTERFACES=:ffffff:fe0101:
>> E: ID_VENDOR=bytewerk
>> E: ID_VENDOR_ENC=bytewerk
>> E: ID_VENDOR_FROM_DATABASE=OpenMoko, Inc.
>> E: ID_VENDOR_ID=1d50
>> E: MAJOR=189
>> E: MINOR=94
>> E: PRODUCT=1d50/606f/0
>> E: SUBSYSTEM=usb
>> E: TYPE=0/0/0
>> E: USEC_INITIALIZED=288243366799
> 
> Marc
> 

