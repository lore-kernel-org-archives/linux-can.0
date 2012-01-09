From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: recv list
Date: Mon, 9 Jan 2012 16:35:08 +0000 (UTC)
Message-ID: <loom.20120109T162926-984@post.gmane.org>
References: <20120109132638.GI386@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:52112 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932304Ab2AIQfY (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 9 Jan 2012 11:35:24 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RkIBu-0007qL-W2
	for linux-can@vger.kernel.org; Mon, 09 Jan 2012 17:35:23 +0100
Received: from fire.makon-engineering.de ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 09 Jan 2012 17:35:22 +0100
Received: from wutz by fire.makon-engineering.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 09 Jan 2012 17:35:22 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> I think what happens is that your engine ECU (0x00) does address claiming.
I am using on both interfaces a simulator tool, so I think there is not ac.

> During recvfrom, its 8byte name is returned in src_addr too.

		printf("%lld\n", src_addr.can_addr.j1939.name);

after recvfrom is returning always a '0'

> Since that name has not been seen on the second network, you get an error.
> 
> Try clearing the destination NAME by:

I have cleared the name but it is still saying 'sendto failed: Machine is not 
on the network'. By the way 'recv' and 'send' is working. 


--Wolfgang




