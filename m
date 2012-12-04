From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: [PATCH v2] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Tue, 04 Dec 2012 23:09:24 +0100
Message-ID: <50BE7494.90603@universalnet.at>
References: <50BBF73F.9080208@universalnet.at>    <50BC5ECB.9070206@grandegger.com> <50BD0C52.6010606@universalnet.at>    <50BD0858.3020707@grandegger.com> <50BDCD1B.2010306@pengutronix.de> <c003ee227fe9e5a754a78fd8575ce977.squirrel@webmail.universalnet.at> <50BE5B69.3040801@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:40669 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753483Ab2LDVJj (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 4 Dec 2012 16:09:39 -0500
In-Reply-To: <50BE5B69.3040801@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Am 2012-12-04 21:22, schrieb Marc Kleine-Budde:
> On 12/04/2012 07:44 PM, "Bernd Krumb=F6ck" wrote:
>>> On 12/03/2012 09:15 PM, Wolfgang Grandegger wrote:
>>>> On 12/03/2012 09:32 PM, krumboeck@universalnet.at wrote:
>>>>> Hi Wolfgang!
>>>>>
>>>>>>
>>>>>> And please also drop the remaining sysfs files for firmware and
>>>>>> hardware. I thinks it's enough that the versions are printed whe=
n the
>>>>>> device is probed.
>>>>>
>>>>> Systemadministrators often use versions for configuration scripts=
=2E
>>>>> If you insist I will remove.
>>>>
>>>> Marc?
>>>
>>> Are these values exported via lsusb -v (e.g. iSerial)?
>>>
>>
>> No, I have not seen yet.
>>
>>
>> Device Descriptor:
>>    bLength                18
>>    bDescriptorType         1
>>    bcdUSB               2.00
>>    bDeviceClass          255 Vendor Specific Class
>>    bDeviceSubClass       255 Vendor Specific Subclass
>>    bDeviceProtocol         0
>>    bMaxPacketSize0        64
>>    idVendor           0x0483 SGS Thomson Microelectronics
>>    idProduct          0x1234
>>    bcdDevice            1.00
>>    iManufacturer           1
>>    iProduct                2
>>    iSerial                 3
>      ^^^^^^^^^^^^^^^^^^^^^^^^^
>
> [...]
>
>> dmesg:
>> [11708.644014] usb 6-2: new full-speed USB device number 2 using uhc=
i_hcd
>> [11708.820030] usb 6-2: New USB device found, idVendor=3D0483, idPro=
duct=3D1234
>> [11708.820034] usb 6-2: New USB device strings: Mfr=3D1, Product=3D2=
,
>> SerialNumber=3D3
>> [11708.820036] usb 6-2: Product: USB2CAN converter
>> [11708.820038] usb 6-2: Manufacturer: edevices
>> [11708.820041] usb 6-2: SerialNumber: ED000202
>                                          ^^^^^^^^

This serial number is printed on the device.

>
> Does these numbers correspond to the hardware and firmware revision?

No.

firmware: 1.4
hardware: 1.0


best regards,
Bernd

