From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: usb_8dev: firmware and windows library
Date: Sat, 31 Jan 2015 11:09:43 +0100
Message-ID: <54CCA9E7.4040303@hartkopp.net>
References: <f5902be125a3dd5ead00d75e01a45fa5.squirrel@webmail.universalnet.at> <52DE5EEF.6080100@hartkopp.net> <52DE60C7.3050906@8devices.com> <52DFC08C.2040400@universalnet.at> <52DFD9B7.40300@pengutronix.de> <52E36208.3020100@universalnet.at> <54CBFE09.9000700@hartkopp.net> <54CC0103.2070507@universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:47513 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbbAaKJx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 31 Jan 2015 05:09:53 -0500
In-Reply-To: <54CC0103.2070507@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <krumboeck@universalnet.at>
Cc: Gediminas Simanskis <gediminas@8devices.com>, linux-can@vger.kernel.org

Hi Bernd,

On 30.01.2015 23:09, Bernd Krumboeck wrote:

> dfu-util 0.8 should be able to patch the adapter:
> http://dfu-util.sourceforge.net/releases/dfu-util-0.8.tar.gz

ok.

>
> At least when 8devices corrected the device identifier in the provided
> firmware image.

At least for the 1.4 version the way below worked.
If there is another 1.4 I can try the dfu-util 0.8 first.

> Sadly I have no time to test it myself.  :-(
> Maybe in a month.

I also have some open projects for 'maybe in a month' ;-))

Thanks,
Oliver

>
> Am 2015-01-30 um 22:56 schrieb Oliver Hartkopp:
>> Hi Bernd,
>>
>> I had an adapter with a firmware < v1.5 here and tried to follow the
>> documentation at
>>
>> https://github.com/krumboeck/usb2can_firmware#flash-the-device-linux-experimental
>>
>>
>> Unfortunately the referenced patch at
>> http://lists.gnumonks.org/pipermail/dfu-util/attachments/20140124/1abbc049/attachment.bin
>>
>> disappeared ...
>>
>> I had this patch somewhere on my former laptop and attached it for the records.
>>
>> As dfu-util moved to to gitorious I cloned the dfu-util master into
>>
>> https://gitorious.org/dfu-util/8devices-usb2can-dfu-util
>>
>> an applied the two patches so that this version is able to flash the
>> 8devices USB2CAN adapter again.
>>
>> Regards,
>> Oliver
>>
>> On 25.01.2014 08:04, Bernd Krumboeck wrote:
>>> Hi!
>>>
>>>
>>> Source code from firmware v1.5: https://github.com/krumboeck/usb2can_firmware
>>>
>>>
>>> After some experiments I was able to flash the firmware with dfu-util under
>>> linux:
>>> https://github.com/krumboeck/usb2can_firmware#flash-the-device-linux-experimental
>>>
>>>
>>>
>>> Sadly I don't know the way how to build the firmware with a free tools chain.
>>>
>>>
>>> regards,
>>> Bernd
>>>
>>>
>>> Am 2014-01-22 15:46, schrieb Marc Kleine-Budde:
>>>> On 01/22/2014 01:58 PM, Bernd Krumboeck wrote:
>>>>> May I kindly ask you to send me a diff/patch about the changes, so I can
>>>>> update the firmware sources on github.
>>>>
>>>> A complete new set of sources will do, too. Git will create the diff for
>>>> you. :)
>>>>
>>>> Marc
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
