From: =?iso-8859-1?Q?=22Bernd_Krumb=F6ck=22?= <krumboeck@universalnet.at>
Subject: Re: [PATCH v9] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Wed, 16 Jan 2013 08:51:43 +0100
Message-ID: <30b2dd836cb9271d609e428466e4795a.squirrel@webmail.universalnet.at>
References: <1355641315-15739-1-git-send-email-krumboeck@universalnet.at>
    <50F471AC.50902@hartkopp.net>
    <ae58b62ae76e6261e66774c458012a87.squirrel@webmail.universalnet.at>
    <50F644F4.1080607@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:49957 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758223Ab3APHvs (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 16 Jan 2013 02:51:48 -0500
In-Reply-To: <50F644F4.1080607@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

> On 15.01.2013 23:05, "Bernd Krumb=F6ck" wrote:
>
>>> [  960.047130] usb_8dev 2-1.4:1.0 can2: Unknown status/error messag=
e
>>> (0)
>>> [  976.544343] usb_8dev 2-1.4:1.0 can2: Unknown status/error messag=
e
>>> (0)
>>>
>>> Did you check these kind of 'unfriendly user' tests?
>>
>> Not really. At least I don't know what the driver should do. Let me =
know
>> if you have some suggestions.
>>
>
>
> Pulling/reconnecting CAN and/or USB under heavy CAN load ;-)

Sorry, I meant: How the driver should behave?


A test with loopback (canbusload 40%):

Jan 16 07:58:36 debian kernel: [40503.434639] CAN device driver interfa=
ce
Jan 16 07:58:38 debian kernel: [40504.900138] usb_8dev 5-2:1.0: can0:
firmware: 1.4, hardware: 1.0
Jan 16 07:58:38 debian kernel: [40504.900161] usbcore: registered new
interface driver usb_8dev

(Starting my script and disconnect usb adapter)

Jan 16 08:09:29 debian kernel: [41155.696483] usb_8dev 5-2:1.0: can0: R=
x
URB aborted (-84)
Jan 16 08:09:29 debian kernel: [41155.696490] usb_8dev 5-2:1.0: can0: T=
x
URB aborted (-71)
Jan 16 08:09:29 debian kernel: [41155.697479] usb_8dev 5-2:1.0: can0: R=
x
URB aborted (-84)
Jan 16 08:09:29 debian kernel: [41155.697484] usb_8dev 5-2:1.0: can0: T=
x
URB aborted (-71)
Jan 16 08:09:29 debian kernel: [41155.698479] usb_8dev 5-2:1.0: can0: R=
x
URB aborted (-84)

No surprises:
* We received (84) "Illegal byte sequence"
* Sending was aborted by (71) "Protocol error"

Jan 16 08:09:29 debian kernel: [41155.752054] usb 5-2: USB disconnect,
device number 2
Jan 16 08:09:29 debian kernel: [41155.752484] usb_8dev 5-2:1.0: can0: T=
x
URB aborted (-71)
Jan 16 08:09:29 debian kernel: [41155.752489] usb_8dev 5-2:1.0: can0: T=
x
URB aborted (-108)
Jan 16 08:09:29 debian kernel: [41155.752492] usb_8dev 5-2:1.0: can0: T=
x
URB aborted (-108)
Jan 16 08:09:29 debian kernel: [41155.752495] usb_8dev 5-2:1.0: can0: T=
x
URB aborted (-108)
Jan 16 08:09:29 debian kernel: [41155.752499] usb_8dev 5-2:1.0: can0: T=
x
URB aborted (-108)
Jan 16 08:09:29 debian kernel: [41155.752502] usb_8dev 5-2:1.0: can0: T=
x
URB aborted (-108)
Jan 16 08:09:29 debian kernel: [41155.752505] usb_8dev 5-2:1.0: can0: T=
x
URB aborted (-108)
Jan 16 08:09:29 debian kernel: [41155.752508] usb_8dev 5-2:1.0: can0: T=
x
URB aborted (-108)
Jan 16 08:09:29 debian kernel: [41155.752511] usb_8dev 5-2:1.0: can0: T=
x
URB aborted (-108)
Jan 16 08:09:29 debian kernel: [41155.752514] usb_8dev 5-2:1.0: can0: T=
x
URB aborted (-108)
Jan 16 08:09:29 debian kernel: [41155.752522] usb_8dev 5-2:1.0: can0:
device disconnected

Looks also ok:
* Sending was aborted by (108) "transport endpoint shutdown"

But after 1 minute my computer freezed!! :-(
Did you see this problem during your tests?

System:
Kernel 3.2.0-4-amd64 SMP on Debian 3.2.35-2
00:1a.2 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #6 (rev 02)


>>> E.g. pulling the USB under receive load brings this output:
>>>
>>> [ 1343.786427] usb_8dev 2-1.4:1.0 can2: Rx URB aborted (-32)
>>> [ 1343.786640] usb_8dev 2-1.4:1.0 can2: Rx URB aborted (-32)

Receiving aborted because of "Broken pipe"...

>>>
>>> (..) another 344 of these URB aborted messages
>>
>> a bit much...
>>
>> Maybe we should suppress this messages?
>>
>
>
> I did not had the time for tests yesterday.
> But i will attach my full-load CAN generator today.
>
> Regarding the USB abort messages, i'll try the same with my other USB
> adapters
> and how they behave under these conditions.

Okidoki. ;-)

> I remember some tests for the PEAK USB mainlining ... let's see.
>
> Regards,
> Oliver
>
>

regards,
Bernd

