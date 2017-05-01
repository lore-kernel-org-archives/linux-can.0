From: David Jander <david@protonic.nl>
Subject: RFC: Pacing support in vcan?
Date: Mon, 1 May 2017 09:24:49 +0200
Message-ID: <20170501092449.7b6cade3@erd980>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:3446 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968664AbdEAHzf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 May 2017 03:55:35 -0400
Received: from erd980 (erd980.prtnl [192.168.224.10])
        by protonic.xs4all.nl (Postfix) with ESMTP id AA6E32803F
        for <linux-can@vger.kernel.org>; Mon,  1 May 2017 09:24:28 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org


Hi all,

I suspect this must have been brought up before, but I can't find discussion
about this topic... sorry if I missed that.

Currently the VCAN driver is infinitely fast, which is probably fine for most
simple applications and testing simple CAN code. Unfortunately I have had a
few cases where this is a problem. For example when testing software
implementations of transport protocols, where a producer generates can frames
basically as fast as possible. Two or more consumers receiving this stream are
just a little bit slower (in processing data) than the producer, so I would
start losing frames. Of course the TP takes care of this, but since that is
what I am trying to test/debug, this can be bothersome.

So the question is whether a proposal to introduce optional pacing of vcan
would be accepted?

Maybe something like (optional) virtual bitrate simulation?
I understand that other "loopback" interfaces, like "lo" don't have this and
don't want this, but in those cases we usually deal with TCP/IP anyway.
AFAICS, CAN is a little bit different in this aspect, as it is usually used
without a transport-protocol to take care of pacing, and software often assumes
that it runs fast enough to receive all frames at "wire-speed", so that
software can't deal with an infinitely fast interface.

I also understand that increasing RX-queue length can mitigate or solve these
problems most of the times, but that is of course no scalable solution.

Best regards,

-- 
David Jander
Protonic Holland.
