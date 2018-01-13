From: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Subject: Re: Getting manufacturer/product name for CAN interface
Date: Sat, 13 Jan 2018 16:54:43 +0100
Message-ID: <baddf3da-d44b-d326-1289-7cd6d0f387a4@gmx.de>
References: <c3904508-14b9-1ffb-8507-9196fa193f56@gmx.de>
 <955344be-5991-5de9-a705-5f2e480c765d@grandegger.com>
 <5c9a4542-aa3d-c54f-7f83-d7cd3f594a65@gmx.de>
 <18d6c6fc-fcc2-34d9-a98a-1d2ae4d1e0b1@pengutronix.de>
 <q10u44.otcmiv.1hge1d1-qmf@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:60448 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755044AbeAMPzK (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 13 Jan 2018 10:55:10 -0500
In-Reply-To: <q10u44.otcmiv.1hge1d1-qmf@gmx.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, Marcel.Birthelmer@microchip.com, wg@grandegger.com

Hi all,

and a (late) Happy New Year!

I finally managed to finish my patch over christmas, which is now 
included in QtSerialBus [1]. Thanks for all your help on this topic!

To summarize, I was able to get the CAN adapter description and the CAN 
channel by parsing the SysFS.

It would have been nice to extract the adapters serial number and/or an 
user-programmable device ID too (I know that Peak and SYS-TEC have such 
features), but I did not find such a property in the SysFS tree.

So if you have one more hot tip for me ... I'd appreciate it.

Thanks again, and best regards,
André

[1] 
http://code.qt.io/cgit/qt/qtserialbus.git/commit/?h=dev&id=44a449ff8f0b7cdb71e67385e1bd9a098209045e

Am 19.07.2017 um 19:42 schrieb aha_1980@gmx.de:
> Hi Marc,
> 
> Am Dienstag 18. Juli 2017 schrieb Marc Kleine-Budde:
>> On 07/17/2017 09:36 PM, André Hartmann wrote:
>>> thanks for your hints! I've investigated a bit (with PEAK and SYSTEC
>>> adapters) and I'm partly satisfied.
>>>
>>> Wolfgangs tip with ip -d gives me indeed the driver associated to a
>>> CAN interface. And in /sys/class/net/can0/subsystem/can0/device/
>>> interface I found the device string, thanks Marcel. (Full logs are
>>> appended).
>>>
>>> However, the most important infos are still only visible in dmesg.
>>> It's the drivers output which CAN channel is associated with each
>>> hardware interface, e.g.:
>>>
>>> peak_usb 2-1.4:1.0: PEAK-System PCAN-USB Pro [...] (2 channels)
>>> peak_usb 2-1.4:1.0 can0: attached to PCAN-USB Pro channel 0 (device 1)
>>> peak_usb 2-1.4:1.0 can1: attached to PCAN-USB Pro channel 1 (device 0)
>>>
>>> So if there is no way to get these infos from userspace now, I think it
>>> would be a good addition to have this possibility. Especially if there
>>> is more than one CAN adapter connected.
>>
>> Does the udev property dev_id help? See
>> http://permalink.gmane.org/gmane.linux.can/5227 for more information.
> 
> That looks indeed interesting. My Google-foo tells me the patch was included in a pull request, so it should be merged to mainline Kernel.
> 
> Let's see what I can achive.
> 
> Thanks, Andre
>   
>> regards,
>> Marc
>>
>> -- 
>> Pengutronix e.K.                  | Marc Kleine-Budde           |
>> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
>> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
>> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>>
>>
> 

