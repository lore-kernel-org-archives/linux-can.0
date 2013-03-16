From: Giox79 <giovanniparodi79@gmail.com>
Subject: Re: CAN j1939 library doubts
Date: Sat, 16 Mar 2013 09:35:06 +0000 (UTC)
Message-ID: <loom.20130316T101827-392@post.gmane.org>
References: <loom.20130312T213038-40@post.gmane.org> <854F9BFD-752B-4B2B-A637-7310BCF8B7D2@emailplus.org> <20130313084248.GA449@vandijck-laurijssen.be> <loom.20130314T121737-364@post.gmane.org> <20130314122045.GD3382@vandijck-laurijssen.be> <loom.20130314T145923-349@post.gmane.org> <20130314210751.GC1387@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49724 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948Ab3CPJfW (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sat, 16 Mar 2013 05:35:22 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1UGnWg-0008A7-Ty
	for linux-can@vger.kernel.org; Sat, 16 Mar 2013 10:35:43 +0100
Received: from host5-127-dynamic.45-79-r.retail.telecomitalia.it ([79.45.127.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Sat, 16 Mar 2013 10:35:42 +0100
Received: from giovanniparodi79 by host5-127-dynamic.45-79-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Sat, 16 Mar 2013 10:35:42 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Kurt Van Dijck <kurt.van.dijck <at> eia.be> writes:

> 
> On Thu, Mar 14, 2013 at 04:20:08PM +0000, Giox79 wrote:
> > Kurt Van Dijck <kurt.van.dijck <at> eia.be> writes:
> > 
> > In order to integrate your libs to my kernel, I was supposing to make a diff 
> > between source file, looking mainly at can and iproute2, merge the diffs and 
> > build the whole system.
> > Do you think this is the right approach?
> no. I (just) prepared the repositories to allow easy merges.
> 
> follow these steps (@Marc, can you just verify the 'git' calls):
> 
> git clone your kernel, or get a stable one
> 	$ git clone http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-
stable.git
> ... this takes time
> 	$ cd linux-stable
> 	$ git tag
> choose a version, like v3.3, or v3.8, ...
> 	$ git checkout <chosen-version>
> 	$ git checkout -b <new-branch-name>
> This last command creates a new branch, so you can play freely.
> Now choose your branch on http://gitorious.org/~kurt-vd/linux-can/linux-can-
j1939
> , like j1939-v3.3
> 	$ git pull git://gitorious.org/~kurt-vd/linux-can/linux-can-j1939.git 
<gitorious-branch-name>
> 
> If this all went ok, then you're ready now.
> 
> The same applies for can-utils & iproute2.
> You could also clone my j1939 versions directly if you do not care about
> the precise versions, like:
> 	$ git clone -b <gitorious-branch-name> git://gitorious.org/~kurt-
vd/linux-can/iproute2-j1939
> with <gitorious-branch-name> something like 'j1939-v3.6'.
> In contrast to the kernel, I never modify iproute2 besides j1939 stuff,
> so this would work very fine.
> Even an .tgz export could work then.
> 
> Kind regards,
> Kurt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


Kurt, thanks again for your help.
Today I received the board on which I have to develop the SW system, and the 
Kernel ported to this specific EVM is a 2.6.35.3, so I won't be able to use on 
the original patched source code the approach that you suggested, since I'm not 
using a kernel 3 release.

I think that at present time I have to change my approach. I will try to follow 
the idea that you suggested me, starting from official kernel releases, and I 
will ask EVM SW producers to help me figure out what kind of patches I will have 
to apply in order to support their HW.
Thanks again for your help, you have been really kind.
May be in the next week I will have some news.
Giovanni





