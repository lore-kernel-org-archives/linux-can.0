From: Martin Kelly <mkelly@xevo.com>
Subject: Re: CAN-USB adapter unplug
Date: Wed, 29 Nov 2017 09:07:40 -0800
Message-ID: <e5a2cbc8-f1be-1bed-a0af-9b5fa6fd35ca@xevo.com>
References: <20171127234916.25865-1-mkelly@xevo.com>
 <48029f4a-5137-5f1f-6970-5668fb8da599@pengutronix.de>
 <2f999f02-028e-1e6c-9020-beb5a76889cc@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-co1nam03on0086.outbound.protection.outlook.com ([104.47.40.86]:45268
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932448AbdK2RHt (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 29 Nov 2017 12:07:49 -0500
In-Reply-To: <2f999f02-028e-1e6c-9020-beb5a76889cc@esd.eu>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: =?UTF-8?B?UmVtaWdpdXN6IEtvxYLFgsSFdGFq?= <remigiusz.kollataj@mobica.com>, Wolfgang Grandegger <wg@grandegger.com>

On 11/29/2017 07:21 AM, Stefan Mätje wrote:
> Am 29.11.2017 um 13:20 schrieb Marc Kleine-Budde:
>> On 11/28/2017 10:09 PM, Martin Kelly wrote:
>>>> Both applied to can.
>>>
>>> Thanks! By the way as far as I can tell from code inspection, it appears
>>> that most of the other drivers in net/can/usb should have the same
>>> disconnect bug. gs_usb appears to be clear, as it returns in its default
>>> case. Unfortunately mcba_usb is the only device I have to test with, but
>>> those with other devices may want to check for this.
>>
>> Can you create patches for the affected drivers and send them to the
>> list and the maintainers of the driver on Cc?
>>
>> I don't have access to every USB adapter neither.
>>
>> Marc
>>
> 
> Hi,
> 
> I have seen Martin's emails these days and tried to reproduce the error here
> with an esd CAN-USB/2 device (handled by esd_usb2.c). The only thing I get
> in the log are some messages like this:
> 
> kernel: [14776.152459] usb 2-1: Rx URB aborted (-71)
> 
> There is no endless loop. How could I reproduce the bad behavior? For the
> quick test I used an Ubuntu 4.4.0-101-generic kernel.

Interesting. Do you see just a few -71 RX URB aborted messages (one per 
outstanding URB) rather than an endless loop? If so, then I think 
everything is OK on that device, as the URBs are not being resubmitted.

In case it helps, my test case for the mcba_usb is on a Raspberry Pi 3. 
I don't know whether or not that could influence the USB error code we 
see, since you are seeing EPROTO instead of EPIPE when the device gets 
unplugged.

> 
> In any case I will add the patch handling EPIPE on a test system and have a
> look what it might change.
> 
> Regards,
> Stefan Mätje
>
