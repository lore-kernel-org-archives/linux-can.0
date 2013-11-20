From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [PATCH v3] can: fix sja1000 pre_irq/post_irq handling
Date: Wed, 20 Nov 2013 10:28:27 +0100
Message-ID: <20131120092826.GB10573@vandijck-laurijssen.be>
References: <528A0F9A.6070305@hartkopp.net>
 <20131118211557.GA3084@vandijck-laurijssen.be>
 <528C57B1.8000006@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:56753 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752033Ab3KTJ2c (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Nov 2013 04:28:32 -0500
Content-Disposition: inline
In-Reply-To: <528C57B1.8000006@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>

Oliver,

On Wed, Nov 20, 2013 at 07:33:21AM +0100, Oliver Hartkopp wrote:
> 
> 
> On 18.11.2013 22:15, Kurt Van Dijck wrote:
> > Oliver,
> > 
> > On Mon, Nov 18, 2013 at 02:01:14PM +0100, Oliver Hartkopp wrote:
> >> The SJA1000 driver provides optional function pointers to handle specific
> >> hardware setups at interrupt time.
> >>
> >> This patch fixes the issue that the sja1000_interrupt() function may have
> >> returned IRQ_NONE without processing the post_irq function. Additionally
> >> an introduced and documented return value from the pre_irq function is
> >> checked to skip the entire interrupt handling on pre_irq function errors.
> > 
> > You combine fixes and new features in 1 patch.
> 
> You are right. The return value is not really a fix.
> 
> > Both are tried in addressing the problem with peak_pci,
> > but that doesn't make them depend on each other.
> 
> It mainly isn't related to peak_pci. It just emerged in the code review when
> investigating an issue with the peak_pci driver.
> 
> I have no strong opinion about splitting up the patch.

I propose you split up into 2 patches.

Kurt
