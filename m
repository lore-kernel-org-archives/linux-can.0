From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Bug in ac_msg_is_request_for_ac
Date: Wed, 11 Jan 2012 11:15:13 +0100
Message-ID: <20120111101513.GB314@e-circ.dyndns.org>
References: <1326198848.2189.9.camel@osblap120.dev.osb-ag.de>
 <20120110150158.GB2524@e-circ.dyndns.org>
 <CAJsOQGPhXvDvnoY3MP6zEVOnYD0_BHjhg7UhAb=vSkVrVGNcow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:37630 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745Ab2AKKPP (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 11 Jan 2012 05:15:15 -0500
Content-Disposition: inline
In-Reply-To: <CAJsOQGPhXvDvnoY3MP6zEVOnYD0_BHjhg7UhAb=vSkVrVGNcow@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Felix Obenhuber <felix@obenhuber.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Wed, Jan 11, 2012 at 11:01:50AM +0100, Felix Obenhuber wrote:
> Hi,
> 
> On Tue, Jan 10, 2012 at 4:01 PM, Kurt Van Dijck <kurt.van.dijck@eia.be> wrote:
> > By a second look, this function is only used to decide if a request
> > from source address 0xfe may be sent out.
> > I'm sure my intent is conform to the specification, but I'm
> > not sure anymore taht I should enforce such policy inside the kernel.
> 
> Yep, AFAIK this matches the J1939 and ISOBUS specification.
> 
> > I may as well delete the function completely ...
> 
> Maybe also a good solution, cause all the SA stuff is very simple and
> obvious. Everyone developing with SocketCAN J1939 should know about.

I just walked several scenarios, and the function must stay (patched),
since it is only used in case of dynamic addressing, and in that case,
one should not always care an address was claimed or not.

This should help userspace not to track address claims in _every_ program,
which was one of the major intents to put it into kernel.

I'll push a commit shortly.

Thanks for the testing.
Regards,
Kurt
