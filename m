From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: recv list
Date: Fri, 6 Jan 2012 18:25:59 +0000 (UTC)
Message-ID: <loom.20120106T190304-160@post.gmane.org>
References: <20111221155314.GC12050@e-circ.dyndns.org> <loom.20111222T115004-22@post.gmane.org> <20111223110445.GB12091@e-circ.dyndns.org> <loom.20111228T114009-686@post.gmane.org> <20120104094715.GB320@e-circ.dyndns.org> <loom.20120104T160223-182@post.gmane.org> <20120104204151.GA306@e-circ.dyndns.org> <loom.20120105T113439-912@post.gmane.org> <20120105120930.GA372@e-circ.dyndns.org> <loom.20120105T215714-788@post.gmane.org> <20120106122550.GA17043@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:43293 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758961Ab2AFS0Q (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 6 Jan 2012 13:26:16 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RjEUY-00007H-Nc
	for linux-can@vger.kernel.org; Fri, 06 Jan 2012 19:26:14 +0100
Received: from p549CCB01.dip.t-dialin.net ([84.156.203.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 06 Jan 2012 19:26:14 +0100
Received: from wutz by p549CCB01.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 06 Jan 2012 19:26:14 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> tried 'jspy' yet?

It is not possible because at the moment I am working with a simulation tool,
to get out how things are working, is this a problem?

Now I have a different question, is it possible to bind different sockets with
different src.addr to one interface. Because it is saying 'bind failed: Device 
or resource busy' if I want to do this ('$ip addr add j1939 0x01 dev can0' is 
working, of course) Or do I have to do this with recvmsg()? 
Because as you know I want keep the various src address'.

Kind regards,
Wolfgang



