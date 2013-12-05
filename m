From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: GS_USB
Date: Thu, 05 Dec 2013 21:18:16 +0100
Message-ID: <52A0DF88.2040507@grandegger.com>
References: <1380889887.22484.2.camel@blackbox>	 <52507832.8000709@grandegger.com> <1381155720.21207.7.camel@blackbox>	 <5e3f6029b128db63c69664deed10c5d6@grandegger.com>	 <1381175546.21207.37.camel@blackbox> <525319E6.4020505@grandegger.com>	 <1383498724.4208.4.camel@blackbox> <527EC310.5010003@grandegger.com>	 <1384135835.3749.31.camel@blackbox>	 <3370f1eba56bbe04176f4d14808c1dc0@grandegger.com>	 <5280FAB2.3030600@hartkopp.net> <1384199350.3483.20.camel@blackbox>	 <528150F3.8090406@hartkopp.net> <1384511999.3561.8.camel@blackbox>	 <1385222752.3602.6.camel@blackbox> <1386191862.2061.1.camel@blackbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:50043 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab3LEUSU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Dec 2013 15:18:20 -0500
In-Reply-To: <1386191862.2061.1.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Max,

On 12/04/2013 10:17 PM, Max S. wrote:
> Hey,
> 
> Can someone give me a heads up on the GS_USB driver?
> 
> Whats the next step? Is someone looking at it?

I will have a final look tomorrow or over the week-end. The driver was
already in a good shape. Then it's up to Marc...

Anyway, next time please send the patch as standalone mail with the
subject "[PATCH vX] can: gs_usb: ..." incrementing X for each new
version. It's also common to briefly describe what has been changed
below the "---" line. A rather good example is here:

  http://marc.info/?l=linux-can&m=138377346111229&w=2

Then it's less probable that your latest patch will be realized.

Wolfgang.
