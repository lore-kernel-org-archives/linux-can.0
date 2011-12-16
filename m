From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: using can-j1939
Date: Fri, 16 Dec 2011 09:00:45 +0000 (UTC)
Message-ID: <loom.20111216T095547-967@post.gmane.org>
References: <20111214154351.GB6112@e-circ.dyndns.org> <loom.20111214T190347-790@post.gmane.org> <20111214204237.GC306@e-circ.dyndns.org> <loom.20111215T085023-710@post.gmane.org> <20111215092018.GB321@e-circ.dyndns.org> <loom.20111215T114301-18@post.gmane.org> <20111215120434.GD321@e-circ.dyndns.org> <loom.20111215T142642-767@post.gmane.org> <20111215140012.GA10848@e-circ.dyndns.org> <loom.20111215T152334-981@post.gmane.org> <20111216083708.GA323@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:39517 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924Ab1LPJBF (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 16 Dec 2011 04:01:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RbTf1-0007NM-3u
	for linux-can@vger.kernel.org; Fri, 16 Dec 2011 10:00:59 +0100
Received: from fire.makon-engineering.de ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 16 Dec 2011 10:00:59 +0100
Received: from wutz by fire.makon-engineering.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 16 Dec 2011 10:00:59 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> Are the packets 'broadcasted' or destination specific?

The packets are destination specific. But I was wrong the, it should read and
write from both bus' - sorry, but only 2 specific address'!

--Wolfgang


