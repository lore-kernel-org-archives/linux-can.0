From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: using can-j1939
Date: Fri, 16 Dec 2011 14:29:45 +0000 (UTC)
Message-ID: <loom.20111216T150333-707@post.gmane.org>
References: <20111214204237.GC306@e-circ.dyndns.org> <loom.20111215T085023-710@post.gmane.org> <20111215092018.GB321@e-circ.dyndns.org> <loom.20111215T114301-18@post.gmane.org> <20111215120434.GD321@e-circ.dyndns.org> <loom.20111215T142642-767@post.gmane.org> <20111215140012.GA10848@e-circ.dyndns.org> <loom.20111215T152334-981@post.gmane.org> <20111216083708.GA323@e-circ.dyndns.org> <loom.20111216T095547-967@post.gmane.org> <20111216093308.GB669@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50150 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759429Ab1LPO36 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 16 Dec 2011 09:29:58 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RbYnM-00008C-RQ
	for linux-can@vger.kernel.org; Fri, 16 Dec 2011 15:29:56 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 16 Dec 2011 15:29:56 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 16 Dec 2011 15:29:56 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> > The packets are destination specific.
> > But I was wrong the, it should read and
> > write from both bus' - sorry, but only 2 specific address'!
> Even that is no problem...

OK, this sounds great. I am just browsing through the documentation and wondering
if it is possible to activate j1939 per default, that it would be possible to use
the target as stand alone.

--Wolfgang



