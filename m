From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: J1939 support: plans for integration?
Date: Wed, 28 Nov 2012 16:00:07 +0100
Message-ID: <20121128150007.GF40463@vandijck-laurijssen.be>
References: <50AE12C5.2070501@ilv.uni-kiel.de>
 <20121123055240.GA17495@vandijck-laurijssen.be>
 <50B34AC9.1010306@ilv.uni-kiel.de>
 <20121128134323.GE40463@vandijck-laurijssen.be>
 <50B615E5.9040903@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay002.isp.belgacom.be ([195.238.6.175]:33279 "EHLO
	mailrelay002.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755499Ab2K1PAK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 Nov 2012 10:00:10 -0500
Content-Disposition: inline
In-Reply-To: <50B615E5.9040903@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Christoph Appel <cappel@ilv.uni-kiel.de>, linux-can@vger.kernel.org

On Wed, Nov 28, 2012 at 02:47:17PM +0100, Marc Kleine-Budde wrote:
> On 11/28/2012 02:43 PM, Kurt Van Dijck wrote:
> > On Mon, Nov 26, 2012 at 11:56:09AM +0100, Christoph Appel wrote:
> >> Hello Kurt,
> >>
> >> Am 23.11.2012 06:52, schrieb Kurt Van Dijck:
> >>> Hi,
> >>>
> > [...]
> >>> How do you use the current J1939 stack?
> >> I am in the early process of evaluating possibilities
> >> deploying J1939 in farm machinery (primary
> >> data logging purposes with a couple of bus requests).
> > 
> > FYI, we (EIA Electronics) have certified a Virtual Terminal
> > using this j1939 stack. The certification process went
> > very smooth for the networking tests.
> 
> like telnet?
telnet on j1939?

No, I meant the test that are preformed during this isobus certification
on the isobus (J1939) networking level, like dynamic addressing behaviour,
Transport protocol, ...
A beautifull set of nasty corner cases is verified then.
I was a bit curious to the results since I had spent some time on that code.

Being certified at least means that the j1939 stack, together with the userspace programs,
is functionally ready for production.

Isobus (on CAN networking equal to j1939) has become the 'de facto' standard for agriculture
machinery...

Kurt
