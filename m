From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: using can-j1939
Date: Sat, 17 Dec 2011 20:20:38 +0100
Message-ID: <20111217192038.GA309@e-circ.dyndns.org>
References: <20111215092018.GB321@e-circ.dyndns.org>
 <loom.20111215T114301-18@post.gmane.org>
 <20111215120434.GD321@e-circ.dyndns.org>
 <loom.20111215T142642-767@post.gmane.org>
 <20111215140012.GA10848@e-circ.dyndns.org>
 <loom.20111215T152334-981@post.gmane.org>
 <20111216083708.GA323@e-circ.dyndns.org>
 <loom.20111216T095547-967@post.gmane.org>
 <20111216093308.GB669@e-circ.dyndns.org>
 <loom.20111216T150333-707@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:64586 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752404Ab1LQTUl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 17 Dec 2011 14:20:41 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111216T150333-707@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Fri, Dec 16, 2011 at 02:29:45PM +0000, Wolfgang wrote:
> > > The packets are destination specific.
> > > But I was wrong the, it should read and
> > > write from both bus' - sorry, but only 2 specific address'!
> > Even that is no problem...
> 
> OK, this sounds great. I am just browsing through the documentation and wondering
> if it is possible to activate j1939 per default,
Of course this is possible, but unwanted.
This choice is comparable to "not setting 250Kb per default".
Read more below.

> that it would be possible to use
> the target as stand alone.
You should initialize the CAN bus(ses) on powerup:
* set baudrate
* set j1939 on
* set iface up.

Typically this is done in some init scripts.

Kind regards,
Kurt
