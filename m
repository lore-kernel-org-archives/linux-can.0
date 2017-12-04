From: Jimmy Assarsson <extja@kvaser.com>
Subject: Re: CAN-USB adapter unplug
Date: Mon, 4 Dec 2017 09:39:46 +0100
Message-ID: <29dbc892-e468-e828-3f5b-78153930d540@kvaser.com>
References: <20171127234916.25865-1-mkelly@xevo.com>
 <48029f4a-5137-5f1f-6970-5668fb8da599@pengutronix.de>
 <2f999f02-028e-1e6c-9020-beb5a76889cc@esd.eu>
 <e5a2cbc8-f1be-1bed-a0af-9b5fa6fd35ca@xevo.com>
 <d5820417-b818-e78e-d3f0-6c24eb0fecd0@kvaser.com>
 <4f6687db-269d-d8ff-7a47-5094ad63043a@xevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:39819 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbdLDIjt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Dec 2017 03:39:49 -0500
Received: by mail-lf0-f45.google.com with SMTP id l81so18160147lfl.6
        for <linux-can@vger.kernel.org>; Mon, 04 Dec 2017 00:39:49 -0800 (PST)
In-Reply-To: <4f6687db-269d-d8ff-7a47-5094ad63043a@xevo.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kelly <mkelly@xevo.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>, =?UTF-8?B?UmVtaWdpdXN6IEtvxYLFgsSFdGFq?= <remigiusz.kollataj@mobica.com>, Wolfgang Grandegger <wg@grandegger.com>

On 2017-11-30 19:19, Martin Kelly wrote:
> On 11/30/2017 02:18 AM, Jimmy Assarsson wrote:
>> On 2017-11-29 18:07, Martin Kelly wrote:
>>> On 11/29/2017 07:21 AM, Stefan Mätje wrote:
>>>> Am 29.11.2017 um 13:20 schrieb Marc Kleine-Budde:
>>>>> On 11/28/2017 10:09 PM, Martin Kelly wrote:
>>>>>>> Both applied to can.
>>>>>>
>>>>>> Thanks! By the way as far as I can tell from code inspection, it 
>>>>>> appears
>>>>>> that most of the other drivers in net/can/usb should have the same
>>>>>> disconnect bug. gs_usb appears to be clear, as it returns in its 
>>>>>> default
>>>>>> case. Unfortunately mcba_usb is the only device I have to test 
>>>>>> with, but
>>>>>> those with other devices may want to check for this.
>>>>>
>>>>> Can you create patches for the affected drivers and send them to the
>>>>> list and the maintainers of the driver on Cc?
>>>>>
>>>>> I don't have access to every USB adapter neither.
>>>>>
>>>>> Marc
>>>>>
>>>>
>>>> Hi,
>>>>
>>>> I have seen Martin's emails these days and tried to reproduce the 
>>>> error here
>>>> with an esd CAN-USB/2 device (handled by esd_usb2.c). The only thing 
>>>> I get
>>>> in the log are some messages like this:
>>>>
>>>> kernel: [14776.152459] usb 2-1: Rx URB aborted (-71)
>>>>
>>>> There is no endless loop. How could I reproduce the bad behavior? 
>>>> For the
>>>> quick test I used an Ubuntu 4.4.0-101-generic kernel.
>>
>> Hi,
>>
>> I got same result for kvaser_usb, a single "Rx URB aborted (-71)". 
>> When tested on Ubuntu with 4.4.0-93-generic.
>>
>>> Interesting. Do you see just a few -71 RX URB aborted messages (one 
>>> per outstanding URB) rather than an endless loop? If so, then I think 
>>> everything is OK on that device, as the URBs are not being resubmitted.
>>>
>>> In case it helps, my test case for the mcba_usb is on a Raspberry Pi 
>>> 3. I don't know whether or not that could influence the USB error 
>>> code we see, since you are seeing EPROTO instead of EPIPE when the 
>>> device gets unplugged.
>>
>> However, I do get lots of (500+) "Rx URB aborted (-71)" printouts, on 
>> Raspberry Pi 3, running Raspbian with kernel 4.9.35-v7. But no EPIPE 
>> seen.
>>
> 
> Very interesting; this means that there are multiple possible error 
> codes from a USB disconnect. If that's the case, is it possible that the 
> best thing to do is what gs_usb does? In gs_usb's receive callback, we 
> have:
> 
>      switch (urb->status) {
>      case 0: /* success */
>          break;
>      case -ENOENT:
>      case -ESHUTDOWN:
>          return;
>      default:
>          /* do not resubmit aborted urbs. eg: when device goes down */
>          return;
>      }
> 
> The default case is to *not* resubmit URBs, rather than to resubmit is a 
> default and try to catch all possible error codes in the non-default 
> case, as the other drivers are doing.
> 
> If we don't do something like this, then we need to understand all the 
> possible error codes that could occur and catch them all.

Well, gs_usb never resubmit any URBs if urb->status is non-zero. As long 
as any error (urb->status != 0) is the result of a disconnect, it should 
be safe to never resubmit? I doubt this is the case, but I really don't 
know.

>> Regards,
>> Jimmy
>>
>>>>
>>>> In any case I will add the patch handling EPIPE on a test system and 
>>>> have a
>>>> look what it might change.
>>>>
>>>> Regards,
>>>> Stefan Mätje
