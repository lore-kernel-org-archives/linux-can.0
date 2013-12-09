From: Richard Andrysek <richard.andrysek@rg-mechatronics.com>
Subject: Re: [PATCH v6] can: sja1000: fix =?utf-8?b?e3ByZSxwb3N0fV9pcnEoKQ==?= handling and IRQ handler return value
Date: Mon, 9 Dec 2013 09:29:23 +0000 (UTC)
Message-ID: <loom.20131209T101448-258@post.gmane.org>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <loom.20131205T164221-222@post.gmane.org> <52A0BCD9.4090309@grandegger.com> <loom.20131205T202627-307@post.gmane.org> <52A0E185.1080402@grandegger.com> <loom.20131206T100036-664@post.gmane.org> <ac6a947c7ec842f67e9d23abd877b884@grandegger.com> <loom.20131206T112023-62@post.gmane.org> <52A21837.3030709@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38674 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754765Ab3LIJ3t (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 9 Dec 2013 04:29:49 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Vpx9v-0007JN-R8
	for linux-can@vger.kernel.org; Mon, 09 Dec 2013 10:29:47 +0100
Received: from apollon.rg-mechatronics.com ([62.225.122.120])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 09 Dec 2013 10:29:47 +0100
Received: from richard.andrysek by apollon.rg-mechatronics.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 09 Dec 2013 10:29:47 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> 
> On 12/06/2013 11:32 AM, Richard Andrysek wrote:
> > Wolfgang Grandegger <wg <at> grandegger.com> writes:
> > 
> >>
> >> ...
> >>
> >>> I've just studied sja1000.c I do not know yet, if it is healthy.
> >>
> >> This is normally due to hardware/electrical problems. It has nothing to do
> >>
> >> with software. Well, is there *any* relation to the patch mentioned in the
> >>
> >> subject? I mean, does the problem *not* show up without that patch.
> > 
> > 
> > Patch solved a problem with unhandled IRQs. The original problem is solved.
> 
> What did it fix? Could you elaborate on that issue. You actually never
> reported a problem.
> 
> Wolfgang.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

I've reported a problem by peak-systems and they recommend me this patch.
Without this patch with gotos, it leaves unhandled IRQs, e.g.:

Dec  1 04:59:33 xxx kernel: [141189.277965] irq 19: nobody cared (try
booting with the "irqpoll" option)
...
Dec  1 04:59:33 xxx kernel: [141189.278131] Disabling IRQ #19


With this patch the sja1000 IRQs are not lost. 


