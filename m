From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: using can-j1939
Date: Thu, 15 Dec 2011 16:17:50 +0000 (UTC)
Message-ID: <loom.20111215T165938-602@post.gmane.org>
References: <20111214204237.GC306@e-circ.dyndns.org> <loom.20111215T085023-710@post.gmane.org> <20111215092018.GB321@e-circ.dyndns.org> <loom.20111215T114301-18@post.gmane.org> <20111215120434.GD321@e-circ.dyndns.org> <loom.20111215T142642-767@post.gmane.org> <20111215140012.GA10848@e-circ.dyndns.org> <loom.20111215T152334-981@post.gmane.org> <20111215150627.GB10848@e-circ.dyndns.org> <loom.20111215T161056-479@post.gmane.org> <20111215155024.GC10848@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:46097 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759104Ab1LOQSD (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 15 Dec 2011 11:18:03 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RbE0Q-00022J-5e
	for linux-can@vger.kernel.org; Thu, 15 Dec 2011 17:18:02 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Dec 2011 17:18:02 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Dec 2011 17:18:02 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> Do you relay them (on the second bus) using the same source address, 
>i.e.to all 3 PGN's use the same source address when sent out?
> The source addresses of the 3 received PGN's (on the first bus) 
>do not matter.
 
 In fact, a limited number here is fine too.
 The thing is, my can-j1939 stack is (BSD sockets alike) assigned a 
limited number of J1939 source addresses. Only those source addresses 
are allowed in outgoing packets (a bit like IP networks, 
and probably others)


No, all 3 PGNs are sent by one sender(source)!

--Wolfgang



