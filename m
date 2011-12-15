From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: replacing iproute2 & can-utils with j1939 variants
Date: Thu, 15 Dec 2011 13:43:30 +0000 (UTC)
Message-ID: <loom.20111215T142642-767@post.gmane.org>
References: <20111213095312.GC430@e-circ.dyndns.org> <loom.20111213T155714-170@post.gmane.org> <20111213155110.GA314@e-circ.dyndns.org> <loom.20111214T140958-737@post.gmane.org> <20111214154351.GB6112@e-circ.dyndns.org> <loom.20111214T190347-790@post.gmane.org> <20111214204237.GC306@e-circ.dyndns.org> <loom.20111215T085023-710@post.gmane.org> <20111215092018.GB321@e-circ.dyndns.org> <loom.20111215T114301-18@post.gmane.org> <20111215120434.GD321@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45642 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab1LONnq (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 15 Dec 2011 08:43:46 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RbBb7-0000fw-4r
	for linux-can@vger.kernel.org; Thu, 15 Dec 2011 14:43:45 +0100
Received: from fire.makon-engineering.de ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Dec 2011 14:43:45 +0100
Received: from wutz by fire.makon-engineering.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Dec 2011 14:43:45 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I copied all things as you told me, I think/hope the hardest part is over now.
Thank you!!


What do I have to do afterwards I did

$ echo can0 /proc/net/can-j1939/net

because if I do '$ifconfig can0 up' it responses with 

mpc52xx_can 80001300.mscan: bit-timing not yet defined
ifconfig: SIOCSIFFLAGS: Invalid argument


(Just for information this time different answer:
$ ip link set can0 j1939 on
RTNETLINK answers: Invalid argument )

Is there any documentation or is it possible to use cangw with API?

--Wolfgang



