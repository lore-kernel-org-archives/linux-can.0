From: Giox79 <giovanniparodi79@gmail.com>
Subject: Re: Parsing j1939 from raw candump
Date: Tue, 26 Mar 2013 21:17:40 +0000 (UTC)
Message-ID: <loom.20130326T221001-133@post.gmane.org>
References: <loom.20130325T214842-307@post.gmane.org> <20130326191831.GA22696@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43883 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274Ab3CZVSD (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 26 Mar 2013 17:18:03 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1UKbG9-0008IN-Ke
	for linux-can@vger.kernel.org; Tue, 26 Mar 2013 22:18:21 +0100
Received: from host206-120-dynamic.25-79-r.retail.telecomitalia.it ([79.25.120.206])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 26 Mar 2013 22:18:21 +0100
Received: from giovanniparodi79 by host206-120-dynamic.25-79-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 26 Mar 2013 22:18:21 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Kurt, first thanks a lot

Kurt Van Dijck <kurt.van.dijck <at> eia.be> writes:

> 
> On Mon, Mar 25, 2013 at 09:02:43PM +0000, Giox79 wrote:
> > Is there anyone that can suggest me how to approach 
> > this topic? I tried using the j1939-71 standard, 
> > but as far as I understand, it explains differences between 
> > different packages, but I didn't find an 
> > explanation about header and trailer of J1939 packet.
> 
> j1939-21 & j1939-81
> are the ones used by the j1939 linux kernel.

Mumble, I was wrong.
So as far as I understand, I have to use J1939-71 only after decoding from raw 
to j1939 using the suggested docs.
I can use 71 to understand the payload of J1939 packets.
Am I right?

> 
> > Please note that I have the whole j1939 standard and that 
> > at present time I can't integrate the j1939 canutils in linux 
> > kernel because I should use for other kind of constraints 
> > a 2.6 linux kernel.
> 
> which specific 2.6 one did it start from (like 2.6.28 or 2.6.35 or ...)

The version is 2.6.35.3
> 
> > Any help, reference to specific sections of j1939 standard
> >  and so on will be appreciated.
> > Giovanni
> > 
> > --

> > To unsubscribe from this list: send the line "unsubscribe linux-can" in
> > the body of a message to majordomo <at> vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 



