From: Gediminas Simanskis <gediminas@8devices.com>
Subject: Re: usb_8dev: firmware and windows library
Date: Tue, 21 Jan 2014 13:57:59 +0200
Message-ID: <52DE60C7.3050906@8devices.com>
References: <f5902be125a3dd5ead00d75e01a45fa5.squirrel@webmail.universalnet.at> <52DE5EEF.6080100@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:37807 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103AbaAUL6V (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 06:58:21 -0500
Received: by mail-ea0-f172.google.com with SMTP id g15so3103936eak.31
        for <linux-can@vger.kernel.org>; Tue, 21 Jan 2014 03:58:20 -0800 (PST)
In-Reply-To: <52DE5EEF.6080100@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, =?ISO-8859-1?Q?Bernd_Krum?= =?ISO-8859-1?Q?b=F6ck?= <krumboeck@universalnet.at>, linux-can@vger.kernel.org

Hello,
I have changed in v1.5 usb2can firmware only 2x endpoints (3 and 4)=20
sizes from 25 bytes to 64 because was problem (USB RX cmd enpoint=20
freezing) on some PC which use windows7 or windows8  64 bit versions an=
d=20
under USB3 ports.Now works correct.
On windows systems usb2can works old driver without any changes.

Gediminas
8devices


> Hello Bernd,
>
> I noticed that there was a firmware update from v1.4 to v1.5 for the =
8devices
> USB2CAN interface:
>
> http://8devices.com/usb2can#downloads
>
> Do you know if there's any change which would be relevant for the usb=
_8dev
> driver in Linux?
>
> Will there be an update of the sources at github?
>
> Many thanks,
> Oliver
>
>
> On 17.01.2013 10:03, "Bernd Krumb=F6ck" wrote:
>> Hello!
>>
>>
>> 8 devices (http://www.8devices.com/) allowed me to publish the firmw=
are to
>> the public:
>>
>> firmware:
>> https://github.com/krumboeck/usb2can_firmware
>>
>> canal library:
>> https://github.com/krumboeck/usb2can_canal
>>
>>
>> Many thanks to 8 devices!
>>
>> regards,
>> Bernd
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

