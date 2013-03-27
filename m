From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Parsing j1939 from raw candump
Date: Wed, 27 Mar 2013 09:09:26 +0100
Message-ID: <20130327080926.GA449@vandijck-laurijssen.be>
References: <loom.20130325T214842-307@post.gmane.org>
 <20130326191831.GA22696@vandijck-laurijssen.be>
 <loom.20130326T221001-133@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay002.isp.belgacom.be ([195.238.6.175]:59677 "EHLO
	mailrelay002.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750789Ab3C0IJd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Mar 2013 04:09:33 -0400
Content-Disposition: inline
In-Reply-To: <loom.20130326T221001-133@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Giox79 <giovanniparodi79@gmail.com>
Cc: linux-can@vger.kernel.org

On Tue, Mar 26, 2013 at 09:17:40PM +0000, Giox79 wrote:
> Hi Kurt, first thanks a lot
> 
> Kurt Van Dijck <kurt.van.dijck <at> eia.be> writes:
> 
> > 
> > On Mon, Mar 25, 2013 at 09:02:43PM +0000, Giox79 wrote:
> > > Is there anyone that can suggest me how to approach 
> > > this topic? I tried using the j1939-71 standard, 
> > > but as far as I understand, it explains differences between 
> > > different packages, but I didn't find an 
> > > explanation about header and trailer of J1939 packet.
> > 
> > j1939-21 & j1939-81
> > are the ones used by the j1939 linux kernel.
> 
> Mumble, I was wrong.
> So as far as I understand, I have to use J1939-71 only after decoding from raw 
> to j1939 using the suggested docs.
> I can use 71 to understand the payload of J1939 packets.
> Am I right?
like the 'userspace' interpretation of the binary data? Yes.
> 
> > 
> > > Please note that I have the whole j1939 standard and that 
> > > at present time I can't integrate the j1939 canutils in linux 
> > > kernel because I should use for other kind of constraints 
> > > a 2.6 linux kernel.
> > 
> > which specific 2.6 one did it start from (like 2.6.28 or 2.6.35 or ...)
> 
> The version is 2.6.35.3
I'll take a look if backporting linux-j1939 to 2.6.35 is feasible.
Btw, I still run a platform with 2.6.25 _and_ a backported j1939.
But 2.6.25 lacks some infrastructure, and I had to come up with less
elegant procfs tunables to replace iproute2 commands.
The rest of the API (i.e. socket interface) is equal.

I'll take a look...

Kind regards,
Kurt
