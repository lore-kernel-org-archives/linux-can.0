From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: Measuring latency of CAN messages in SocketCAN
Date: Thu, 6 Oct 2016 22:24:02 +0200
Message-ID: <201610062224.02526.pisa@cmp.felk.cvut.cz>
References: <web-11102383@rz.tu-bs.de> <d01e175a-7c62-3e55-ed34-bb65a96458e9@posteo.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:15053 "EHLO
        relay.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933284AbcJFUYl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2016 16:24:41 -0400
In-Reply-To: <d01e175a-7c62-3e55-ed34-bb65a96458e9@posteo.de>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>, Bremer Henning <h.bremer@tu-braunschweig.de>
Cc: linux-can@vger.kernel.org, Martin Jerabek <jerabma7@fel.cvut.cz>, Michal Sojka <sojkam1@fel.cvut.cz>



On Thursday 06 of October 2016 21:48:57 Patrick Menschel wrote:
> > I am using SocketCAN on a Beaglebone Black with Debian (Wheezy). I
> > have my Beaglebone plugged in a CAN-Network of 5 microcontrollers. Now
> > I would like to measure the time one message needs to be delivered
> > from my beaglebone to another microcontroller via CAN depending on the
> > priority (ID) of the sent message.
> > Is there a way to do this in SocketCAN?
>
> IMHO latency is best to be measured with an oscilloscope or a logic
> analyzer. Switching a GPIO PIN is a good trigger to start a measurement.
> Just wait for the message to be sent and measure the time in between.
>
> As CAN is CSMA, latency has to be measured without other nodes on the
> network.
>
> The other option on the BBB is to sent a message from can0 to can1 and
> clock the time in between tx and rx. Assuming rx takes as much time as
> tx, you can split that time in half to get the latency.
>
> Regards,
> Patrick

If the task is to evaluate latencies between reception of message
and reaction to it then it is the best to use the second system
which provides hardware timestamping.

We have more such projects developed at our university.
The Linux related ones mainly in our group, low level systems
with up to sub bittime measurements at department of Measurement
have been done for Skoda Auto.

See some of our CAN related projects

  http://rtime.felk.cvut.cz/can/

Quite powerfull and relatively cheap tool is next Zynq based
solution developed by Martin Jerabek in frame of his bachelor
thesis

  http://rtime.felk.cvut.cz/can/F3-BP-2016-Jerabek-Martin-Jerabek-thesis-2016.pdf

The Xilinx CAN driver update to provide hardware CAN messages timestamping
with microsecond resolution is working nice way, there are missing
some minor details to be ready for submission to the list for inclusion
into mainline

  https://rtime.felk.cvut.cz/gitweb/fpga/zynq/canbench-sw.git

Change for candump to allow select hardware timestamps has been prepared
by Michal Sojka and is quite ready as well.

We use this Linux Zynq "CAN analyzer" setup in to evalueate our development
of CPU independent precise CAN messages Tx according to the schedule
on embedded TMS570 based system.

We have updated to this more precise setup even our SocketCAN CAN to CAN
gateway continuous testing.

As for checking of Tx delay from some internal or external asynchronous
event, the oscilloscope is tool of choice.  If event is internal,
send alter some GPIO output pin at that even and use that as trigger.
If you have more messages and need to find the right one then you can send
another message through the second unloaded CAN channel and then use for
example our analyzer to measure differences between messages other easy option
is to add logic input processing to FPGA which could lead for example to
capture of the same CAN HW timestamp counter even from non-FPGA processor
system integrated can controller. It is easy to access CPU address space
over AXI from FPGA side and then provide register with captured value
back to ARM/Linux system. We have done similar things in some of
our designs.

Best wishes,

Pavel Pisa

Department of Control Engineering
Czech Technical University in Prague
https://dce.fel.cvut.cz/en
