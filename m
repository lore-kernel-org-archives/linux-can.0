From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: usb_8dev: firmware and windows library
Date: Wed, 22 Jan 2014 13:58:52 +0100
Message-ID: <52DFC08C.2040400@universalnet.at>
References: <f5902be125a3dd5ead00d75e01a45fa5.squirrel@webmail.universalnet.at> <52DE5EEF.6080100@hartkopp.net> <52DE60C7.3050906@8devices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:59655 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755562AbaAVNGE (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 22 Jan 2014 08:06:04 -0500
In-Reply-To: <52DE60C7.3050906@8devices.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gediminas Simanskis <gediminas@8devices.com>, linux-can@vger.kernel.org

Hi Gediminas!

May I kindly ask you to send me a diff/patch about the changes, so I ca=
n update the firmware sources on github.

regards,
Bernd


Am 2014-01-21 12:57, schrieb Gediminas Simanskis:
> Hello,
> I have changed in v1.5 usb2can firmware only 2x endpoints (3 and 4) s=
izes from 25 bytes to 64 because was problem (USB RX cmd enpoint freezi=
ng) on some PC which use windows7 or windows8  64 bit versions and unde=
r USB3 ports.Now works correct.
> On windows systems usb2can works old driver without any changes.
>
> Gediminas
> 8devices
>
>
>> Hello Bernd,
>>
>> I noticed that there was a firmware update from v1.4 to v1.5 for the=
 8devices
>> USB2CAN interface:
>>
>> http://8devices.com/usb2can#downloads
>>
>> Do you know if there's any change which would be relevant for the us=
b_8dev
>> driver in Linux?
>>
>> Will there be an update of the sources at github?
>>
>> Many thanks,
>> Oliver
>>
>>
>> On 17.01.2013 10:03, "Bernd Krumb=F6ck" wrote:
>>> Hello!
>>>
>>>
>>> 8 devices (http://www.8devices.com/) allowed me to publish the firm=
ware to
>>> the public:
>>>
>>> firmware:
>>> https://github.com/krumboeck/usb2can_firmware
>>>
>>> canal library:
>>> https://github.com/krumboeck/usb2can_canal
>>>
>>>
>>> Many thanks to 8 devices!
>>>
>>> regards,
>>> Bernd
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-can=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

