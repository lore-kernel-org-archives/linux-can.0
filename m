From: David Jander <david@protonic.nl>
Subject: Re: RFC: Pacing support in vcan?
Date: Mon, 1 May 2017 14:05:52 +0200
Message-ID: <20170501140552.68376a75@erd980>
References: <20170501092449.7b6cade3@erd980>
        <8f67d483-d1e9-1d22-cb95-660828cd5323@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:4729 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163879AbdEAMFy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 May 2017 08:05:54 -0400
In-Reply-To: <8f67d483-d1e9-1d22-cb95-660828cd5323@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On Mon, 1 May 2017 12:04:05 +0200
Oliver Hartkopp <socketcan@hartkopp.net> wrote:

> Hi David,
> 
> On 05/01/2017 09:24 AM, David Jander wrote:
> 
> > Currently the VCAN driver is infinitely fast, which is probably fine for most
> > simple applications and testing simple CAN code. Unfortunately I have had a
> > few cases where this is a problem. For example when testing software
> > implementations of transport protocols, where a producer generates can frames
> > basically as fast as possible. Two or more consumers receiving this stream are
> > just a little bit slower (in processing data) than the producer, so I would
> > start losing frames. Of course the TP takes care of this, but since that is
> > what I am trying to test/debug, this can be bothersome.
> >
> > So the question is whether a proposal to introduce optional pacing of vcan
> > would be accepted?  
> 
> you can already add a queueing discipline to the virtual CAN interface.
> 
> See
> 
> http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf
> 
> chapter 3.3.
> 
> Does this help in your setup?

Ha! Yes, this is indeed what I was looking for.... somehow I didn't expect it
to be possible with queuing disciplines. Shows that I still have far too
little experience with that corner of the Linux networking stack :-)
Thanks!

> > Maybe something like (optional) virtual bitrate simulation?
> > I understand that other "loopback" interfaces, like "lo" don't have this and
> > don't want this, but in those cases we usually deal with TCP/IP anyway.
> > AFAICS, CAN is a little bit different in this aspect, as it is usually used
> > without a transport-protocol to take care of pacing, and software often assumes
> > that it runs fast enough to receive all frames at "wire-speed", so that
> > software can't deal with an infinitely fast interface.
> >
> > I also understand that increasing RX-queue length can mitigate or solve these
> > problems most of the times, but that is of course no scalable solution.
> >
> > Best regards,
> >  

Best regards,

-- 
David Jander
Protonic Holland.
