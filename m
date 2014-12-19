From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: [PATCH v5 0/5] Consolidate and unify state change handling
Date: Fri, 19 Dec 2014 00:05:16 +0000 (UTC)
Message-ID: <loom.20141219T004928-872@post.gmane.org>
References: <a0f69b4e-b1d5-4c3e-b960-b9f2b34a4e1a@GRBSR0089.marel.net> <loom.20141218T070747-796@post.gmane.org> <549280D0.6060507@hartkopp.net> <20141218121502.24633.14829@shannon> <5492D0A8.1060000@hartkopp.net> <5492DC38.9090501@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50604 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbaLSAF2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 18 Dec 2014 19:05:28 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Y1l4Q-0003G3-Af
	for linux-can@vger.kernel.org; Fri, 19 Dec 2014 01:05:26 +0100
Received: from motec6.motec.com.au ([115.70.189.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 19 Dec 2014 01:05:26 +0100
Received: from tom_usenet by motec6.motec.com.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 19 Dec 2014 01:05:26 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Oliver Hartkopp <socketcan <at> hartkopp.net> writes:

> The candump in can-utils provide this option:
>
>    https://gitorious.org/linux-can/can-utils/ 
... 
> I had to update the commit message due to a typo.
> 
> Please pull again - if you already did.

Thanks for these rapid responses.

What is the relationship (if any) between this "can-utils" package and the
"canutils" (latest update June 2010) that we're using from here?

    http://www.pengutronix.de/software/socket-can/download/canutils/v4.0/

I note some common authorship (Marc Kleine-Budde).

Both have cansend and candump utils, but the Pengutronics one also has
"conconfig" which we rely on.

Tom


