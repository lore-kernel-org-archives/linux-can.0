From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: detect auto baud rate on can bus in linux driver.
Date: Thu, 1 May 2014 20:49:57 +0200
Message-ID: <20140501184957.GA25736@vandijck-laurijssen.be>
References: <53590FB6.6090707@tataelxsi.co.in>
 <20140427094418.GB28319@griso.site>
 <20140427180135.GB21176@vandijck-laurijssen.be>
 <1398760380297.91253@tataelxsi.co.in>
 <20140429195841.GB9737@pengutronix.de>
 <5360E8A6.8040204@tataelxsi.co.in>
 <20140430144124.GC28036@vandijck-laurijssen.be>
 <53612640.90106@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:54683 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751780AbaEASuE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 1 May 2014 14:50:04 -0400
Content-Disposition: inline
In-Reply-To: <53612640.90106@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, John Whitmore <arigead@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hey Oliver,

On Wed, Apr 30, 2014 at 06:35:12PM +0200, Oliver Hartkopp wrote:
> On 30.04.2014 16:41, Kurt Van Dijck wrote:
> > Hey,
> > 
> > On Wed, Apr 30, 2014 at 05:42:22PM +0530, Ratheendran wrote:
[...]
> So 
> 
> 	candump -T 1000 -n 4 can0 | wc -l
> 
> would produce values from 1 to 4 when there was some traffic within one
> second of reception or zero when not traffic was detected.
> 
> if [ `candump -T 1000 -n 4 can0 | wc -l` -ne 0 ]; then
> 
> 	echo "traffic";
> else
> 	echo "nothing";
> fi

4 means here then "return success after 4 frames, and don't keep waiting 1sec"?
This 'if' line is the right one to use!

Thanks,
Kurt
