From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: using j1939: userspace binaries
Date: Thu, 8 Dec 2011 12:48:53 +0000 (UTC)
Message-ID: <loom.20111208T134455-791@post.gmane.org>
References: <20111206104432.91170@gmx.net> <20111206121403.GB322@e-circ.dyndns.org> <loom.20111206T131950-88@post.gmane.org> <20111206131815.GD322@e-circ.dyndns.org> <loom.20111207T093827-478@post.gmane.org> <20111207143333.GD373@e-circ.dyndns.org> <20111207145032.GE373@e-circ.dyndns.org> <loom.20111208T120006-91@post.gmane.org> <20111208123004.GA964@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59347 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773Ab1LHMtI (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 8 Dec 2011 07:49:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RYdPP-0004cl-F2
	for linux-can@vger.kernel.org; Thu, 08 Dec 2011 13:49:07 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 08 Dec 2011 13:49:07 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 08 Dec 2011 13:49:07 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> > Where do I have to place this 2 folders now
> all binaries in ..../usr/bin should go in /usr/bin on the target.

ok just copy and paste? But from which directory the one generated 
by can-j1939-utils or iproute2-j1939 because they contain both 
all the same binaries.

--Wolfgang

