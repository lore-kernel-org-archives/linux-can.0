From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939
Date: Tue, 4 Oct 2016 20:38:48 +0200
Message-ID: <20161004183848.GC25008@airbook.vandijck-laurijssen.be>
References: <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
 <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
 <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <20160920091525.2ff22d58@erd980>
 <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
 <20161004145202.6c5238d9@erd980>
 <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
 <8972643b-d6c8-1880-3360-4f8ef129cc4f@pengutronix.de>
 <7661b770-574f-6337-d9a9-ff2103ebb8a6@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:51454 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753788AbcJDSjq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Oct 2016 14:39:46 -0400
Content-Disposition: inline
In-Reply-To: <7661b770-574f-6337-d9a9-ff2103ebb8a6@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, David Jander <david@protonic.nl>, Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>


> 
> >> Recently, someone on this list was confronted with an engine ECU that
> >> dropped TP that had the last packet not 8 bytes long.
> >> And I believe I've encountered an issue a long time ago where this
> >> happened on all PGNs.
> >> So I introduced this option, having 3 possibilities:
> >> * no padding
> >> * padding for TP
> >> * padding for all PGN.
> > How to switch between padding for TP only and padding for all PGN?

0: no padding
1: TP padding
2: all PGN padding
> >
> > Marc
> >
> 
> I'm working with J1939 regularly and programmed J1939 in Python3 a while
> ago.
> 
> From my experience, message construction is responsibility of the user
> program.
> 
> There are numerous SPNs to be implemented in a message while
> unimplemented bits are to be padded with ones.
> It may be possible to pad all messages with 0xFF but that doesn't solve
> the non implemented bits in front of the padding.
> 
> I think it's best practice to fulfill the requirements by creating a
> j1939 message with 8 Bytes of 0xFF and then replace the bits for a
> specific SPN.
> This would be in user space when calling the J1939 message constructor.

Although this does not apply to TP, it does apply to all other PGN's.
So there is no real need to pad all PGN's.

Kurt

