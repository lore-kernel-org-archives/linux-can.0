From: Richard Andrysek <richard.andrysek@rg-mechatronics.com>
Subject: Re: arbitration lost error reporting
Date: Mon, 9 Dec 2013 09:01:36 +0000 (UTC)
Message-ID: <loom.20131209T093912-850@post.gmane.org>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <loom.20131205T164221-222@post.gmane.org> <52A0BCD9.4090309@grandegger.com> <loom.20131205T202627-307@post.gmane.org> <52A0E185.1080402@grandegger.com> <loom.20131206T100036-664@post.gmane.org> <52A1A323.1030605@pengutronix.de> <loom.20131206T114831-779@post.gmane.org> <52A1B8DA.1030700@pengutronix.de> <52A1BCEE.5070101@hartkopp.net> <52A21082.9010102@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55483 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754336Ab3LIJCB (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 9 Dec 2013 04:02:01 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Vpwj1-0002Va-Lb
	for linux-can@vger.kernel.org; Mon, 09 Dec 2013 10:01:59 +0100
Received: from apollon.rg-mechatronics.com ([62.225.122.120])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 09 Dec 2013 10:01:59 +0100
Received: from richard.andrysek by apollon.rg-mechatronics.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 09 Dec 2013 10:01:59 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

...
> >> big change of going mainline. The implementation is similar to
> >> CAN_CTRLMODE_BERR_REPORTING, just look for it in the kernel source tree
> >> and add a new define for arbitration lost error reporting.
> >>
> >> Do you have a preferred name for the define?
> >> - CAN_CTRLMODE_AERR_REPORTING
> >> - CAN_CTRLMODE_ARBITRATIONERR_REPORTING to
> > 
> > Loosing the arbitration is not an error. It just can happen from time to
time.
> 
> Well, if it does not happen often, why do we want to suppress reporting
> this error? I still do not see what it's good for.
> 
> Wolfgang.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

How do you define not often? Is it not often one time per ~130us? For X
channels you should divide it through X. Please assume this case stochastic
=> not always. 
Next if the information is for an application irrelevant, why I need to
generate an IRQ and use CPU resources?

How to fight with such case:

1) Use time triggered protocol - not always possible 
2) Slow done communication - not always possible
3) Buy faster machine - not always possible
4) Combination of 1..4 - ...

or

5) Let a freedom to a programmer, for the price that he shall to know it.










