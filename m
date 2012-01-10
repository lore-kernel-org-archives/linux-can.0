From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: recv list
Date: Tue, 10 Jan 2012 09:51:05 +0100
Message-ID: <20120110085105.GB330@e-circ.dyndns.org>
References: <20120109132638.GI386@e-circ.dyndns.org>
 <loom.20120109T162926-984@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:6759 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752684Ab2AJIvI (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 10 Jan 2012 03:51:08 -0500
Content-Disposition: inline
In-Reply-To: <loom.20120109T162926-984@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Mon, Jan 09, 2012 at 04:35:08PM +0000, Wolfgang wrote:
> > I think what happens is that your engine ECU (0x00) does address claiming.

I take back this conclusion. I looked again, and came on this:
clear the src_addr.can_ifindex, since that's for sure wrong when bridging.

Sorry for the overhead ...
Kurt
