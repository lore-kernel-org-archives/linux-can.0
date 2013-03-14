From: Giox79 <giovanniparodi79@gmail.com>
Subject: Re: CAN j1939 library doubts
Date: Thu, 14 Mar 2013 11:17:51 +0000 (UTC)
Message-ID: <loom.20130314T121737-364@post.gmane.org>
References: <loom.20130312T213038-40@post.gmane.org> <854F9BFD-752B-4B2B-A637-7310BCF8B7D2@emailplus.org> <20130313084248.GA449@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44611 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756688Ab3CNLTo (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 14 Mar 2013 07:19:44 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1UG6Ca-0001DQ-Qt
	for linux-can@vger.kernel.org; Thu, 14 Mar 2013 12:20:04 +0100
Received: from elgafwout2.elsag.it ([151.89.15.211])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 14 Mar 2013 12:20:04 +0100
Received: from giovanniparodi79 by elgafwout2.elsag.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 14 Mar 2013 12:20:04 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Kurt Van Dijck <kurt.van.dijck <at> eia.be> writes:

> 
> Hi,
> 
> iproute2, can-utils & kernel needs patches.
> 
> My 'latest' git archives http://gitorious.org/~kurt-vd/  will work,
> but you probably want to merge the necessary patches into later versions.
> 
> I plan to do some effort to assemble an howto on elinux.org.
> 
> Kind regards,
> Kurt
> 
> On Wed, Mar 13, 2013 at 09:29:01AM +0100, Jean-Claude Monnin wrote:
> > Hi,
> > Yes, I have been using j1939 on an ARM system in the past (TI AM3505). 
Requires a patched kernel, "iproute2"
> and "can-j1939-utils". jspy worked fine on ARM.
> > I cross-compiled the software with ptxdist. I can't provide a tutorial for 
that, but I can share the rules
> to build it in case you are familiar with ptxdist.
> > I would like take the opportunity to say that I encourage the effort to 
bring upstream the j1939 stack and
> it's tools. Official tar.* source archives for "iproute2" with j1939 support 
and "can-j1939-utils"
> would be useful for the ptxdist rules.
> > Regards,
> > Jean-Claude
> > 
> > On Mar 12, 2013, at 22:52 , Giox79 <giovanniparodi79 <at> gmail.com> wrote:
> > 
> > > Hello everybody.
> > > I'm working on an embedded system, and I would like to dump data 
> > > from CAN bus and parse j1939 data. 
> > > I built canutils, last version, on ARM device, however, I'm a bit 
> > > about how to use the j1939 version of canutils.
> > > Is there any tutorial about what should I do in order to use 
> > > Utilities  like jspy?
> > > If I'm right, I have to build both the kernel and the user app section.
> > > I'm a Linux beginner, and I didn't find guides to these steps.
> > > Any help, link to website or similar resources will be really appreciated.
> > > 
> > > Finally is there anyone that compiled the j1939 can libraries on 
> > > ARM systems?
> > > 
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-can" in
> > > the body of a message to majordomo <at> vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-can" in
> > the body of a message to majordomo <at> vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

I Kurt, 
thanks for your reply. I have a question related to J1939. My task is to extract 
from raw can packets info like oil, brake pressure and so on.
Can you tell me if it is right that after building the kernel for my board using 
your modified can driver, and using the jspy utils, I will have only to build 
the J1939 parser?
Is there any utility that will allow me parsing the standard (not vendor 
dependent)packets?
If I will be successfull building the J1939 in my SW environment, I will try to 
create a little howto.
If you think this can be useful, I will send it to you.
have a nice day

