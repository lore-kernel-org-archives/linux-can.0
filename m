From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: detect auto baud rate on can bus in linux driver.
Date: Wed, 30 Apr 2014 16:41:24 +0200
Message-ID: <20140430144124.GC28036@vandijck-laurijssen.be>
References: <53590FB6.6090707@tataelxsi.co.in>
 <20140427094418.GB28319@griso.site>
 <20140427180135.GB21176@vandijck-laurijssen.be>
 <1398760380297.91253@tataelxsi.co.in>
 <20140429195841.GB9737@pengutronix.de>
 <5360E8A6.8040204@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:7665 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933877AbaD3Olr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 Apr 2014 10:41:47 -0400
Content-Disposition: inline
In-Reply-To: <5360E8A6.8040204@tataelxsi.co.in>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, John Whitmore <arigead@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hey,

On Wed, Apr 30, 2014 at 05:42:22PM +0530, Ratheendran wrote:
> Thanks again, I Appreciate your support, this has helped my understanding
> ,build confidence on socketcan.
[...]
> Hi kurt,
> 
> I am not able to set the timeout scenario for candump command, do i need to
> send a killall signal to candump after a wait period.
> 

I believe this approach is a good one, but the timeout thing is the tricky part.
I'll take a look next few days.

Kurt

> 
> 
> With regards,
> Ratheendran
> 
> 
> 
