From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Fwd: usb_8dev - WARN_ON(in_irq()) Ticket #00560
Date: Thu, 9 Apr 2020 12:43:38 +0200
Message-ID: <fe34ce85-3cee-4623-5b20-194510f3d38c@grandegger.com>
References: <CAFnz-BWK_c63YyZ2KzMq=EWn6yfEQyyX+Vo7WSh4SddyY7PCfQ@mail.gmail.com>
 <f17f8d95-96b4-4d51-4390-1fb6a1e47fc8@grandegger.com>
 <871rp4he0s.fsf@steelpick.2x.cz>
 <CAFnz-BUVcSwN6tFUS6W3Y9HUKsbf5am2x=BccSXzX-pRSh9G6w@mail.gmail.com>
 <44255c9f-9c22-7bbf-4426-34506bf8a2b0@grandegger.com>
 <CAFnz-BU1hKPzMyXqgYw82Nt-z2rw+BRNGLvU38BBm-h84d1ztA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.66]:53166 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgDIKnk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Apr 2020 06:43:40 -0400
In-Reply-To: <CAFnz-BU1hKPzMyXqgYw82Nt-z2rw+BRNGLvU38BBm-h84d1ztA@mail.gmail.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Andrejus_Fal=c4=8dikas?= <andrejus.f@8devices.com>
Cc: Michal Sojka <michal.sojka@cvut.cz>, socketcan@hartkopp.net, linux-can@vger.kernel.org

Hello Andrejus,

thanks for testing. Can I have your

Tested-by: Andrejus Falčikas <andrejus.f@8devices.com> ?

Wolfgang

Am 09.04.20 um 12:37 schrieb Andrejus Falčikas:
> Hello,
> 
> Thank you Mr. Wolfgang Grandegger for the patch. I checked and the
> problem disappeared, any warnings do not appear in dmesg after the
> "interface down".
> 
> Best regards,
> Andrejus F.
> 
> On Thu, Apr 9, 2020 at 1:25 PM Wolfgang Grandegger <wg@grandegger.com> wrote:
>>
>>
>> Am 09.04.20 um 08:46 schrieb Andrejus Falčikas:
>>> Hello,
>>>
>>> this Ticket #00560 is closed.
>>
>> Which does not mean that the problem is gone ;)
>>
>> Wolfgang
>>
>>> On Fri, Apr 3, 2020 at 4:53 PM Michal Sojka <michal.sojka@cvut.cz> wrote:
>>>>
>>>> Hello Wolfgang,
>>>>
>>>> On Fri, Apr 03 2020, Wolfgang Grandegger wrote:
>>>>> Hello Andrejus,
>>>>>
>>>>> please do not remove the history of this conversation! It's very
>>>>> difficult to follow what you are speaking about...
>>>>>
>>>>> Am 03.04.20 um 15:04 schrieb Andrejus Falčikas:
>>>>>> Hello Mr. Oliver Hartkopp,
>>>>>>
>>>>>> I would like to notify you that the case described as the issue is
>>>>>> caused by non-standard use of the device and protocol.
>>>>
>>>> [...]
>>>>
>>>>>
>>>>> I observe a similar problem with the GS_USB CAN controller and I have
>>>>> posted a patch recently here:
>>>>>
>>>>>   https://marc.info/?l=linux-can&m=158504888512764&w=2
>>>>>
>>>>> Could you please give the patch for your device below a try:
>>>>
>>>> It would be great if Andrejus can try the patch. If not, I'll try it
>>>> after I get back to work where I have the device. Unfortunately, due to
>>>> current situation, I'm not sure when it will happen.
>>>>
>>>> Thanks.
>>>> -Michal
>>>
>>>
> 
> 
