From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Is there any way of getting the CAN interfaces list, from any
 C program?
Date: Thu, 25 Apr 2013 23:08:51 +0200
Message-ID: <20130425210851.GA2793@vandijck-laurijssen.be>
References: <5169B395.2070703@hartkopp.net>
 <516D2ABB.4000300@pengutronix.de>
 <5177A090.6010904@peak-system.com>
 <20130424144929.GA2077@vandijck-laurijssen.be>
 <5178D00C.70507@grandegger.com>
 <20130425072429.GA448@vandijck-laurijssen.be>
 <5178DE98.7040408@grandegger.com>
 <20130425091421.GD448@vandijck-laurijssen.be>
 <5178F61E.9040506@pengutronix.de>
 <20130425094235.GF448@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay001.isp.belgacom.be ([195.238.6.51]:25321 "EHLO
	mailrelay001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756707Ab3DYVI4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 25 Apr 2013 17:08:56 -0400
Content-Disposition: inline
In-Reply-To: <20130425094235.GF448@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Thu, Apr 25, 2013 at 11:42:35AM +0200, Kurt Van Dijck wrote:
> On Thu, Apr 25, 2013 at 11:23:42AM +0200, Marc Kleine-Budde wrote:
> > On 04/25/2013 11:14 AM, Kurt Van Dijck wrote:
> > > I was just thinking that it has not that much to do with CAN altogether,
> > > and may deserve a seperate git tree.
> > > 
> > > I'm just rewriting the code a bit to work without callback, and be more like
> > > if_nameindex().
> > 
> > Would be cool if the functions follows the same semantics as
> > if_nameindex(), i.e. it could be named canif_nameindex() and just return
> > CAN interfaces, not all.
> and such function belongs to libsocketcan, indeed. sounds like a plan.

I realized I don't want to put much effort in making the code
more dedicated to one task and struggle with the struct definition
that if_nameindex uses (no status info).
So, I sanitized my version a bit, and
I just released libenumif on git://github.com/kurt-vd/enumif.git

This one allows to find:
* all can interfaces
* all active can interfaces.
* ...

Since it's LGPL'd, one can use it as is,
or use the code to build a canif_nameindex().

Kind regards,

-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
