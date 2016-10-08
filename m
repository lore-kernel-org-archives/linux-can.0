From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Measuring latency of CAN messages in SocketCAN
Date: Sat, 8 Oct 2016 18:44:45 +0200
Message-ID: <dd528b79-1f31-b24e-c4d9-5696c56207c0@hartkopp.net>
References: <web-11102383@rz.tu-bs.de>
 <d01e175a-7c62-3e55-ed34-bb65a96458e9@posteo.de>
 <201610062224.02526.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:39500 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755186AbcJHQox (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 8 Oct 2016 12:44:53 -0400
In-Reply-To: <201610062224.02526.pisa@cmp.felk.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Patrick Menschel <menschel.p@posteo.de>, Bremer Henning <h.bremer@tu-braunschweig.de>
Cc: linux-can@vger.kernel.org, Martin Jerabek <jerabma7@fel.cvut.cz>, Michal Sojka <sojkam1@fel.cvut.cz>

On 10/06/2016 10:24 PM, Pavel Pisa wrote:

> If the task is to evaluate latencies between reception of message
> and reaction to it then it is the best to use the second system
> which provides hardware timestamping.
>
> We have more such projects developed at our university.
> The Linux related ones mainly in our group, low level systems
> with up to sub bittime measurements at department of Measurement
> have been done for Skoda Auto.
>
> See some of our CAN related projects
>
>   http://rtime.felk.cvut.cz/can/
>
> Quite powerfull and relatively cheap tool is next Zynq based
> solution developed by Martin Jerabek in frame of his bachelor
> thesis
>
>   http://rtime.felk.cvut.cz/can/F3-BP-2016-Jerabek-Martin-Jerabek-thesis-2016.pdf

Very interesting - thanks for the reference.

I usually poll http://rtime.felk.cvut.cz/can/ time after time.

Maybe I overlooked this thesis as there was no '2016' at the URL on the 
page :-)

>
> The Xilinx CAN driver update to provide hardware CAN messages timestamping
> with microsecond resolution is working nice way, there are missing
> some minor details to be ready for submission to the list for inclusion
> into mainline

Looking forward to it.

>   https://rtime.felk.cvut.cz/gitweb/fpga/zynq/canbench-sw.git
>
> Change for candump to allow select hardware timestamps has been prepared
> by Michal Sojka and is quite ready as well.
>
> We use this Linux Zynq "CAN analyzer" setup in to evalueate our development
> of CPU independent precise CAN messages Tx according to the schedule
> on embedded TMS570 based system.
>
> We have updated to this more precise setup even our SocketCAN CAN to CAN
> gateway continuous testing.
>
> As for checking of Tx delay from some internal or external asynchronous
> event, the oscilloscope is tool of choice.  If event is internal,
> send alter some GPIO output pin at that even and use that as trigger.

Maybe you can also use the established and supported LED trigger (for 
CAN RX/TX) infrastructure and define one of the used LED outputs as a 
GPIO pin for measurements.

> If you have more messages and need to find the right one then you can send
> another message through the second unloaded CAN channel and then use for
> example our analyzer to measure differences between messages other easy option
> is to add logic input processing to FPGA which could lead for example to
> capture of the same CAN HW timestamp counter even from non-FPGA processor
> system integrated can controller. It is easy to access CPU address space
> over AXI from FPGA side and then provide register with captured value
> back to ARM/Linux system. We have done similar things in some of
> our designs.
>
> Best wishes,
>
> Pavel Pisa

Many thanks,
Oliver
