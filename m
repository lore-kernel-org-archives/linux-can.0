From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: iproute2-j1939
Date: Fri, 9 Dec 2011 09:02:53 +0000 (UTC)
Message-ID: <loom.20111209T095640-685@post.gmane.org>
References: <loom.20111207T093827-478@post.gmane.org> <20111207143333.GD373@e-circ.dyndns.org> <20111207145032.GE373@e-circ.dyndns.org> <loom.20111208T120006-91@post.gmane.org> <20111208123004.GA964@e-circ.dyndns.org> <loom.20111208T134455-791@post.gmane.org> <20111208133213.GB964@e-circ.dyndns.org> <loom.20111208T150123-262@post.gmane.org> <20111208151917.GE964@e-circ.dyndns.org> <loom.20111208T171058-366@post.gmane.org> <20111209080726.GA325@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:42695 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196Ab1LIJDM (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 9 Dec 2011 04:03:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RYwMD-00050X-AQ
	for linux-can@vger.kernel.org; Fri, 09 Dec 2011 10:03:07 +0100
Received: from fire.makon-engineering.de ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 09 Dec 2011 10:03:05 +0100
Received: from wutz by fire.makon-engineering.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 09 Dec 2011 10:03:05 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> can.h got updated (struct can_addr extended), but I'm not sure
> exactly which paths must be updated.

OK, so do you think I have to replace the existing can.h with the can.h from
can-j1939-modules?

Or is it possible that the af_can.h (found in can-j1939-modules/net/can)
has to be included in the utils.c file (utils.c:518: error: 'AF_CAN'\
 undeclared (first use in this function), it's just an idea?



