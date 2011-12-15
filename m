From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: using can-j1939
Date: Thu, 15 Dec 2011 16:50:24 +0100
Message-ID: <20111215155024.GC10848@e-circ.dyndns.org>
References: <20111214204237.GC306@e-circ.dyndns.org>
 <loom.20111215T085023-710@post.gmane.org>
 <20111215092018.GB321@e-circ.dyndns.org>
 <loom.20111215T114301-18@post.gmane.org>
 <20111215120434.GD321@e-circ.dyndns.org>
 <loom.20111215T142642-767@post.gmane.org>
 <20111215140012.GA10848@e-circ.dyndns.org>
 <loom.20111215T152334-981@post.gmane.org>
 <20111215150627.GB10848@e-circ.dyndns.org>
 <loom.20111215T161056-479@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:30351 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781Ab1LOPua (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 15 Dec 2011 10:50:30 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111215T161056-479@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Thu, Dec 15, 2011 at 03:16:05PM +0000, Wolfgang wrote:
> > So only 1 PGN is bridged? No other PGN's.
> 
> For the first steps I would be happy with 1 but finally and if it isn't 
> 'impossible' 3.
ok. a limited number :-)

Do you relay them (on the second bus) using the same source address, i.e.
to all 3 PGN's use the same source address when sent out?
The source addresses of the 3 received PGN's (on the first bus) do not matter.

In fact, a limited number here is fine too.
The thing is, my can-j1939 stack is (BSD sockets alike) assigned a limited
number of J1939 source addresses. Only those source addresses are allowed
in outgoing packets (a bit like IP networks, and probably others)

You can do unmodified relaying even from the command line
by piping 2 instances of jsr, like

$ ip addr add j1939 0x80 dev can1
$ jsr can0:80,feda | jsr can1:80,feda

This should do some basics already.

Kurt
