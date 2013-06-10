From: Ernast Sevo <ersevs@gmail.com>
Subject: Re: command ip -details -statistics link show wlan0
Date: Mon, 10 Jun 2013 08:53:17 -0400
Message-ID: <CAOD0pen=9Fjwh0rEMqE2crdwdhWA+9iDwPO2N0dDH2BaHArEOg@mail.gmail.com>
References: <CAOD0pe=EMt3+ymJMwT+gOUbFZN7_R8exkh36G5457O61GoV4UA@mail.gmail.com>
	<5194846B.1070307@grandegger.com>
	<CAOD0pekopW9g0SD=BnOMCEp3SdVZPrx5jY_CKLjZV09sWepS6A@mail.gmail.com>
	<5194F46D.4060905@grandegger.com>
	<CAOD0pena8JLpCsq6EUqqy_Rip0oRe0Z5=6SQfGV2TNeS_YABfQ@mail.gmail.com>
	<5194FE85.7030705@grandegger.com>
	<CAOD0pekym7Ey1eRn-ndwjEnsJUpf84xHbexztpRBjUKqoaGcPw@mail.gmail.com>
	<51B239EA.6060603@grandegger.com>
	<51B2E072.3090206@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:50341 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab3FJMxR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 08:53:17 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so16196246iea.17
        for <linux-can@vger.kernel.org>; Mon, 10 Jun 2013 05:53:17 -0700 (PDT)
In-Reply-To: <51B2E072.3090206@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Linux-CAN <linux-can@vger.kernel.org>

Hi Wolfgang,

I will give this a try and let you know as soon as I test it out.

Best,

 Ernast

On Sat, Jun 8, 2013 at 3:42 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Hi Ernast,
>
> Please do not drop the CC to the Linux-CAN mailing list...
>
> On 06/07/2013 09:52 PM, Wolfgang Grandegger wrote:
>> On 06/07/2013 09:32 PM, Ernast Sevo wrote:
>>> Hello,
>>>
>>>  I apologize for resurrecting an old thread but I finally got around
>>> to testing a program which uses
>>> socket can that I wrote and I get quite a few overrun errors. I also
>>> tried increasing the priority of
>>> the  MCP2515 IRQ which made things slightly better for me but not good
>>> enough. Are there any other
>>> suggestions as to how to fix these overrun errors? or at least improve
>>> them a bit more.
>>
>> What priority did you use? Could you show the output of
>>
>>   # ps -m -eo pid,tid,class,rtprio,ni,pri,psr,pcpu,stat,wchan:14,comm
>>
>> when the test app is running? Note that these option are not available
>> with the busybox version of ps.
>>
>> I also wrote:
>>
>>>> Recently I also stumbled over the following optimized driver
>>>> MCP2515:
>>>>
>>>>   http://clientes.netvisao.pt/anbadeol/mcp2515.html
>>>>
>>>> But that would required some effort to update and test it.
>>
>> Would be interesting if this driver behaves better concerning message
>> losses. What kernel version are you using?
>
> Just to give this driver a try, I have attached
> "mcp2515-extern-v1.tar.bz2", my out-of-tree version of the MCP2515
> driver mentioned above. On my Ubuntu system (running Linux 3.2.0), I
> just use the following commands to get the kernel module built:
>
>   $ tar xf mcp2515-extern-v1.tar.bz2
>   $ cd mcp2515-extern
>   $ ./make-modules.sh
>
> For your embedded environment you need to tweak "make-modules.sh",
> though, or use the following command:
>
>   $ CONFIG_CAN_DEBUG_DEVICES=y CONFIG_CAN_MCP2515=m \
>     make -C <path-to-your-kernel-tree> SUBDIRS=`pwd` modules
>
> You should then be able to load "mcp2515.ko" on your embedded system
> (after removing the old MCP2510 driver):
>
>   # rmmod mcp2510
>   # insmod mcp2515.ko
>
> If you are lucky, it will work out of the box.
>
> Wolfgang.
>
