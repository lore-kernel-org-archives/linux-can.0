From: Giox79 <giovanniparodi79@gmail.com>
Subject: Re: CAN j1939 library doubts
Date: Thu, 14 Mar 2013 11:17:03 +0000 (UTC)
Message-ID: <loom.20130314T121627-516@post.gmane.org>
References: <loom.20130312T213038-40@post.gmane.org> <854F9BFD-752B-4B2B-A637-7310BCF8B7D2@emailplus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44441 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756688Ab3CNLRW (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 14 Mar 2013 07:17:22 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1UG6AJ-0007M8-P9
	for linux-can@vger.kernel.org; Thu, 14 Mar 2013 12:17:43 +0100
Received: from elgafwout2.elsag.it ([151.89.15.211])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 14 Mar 2013 12:17:43 +0100
Received: from giovanniparodi79 by elgafwout2.elsag.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 14 Mar 2013 12:17:43 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org


Jean-Claude Monnin <jc_monnin <at> emailplus.org> writes:

> 
> Hi,
> Yes, I have been using j1939 on an ARM system in the past (TI AM3505). 
Requires a patched kernel, "iproute2"
> and "can-j1939-utils". jspy worked fine on ARM.
> I cross-compiled the software with ptxdist. I can't provide a tutorial for 
that, but I can share the rules to
> build it in case you are familiar with ptxdist.
> I would like take the opportunity to say that I encourage the effort to bring 
upstream the j1939 stack and
> it's tools. Official tar.* source archives for "iproute2" with j1939 support 
and "can-j1939-utils"
> would be useful for the ptxdist rules.
> Regards,
> Jean-Claude
> 
> On Mar 12, 2013, at 22:52 , Giox79 <giovanniparodi79 <at> gmail.com> wrote:
> 
> > Hello everybody.
> > I'm working on an embedded system, and I would like to dump data 
> > from CAN bus and parse j1939 data. 
> > I built canutils, last version, on ARM device, however, I'm a bit 
> > about how to use the j1939 version of canutils.
> > Is there any tutorial about what should I do in order to use 
> > Utilities  like jspy?
> > If I'm right, I have to build both the kernel and the user app section.
> > I'm a Linux beginner, and I didn't find guides to these steps.
> > Any help, link to website or similar resources will be really appreciated.
> > 
> > Finally is there anyone that compiled the j1939 can libraries on 
> > ARM systems?
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-can" in
> > the body of a message to majordomo <at> vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Hi Jean-Claude,
first thanks for your reply. At present time I don't use the ptxdist system. 
However, as far as I understood, it is a specific kernel distribution configured 
for ARM devices. So if you can provide the rules to build j1939 using ptxdist, 
may be I will be able to use it in my SW setup.
Thanks a lot for you help..

