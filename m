From: David Jander <david@protonic.nl>
Subject: Re: j1939
Date: Wed, 5 Oct 2016 08:48:45 +0200
Message-ID: <20161005084845.697b8f20@erd980>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
        <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:10731 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754598AbcJEGsr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Oct 2016 02:48:47 -0400
In-Reply-To: <7661b770-574f-6337-d9a9-ff2103ebb8a6@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>

On Tue, 4 Oct 2016 19:54:30 +0200
Patrick Menschel <menschel.p@posteo.de> wrote:

> >> Recently, someone on this list was confronted with an engine ECU that
> >> dropped TP that had the last packet not 8 bytes long.
> >> And I believe I've encountered an issue a long time ago where this
> >> happened on all PGNs.
> >> So I introduced this option, having 3 possibilities:
> >> * no padding
> >> * padding for TP
> >> * padding for all PGN.  
> > How to switch between padding for TP only and padding for all PGN?
> >
> > Marc
> >  
> 
> I'm working with J1939 regularly and programmed J1939 in Python3 a while
> ago.
> 
> From my experience, message construction is responsibility of the user
> program.

I agree.

> There are numerous SPNs to be implemented in a message while
> unimplemented bits are to be padded with ones.
> It may be possible to pad all messages with 0xFF but that doesn't solve
> the non implemented bits in front of the padding.

I think the kernel should never modify packets from user-space in such a way.
I think we should limit this option to chose between:

 0: (default) Strictly standards compliant (i.e. pad TP messages) and
 1: Not pad TP messages (may break standard).

> I think it's best practice to fulfill the requirements by creating a
> j1939 message with 8 Bytes of 0xFF and then replace the bits for a
> specific SPN.

That may be true for many standard PGN's, but not for all, and certainly not
for proprietary messages. Again, IMHO, the kernel should not mess with
user-space messages.

> This would be in user space when calling the J1939 message constructor.

Precisely.

> BTW many j1939 descriptor files types such as the PCAN ".sym" files,
> define SPNs as a bit offset and a length (additionally with type, factor
> and offset as compu_method), so no need to invent the wheel again.

Don't know exactly what you mean, but this sounds user-space specific to me.

> Regards,
> Patrick
> 

Best regards,

-- 
David Jander
Protonic Holland.
