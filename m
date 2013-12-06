From: Richard Andrysek <richard.andrysek@rg-mechatronics.com>
Subject: Re: arbitration lost error reporting
Date: Fri, 6 Dec 2013 13:21:06 +0000 (UTC)
Message-ID: <loom.20131206T140921-289@post.gmane.org>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <loom.20131205T164221-222@post.gmane.org> <52A0BCD9.4090309@grandegger.com> <loom.20131205T202627-307@post.gmane.org> <52A0E185.1080402@grandegger.com> <loom.20131206T100036-664@post.gmane.org> <52A1A323.1030605@pengutronix.de> <loom.20131206T114831-779@post.gmane.org> <52A1B8DA.1030700@pengutronix.de> <52A1BCEE.5070101@hartkopp.net> <52A1C02F.6050106@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54482 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162117Ab3LFNV3 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 6 Dec 2013 08:21:29 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1VovLT-0002Y9-FA
	for linux-can@vger.kernel.org; Fri, 06 Dec 2013 14:21:27 +0100
Received: from apollon.rg-mechatronics.com ([62.225.122.120])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 06 Dec 2013 14:21:27 +0100
Received: from richard.andrysek by apollon.rg-mechatronics.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 06 Dec 2013 14:21:27 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Marc Kleine-Budde <mkl <at> pengutronix.de> writes:


> > If you thing about a define, what about:
> > 
> > [ ] CAN_CTRLMODE_ARB_LOST_REPORTING
> > [x] CAN_CTRLMODE_ARBITRATION_LOST_REPORTING
> 
> Marc
> 

To be more compatible with compilers and standards the option 1 is prefferd.
This one si only 32 characters long.


