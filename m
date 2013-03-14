From: Giox79 <giovanniparodi79@gmail.com>
Subject: Re: CAN j1939 library doubts
Date: Thu, 14 Mar 2013 16:20:08 +0000 (UTC)
Message-ID: <loom.20130314T145923-349@post.gmane.org>
References: <loom.20130312T213038-40@post.gmane.org> <854F9BFD-752B-4B2B-A637-7310BCF8B7D2@emailplus.org> <20130313084248.GA449@vandijck-laurijssen.be> <loom.20130314T121737-364@post.gmane.org> <20130314122045.GD3382@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34419 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755915Ab3CNQUe (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 14 Mar 2013 12:20:34 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1UGAth-0005KT-Fj
	for linux-can@vger.kernel.org; Thu, 14 Mar 2013 17:20:53 +0100
Received: from elgafwout2.elsag.it ([151.89.15.211])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 14 Mar 2013 17:20:53 +0100
Received: from giovanniparodi79 by elgafwout2.elsag.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 14 Mar 2013 17:20:53 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Kurt Van Dijck <kurt.van.dijck <at> eia.be> writes:

> 
> On Thu, Mar 14, 2013 at 11:17:51AM +0000, Giox79 wrote:
> > Kurt Van Dijck <kurt.van.dijck <at> eia.be> writes:
> > 
> > > 
> > 
> > Hi Kurt, 
> > thanks for your reply. I have a question related to J1939. My task is to 
extract 
> > from raw can packets info like oil, brake pressure and so on.
> > Can you tell me if it is right that after building the kernel for my board 
using 
> > your modified can driver, and using the jspy utils, I will have only to 
build 
> > the J1939 parser?
> 
> I think you could do that without jspy.
> You could write a program that connect to a j1939 socket, similar to jspy,
> and listen to any packet that if of your interest.
> You would get the PGN's as binary streams (possible >8 bytes)
> 
> Your program will get quite straight-forward then.
> 
> I assume you won't need Address Claiming, since you're watching generic PGN's?
> 
> > Is there any utility that will allow me parsing the standard (not vendor 
> > dependent)packets?
> > If I will be successfull building the J1939 in my SW environment, I will try 
to 
> > create a little howto.
> > If you think this can be useful, I will send it to you.
> > have a nice day
> 


Hi Kurt, thanks a lot for your help.
You are right as far as I know about can, I do not need address claiming, I have 
to implement a can2lan converter and to support translation of standard can 
messages to an more "clear" form (creating web pages or something like that).

In order to integrate your libs to my kernel, I was supposing to make a diff 
between source file, looking mainly at can and iproute2, merge the diffs and 
build the whole system.
Do you think this is the right approach?
Thanks a lot for your useful help


