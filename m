From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: usb-can device
Date: Sun, 9 Sep 2012 15:41:40 +0200
Message-ID: <201209091541.41109.pisa@cmp.felk.cvut.cz>
References: <1345996339.6610.10.camel@slaptop> <20120828233459.GA3046@gmail.com> <503DF6B7.8010004@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:47710 "EHLO
	relay.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705Ab2IIOPW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 9 Sep 2012 10:15:22 -0400
In-Reply-To: <503DF6B7.8010004@hartkopp.net>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Max S." <max@schneidersoft.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>

On Wednesday 29 August 2012 13:02:15 Oliver Hartkopp wrote:
> On 29.08.2012 01:34, Fabio Baltieri wrote:
> > Oliver, Marc, do you think that this design my be used as a base to do
> > some generic USB-CAN (CDC CAN?) protocol development?  I would be happy
> > to help!
>
> Yes. Definitely!
>
> Really nice to have the entire project on github now.
>
> Even if the MCP2515 is not the high performance hardware, we probably run
> into problems there, we would not see on better hardware ;-)
>

I would like to express my interrest in the development of some generic CAN<->USB
protocol specification as well.

The main question is, if the data should be bulk messages boundaries aligned
(as done in our actual implementations) or if the USB PIPE/stream feature should be
used and USB transferred messages length to be variable.

There are some HW/code chunks which are available from our side:

1) We have used two CAN<->USB hardware setups already
    - LPC2148 + SJA1000 board (deprecated now)
    - LPC1768
   both boards was originally designed by my colleague at PiKRON Ltd.
   and are rich with other functions for their main use in our laboratory
   and medical systems.
   But we consider the circuitry required for CAN<->USB converters as
   open (GPL/MPL) and can think even about PD. If there is broader
   interrest, we would prepare and publish design optimized for CAN<->USB
   converter use.

2) the core part of the converters firmware is based on the LinCAN driver
   project which is now maintained as one of the OrtCAN GIT repositories.

   Firmware build steps are briefly documented at next page

     http://ortcan.sourceforge.net/lincan/usbcan/

   Used protocol is really simple for now, it maps each CAN message into
   little-endian formated 16-byte bulk message.
   Bitrate settings and calculations come from our LinCAN and H8S projects
   which are precursor for calculation used in SocketCAN and we extended
   our code to provide SocketCAN compatible parameters passing over USB
   in the latest version.

3) On the Linux side, the converters are primarily supported in the same
   LinCAN can-usb1 branch as firmware is located which is logical choice,
   because setup  architecture is stub chip driver/serialization replacing
   regular LinCAN chip driver on Linux side and deserialization and local
   embedded LinCAN core client on the converter side.

4) Socketcan support for the converters has been implemented in the frame
   of Jiri Vanek diploma thesis and is available in "vanekjir" branch of
   our experimental SocketCAN repo

     http://rtime.felk.cvut.cz/gitweb/socketcan-devel.git

     (the thesis full text - unfortunately Czech language only)
     http://support.dce.felk.cvut.cz/mediawiki/images/5/56/Dp_2012_vanek_jiri.pdf

5) Similar but independent USB<->CAN converter based on ST STR710
   is described in Ondrej Semler's diploma thesis. It was done
   on other CTU department and a driver side targets to Windows systems.

     (the thesis full text - Czech language only as well)
     http://support.dce.felk.cvut.cz/mediawiki/images/0/0b/Dp_2012_semmler_ondrej.pdf

As for converters based on SPI connected MCP2515 and some PIC. FTDI or other MCU
used for USB connection, I am not fan of these designs. They have tendency
to be overflown by full CAN traffic. On the other hand, my colleague has
single chip PIC with CAN based design which could serve as cheap converter
base and can handle full CAN bandwidth.

But I think that ARM based chips are cheap enough for now, that LPC17xx,
ST, AT or some other MCU based design would not mean significant contribution
to price and flexibility, FIFOs size etc. are much better. 

The protocol definition is most important for now.
There is no problem to adapt our design to different CAN messages
encapsulation and channel control.

Things to consider/decide:

A) Stream with variable length or bulk aligned
B) If and how should be Linux driver Tx side notified about CAN message
   delivery onto physical CAN bus and actual Tx time
C) how should be managed Rx and Tx timestamping, probably some free
   running time on the converter side should be used and translated
   to timespec format on Linux side
D) how should be solved prioritization of the messages, small/dicrete
   number of the priority queues or full ID based ordering
E) if more queues are used there is problem with Tx flow control,
   use more blocking USB endpoints/pipes - one for each queue,
   or use nonblocking solution with FIFOs free size reporting
   through single pipes/endpoints pair.
F) think about CAN single shot messages and rescheduling/reissuing
   higher priority message to the converter Tx buffer to prevent
   messages priority inversion problem in the converter/CAN bus
   interaction.

Best wishes,

                Pavel Pisa
    e-mail:     pisa@cmp.felk.cvut.cz
    www:        http://cmp.felk.cvut.cz/~pisa
    university: http://dce.fel.cvut.cz/
