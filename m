From: Aaron Clarke <ac@aaronclarke.com>
Subject: Re: [can-utils] J1939 v6 (#7)
Date: Wed, 30 Sep 2015 15:26:40 +0000 (UTC)
Message-ID: <loom.20150930T171203-985@post.gmane.org>
References: <linux-can/can-utils/pull/7@github.com> <5608E3EB.5090308@pengutronix.de> <20150929121530.GB14618@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47083 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbbI3PaH (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 30 Sep 2015 11:30:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1ZhJKW-0005pb-3x
	for linux-can@vger.kernel.org; Wed, 30 Sep 2015 17:30:04 +0200
Received: from cpe-104-228-191-198.buffalo.res.rr.com ([104.228.191.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 30 Sep 2015 17:30:04 +0200
Received: from ac by cpe-104-228-191-198.buffalo.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 30 Sep 2015 17:30:04 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Kurt Van Dijck <dev.kurt <at> vandijck-laurijssen.be> writes:


> The lack of extensive userbase made all arguments void.
> In between, the userbase may have grown?
> Given that the pull request is coming from Mikey, the need is growing
> and this may be a proper time to decide on this 

I am working on a j1939 project that could use this and appreciate any
development.  We need a stable solution as soon as possible.

> Any decision implies that some porting to 4.2 kernel needs to be done
> anyway. The latest patches I have for 3.15 are not stable yet. j1939 is
> stable up to 3.12 only.

I ported the 3.15 branch to a 4.1 kernel (patched for beaglebone black) but
it crashes on multi-packet sends.  Is this a know issue with the 3.15
branch?  In any case, I will try the 3.12 kernel branch instead if that is
more stable.

Best regards,

Aaron





