From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: iproute2-j1939
Date: Fri, 9 Dec 2011 12:14:59 +0000 (UTC)
Message-ID: <loom.20111209T130823-870@post.gmane.org>
References: <20111208133213.GB964@e-circ.dyndns.org> <loom.20111208T150123-262@post.gmane.org> <20111208151917.GE964@e-circ.dyndns.org> <loom.20111208T171058-366@post.gmane.org> <20111209080726.GA325@e-circ.dyndns.org> <loom.20111209T095640-685@post.gmane.org> <20111209094856.GC325@e-circ.dyndns.org> <loom.20111209T114335-991@post.gmane.org> <20111209110348.GF325@e-circ.dyndns.org> <loom.20111209T120741-948@post.gmane.org> <20111209114740.GG325@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:42431 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab1LIMPR (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 9 Dec 2011 07:15:17 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RYzM9-00084x-50
	for linux-can@vger.kernel.org; Fri, 09 Dec 2011 13:15:13 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 09 Dec 2011 13:15:13 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 09 Dec 2011 13:15:13 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> > > I'm asking myself, do you got regular iproute2 compiled (with CAN)?
> > > I believe you facing problems not related to my j1939 port of them.
> > 
> > Do you mean the iproute2 which is included in the BSP?
> Yes.
> It must have been compiled, and I assume it carries CAN support.
> The j1939 port of iproute2 does fail on things like AF_CAN etc.
> Something must be different.

Ok, I see it is really tough.
At the moment I am building the new toolchain, afterwards I will build a new
BSP. Maybe I have spoilt anything, in the BSP src directory is the ordinary
iproute2-2.6.29-1.tar.bz2 in fact, but maybe a new BSP will help!

--Wolfgang


