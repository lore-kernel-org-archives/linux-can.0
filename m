From: vklein <vk4514@arcor.de>
Subject: Re: how to check if can0 is up
Date: Thu, 07 May 2015 13:44:37 +0200
Message-ID: <554B5025.60600@arcor.de>
References: <5547C40E.9050107@arcor.de> <554A3307.8070409@hartkopp.net> <20150507075947.GA14142@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:55567 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750905AbbEGLol (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 May 2015 07:44:41 -0400
In-Reply-To: <20150507075947.GA14142@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Am 07.05.2015 um 09:59 schrieb Kurt Van Dijck:
> Hey,
>
> --- Original message ---
>> On 05/04/2015 09:10 PM, vklein wrote:
>>
>>> I want to test the status of can0 on a BeagleBoneBlack with serial-can cape
>>> from Logic Supply.
>>>
>>> The interface is initialized with
>>> ip link set can0 type can bitrate 250000
>>> ifconfig can0 up
>> Good.
>>
>>> I have tried
>>> cat /sys/class/net/can0/operstate
>>> but this does not work correctly
>>>
>>> if can0 is down,  I get "down"
>>>
>>> if can0 is up , I get "unknown"
>> The question is whether operstate is always set correctly ...
>>
>>> ifconfig says:
>>> can0      Link encap:UNSPEC  HWaddr
>>> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>>>            UP RUNNING NOARP  MTU:16  Metric:1
>>>            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>>            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>>            collisions:0 txqueuelen:10
>>>            RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>>>            Interrupt:55
>>>
>> What does
>>
>> 	ip -det link show can0
>>
>> tell you?
>>
>> Using the 'ip' tool is recommended to get the device state.
> I agree that 'ip' is the recommended way.
> ip is an interactive tool.
> To access it from c code, I wrote myself a library with example code:
>
> https://github.com/kurt-vd/enumif
>
> regards,
> Kurt


ip -det link show can0 | grep UP

works for me

Victor





