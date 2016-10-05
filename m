From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939
Date: Wed, 05 Oct 2016 07:08:16 +0200
Message-ID: <8E0EF1AF-172F-41F3-B246-594A5B86963C@vandijck-laurijssen.be>
References: <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net> <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de> <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net> <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com> <20160920091525.2ff22d58@erd980> <20161004073703.GB13813@airbook.vandijck-laurijssen.be> <20161004145202.6c5238d9@erd980> <20161004135701.GA25008@airbook.vandijck-laurijssen.be> <8972643b-d6c8-1880-3360-4f8ef129cc4f@pengutronix.de> <7661b770-574f-6337-d9a9-ff2103ebb8a6@posteo.de> <20161004183848.GC25008@airbook.vandijck-laurijssen.be> <a4af635e-9a0c-d5df-5a90-4722967f0ac1@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:59163 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbcJEFIX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Oct 2016 01:08:23 -0400
In-Reply-To: <a4af635e-9a0c-d5df-5a90-4722967f0ac1@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Patrick Menschel <menschel.p@posteo.de>, David Jander <david@protonic.nl>, Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>



On 4 October 2016 20:43:01 CEST, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>On 10/04/2016 08:38 PM, Kurt Van Dijck wrote:
>> 
>>>
>>>>> Recently, someone on this list was confronted with an engine ECU
>that
>>>>> dropped TP that had the last packet not 8 bytes long.
>>>>> And I believe I've encountered an issue a long time ago where this
>>>>> happened on all PGNs.
>>>>> So I introduced this option, having 3 possibilities:
>>>>> * no padding
>>>>> * padding for TP
>>>>> * padding for all PGN.
>>>> How to switch between padding for TP only and padding for all PGN?
>> 
>> 0: no padding
>> 1: TP padding
>> 2: all PGN padding
>
>Hmmm, have I taken the latest and greatest code of yours?
>
>"padding" is static and only used once in main.c
>
>https://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can-next.git/tree/net/can/j1939/main.c?h=j1939#n45
>
>https://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can-next.git/tree/net/can/j1939/main.c?h=j1939#n171
>
I see.
I wii check later. Maybe I still needed to extend ... In that case, consider the above a configuration proposal?
Kurt

>Marc

Sent from a small mobile device
