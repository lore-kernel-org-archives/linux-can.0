From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: backporting can & can-j1939
Date: Wed, 14 Dec 2011 18:19:45 +0000 (UTC)
Message-ID: <loom.20111214T190347-790@post.gmane.org>
References: <20111209150133.GA1470@e-circ.dyndns.org> <loom.20111209T175414-826@post.gmane.org> <20111212081217.GA351@e-circ.dyndns.org> <loom.20111212T121257-904@post.gmane.org> <20111212124031.GD351@e-circ.dyndns.org> <loom.20111212T160733-221@post.gmane.org> <20111213095312.GC430@e-circ.dyndns.org> <loom.20111213T155714-170@post.gmane.org> <20111213155110.GA314@e-circ.dyndns.org> <loom.20111214T140958-737@post.gmane.org> <20111214154351.GB6112@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:33138 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755373Ab1LNSUD (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 14 Dec 2011 13:20:03 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RatQv-0008Vo-L7
	for linux-can@vger.kernel.org; Wed, 14 Dec 2011 19:20:01 +0100
Received: from p549CA325.dip.t-dialin.net ([84.156.163.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 14 Dec 2011 19:20:01 +0100
Received: from wutz by p549CA325.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 14 Dec 2011 19:20:01 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> Hold here: Your 2.6.31 is too old for this feature.
> You must do : $ echo can0 > /proc/net/can-j1939/net
> as a legacy measure.
> 
> You will be able to use $ip for adding/removing addressing info.

Ok, I will try that.

> > Error: either "dev" is duplicate, or "j1939" is a garbage.
> 
> This makes me think you have the original 'stock' iproute2, and not
> the iproute2-j1939 one (but I'm not sure yet today).

Yes, you are right I was using the 'stock' iproute2, should I replace the stock 
with the j1939 iproute2, before compiling the kernel? I think I understood that 
wrong. 
Do I have to replace the can-utils as well; I am still not complete aware how
the respitories differ from each other


--Wolfgang


