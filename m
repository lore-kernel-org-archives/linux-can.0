From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Using can & can-j1939
Date: Wed, 14 Dec 2011 21:42:37 +0100
Message-ID: <20111214204237.GC306@e-circ.dyndns.org>
References: <20111212081217.GA351@e-circ.dyndns.org>
 <loom.20111212T121257-904@post.gmane.org>
 <20111212124031.GD351@e-circ.dyndns.org>
 <loom.20111212T160733-221@post.gmane.org>
 <20111213095312.GC430@e-circ.dyndns.org>
 <loom.20111213T155714-170@post.gmane.org>
 <20111213155110.GA314@e-circ.dyndns.org>
 <loom.20111214T140958-737@post.gmane.org>
 <20111214154351.GB6112@e-circ.dyndns.org>
 <loom.20111214T190347-790@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay002.isp.belgacom.be ([195.238.6.175]:44023 "EHLO
	mailrelay002.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757007Ab1LNUml (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Dec 2011 15:42:41 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111214T190347-790@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Wed, Dec 14, 2011 at 06:19:45PM +0000, Wolfgang wrote:
> > > Error: either "dev" is duplicate, or "j1939" is a garbage.
> > 
> > This makes me think you have the original 'stock' iproute2, and not
> > the iproute2-j1939 one (but I'm not sure yet today).
> 
> Yes, you are right I was using the 'stock' iproute2
That explains things :-)

> should I replace the stock 
> with the j1939 iproute2, before compiling the kernel?
No, not before 'compiling' the kernel.
But before 'using' the j1939 options from the newly compiled kernel.
> I think I understood that wrong. 
Not really..., see below

> Do I have to replace the can-utils as well;
Yes,
> I am still not complete aware how
> the respitories differ from each other
I did never really explain this, therefore:
I added j1939 into the kernel => recompile kernel.
I added j1939 configuration to iproute2 => replace iproute2 for using j1939
I added some specific j1939 support & monitoring tools (jacd, ...) => 
	replace can-utils for using j1939

Summarize: the real core of j1939 is in kernel space.
To get it up & running, you need some (smaller) userspace modifications.

I hope this demistifies a tiny bit

Kind regards,
Kurt
