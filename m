From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: command ip -details -statistics link show wlan0
Date: Thu, 16 May 2013 17:43:01 +0200
Message-ID: <5194FE85.7030705@grandegger.com>
References: <CAOD0pe=EMt3+ymJMwT+gOUbFZN7_R8exkh36G5457O61GoV4UA@mail.gmail.com> <5194846B.1070307@grandegger.com> <CAOD0pekopW9g0SD=BnOMCEp3SdVZPrx5jY_CKLjZV09sWepS6A@mail.gmail.com> <5194F46D.4060905@grandegger.com> <CAOD0pena8JLpCsq6EUqqy_Rip0oRe0Z5=6SQfGV2TNeS_YABfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:39649 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab3EPPnF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 May 2013 11:43:05 -0400
In-Reply-To: <CAOD0pena8JLpCsq6EUqqy_Rip0oRe0Z5=6SQfGV2TNeS_YABfQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ernast Sevo <ersevs@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Linux-CAN <linux-can@vger.kernel.org>

Hi Ernast,

please don't frop the CC to the mailing list...

On 05/16/2013 05:32 PM, Ernast Sevo wrote:
> On Thu, May 16, 2013 at 10:59 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> On 05/16/2013 03:43 PM, Ernast Sevo wrote:
>>> On Thu, May 16, 2013 at 3:02 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>>>> Hi Ernast,
>>>>
>>>> On 05/15/2013 08:58 PM, Ernast Sevo wrote:
>>>>> Hello,
>>>>>
>>>>>  I am quite new to socket can and I had a question about the output of
>>>>> the command: ip -details -statistics link show can0. When I run the
>>>>> above command I get the following output:
>>>>>
>>>>> re-started bus-errors arbit-lost error-warn error-pass bus-off
>>>>>     0          0          0          0          0          0
>>>>>     RX: bytes  packets  errors  dropped overrun mcast
>>>>>     3956387    948121    11      0           11          0
>>>>>     TX: bytes  packets  errors  dropped carrier collsns
>>>>>     100        44       0       0       0       0
>>>>>
>>>>>
>>>>> I see that I received 11 errors packets (all of them being rx overrun
>>>>> errors) and that no packets were dropped. Does the dropped field refer
>>>>> to packets lost in userspace (i.e because they weren't being read fast
>>>>> enough and the socket receive buffer overflowed) or does the dropped
>>>>> packet field refer to dropped packets being dropped somewhere other
>>>>> than userspace?
>>>>
>>>> They refer to packets dropped in the driver for some reason, maily
>>>> because memory is short (ENOMEM). The overrun errors above are reported
>>>> by the hardware due to messages arrived but there was no space to store
>>>> it. Messages dropped because the socket buffer was full can be reported
>>>> with the candump option "-d" as shown here:
>>>>
>>>> https://gitorious.org/linux-can/can-utils/blobs/master/candump.c#line549
>>>>
>>>> Hope that helps.
>>>>
>>>> Wolfgang.
>>>
>>>
>>>
>>> Hi Wolfgang,
>>>
>>> That definitely clears things up a bit. One more question though. Does
>>> the number in
>>> overrun or the number in errors from the command above then directly
>>> refer to the number
>>> of packets lost on the hardware level due to there being no space to
>>> store it (i.e 11 overrun or
>>> errors means 11 packets lost) ?
>>
>> Well, not sure if the hardware realizes any packet lost. This typically
>> happens when the software does not empty the hardware buffers quickly
>> enough? What hardware are you using? MCP251x?
>>
>> Wolfgang.
>>
>> Wolfgang.
>>
>>
> 
> Yes I am using MCP2515. I am getting a couple of rx buffer overflow errors
> so I was wondering how these errors corresponded to packet loss,
> whether this is a 1:1 relationship or 1:N relationship (if i am
> interpretting Marc's post
> correctly should I assume 1:1 for best case and 1:N for worst case? ).

That would be my guess as well.

> Essentially I am trying to determine at what speed i can have stuff
> coming in before
> I start losing packets for any reason. I know how to account packets
> lost in userspace
>  and packets lost by the driver (which you mentioned above) and now I
> am trying to
> account for packets lost at the hardware level. Knowing how these rx buffer
> overflow/overrun errors correspond to packet loss would help make my
> data more accurate and reliable.

You may try to increase the priority of the MCP2515 IRQ thread.

Recently I also stumbled over the following optimized driver for the
MCP2515:

  http://clientes.netvisao.pt/anbadeol/mcp2515.html

But that would required some effort to update and test it.

Wolfgang.

