From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Full Buffers and the Passive bus
Date: Fri, 31 Aug 2012 19:37:42 +0200
Message-ID: <20120831173742.GA414@vandijck-laurijssen.be>
References: <CACJ51z3wGmSnZ3U-qe_QLSPnNuRb54k5=5zuQ+DBQ0aFohcvVw@mail.gmail.com>
 <5040EAFE.9000500@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:12597 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754763Ab2HaRhr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Aug 2012 13:37:47 -0400
Content-Disposition: inline
In-Reply-To: <5040EAFE.9000500@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Andrew Bell <andrew.bell.ia@gmail.com>, linux-can@vger.kernel.org

On Fri, Aug 31, 2012 at 06:49:02PM +0200, Oliver Hartkopp wrote:
> On 31.08.2012 18:36, Andrew Bell wrote:
> 
> > Is there some way within socket CAN to detect the state when no nodes
> > are on the BUS?  I do get CAN_ERR_TX_TIMEOUT error frames after some
> > time, but I'm writing to the BUS faster than frames drain from the
> > buffers, so eventually buffers fill up and writes start failing.  In
> > this case, write does return ENOBUFS.  But I'd like to be able to
> > differentiate between the case where buffers are full because of some
> > transient condition (I'm writing too fast for the BUS) and the
> > condition when nobody is home to receive anything at all.
> > 
> > Suggestions appreciated.
> 
> 
> Hello Andrew,
> 
> this first idea was to check, if the successful transmissions increase the tx
> counter in the netdevice statistics. When there's no increasing value no
> frames have been sent on the wire.
> 
> But maybe there's another suggestion out there ...

Successfull transmissions generate incoming messages if CAN_RAW_RECV_OWN_MSGS
is set ...

The use case I have in mind (and successfully implemented) is to catch
a bootloader on the bus in its bootloader state. I guess we all know this
use case.

In case no frames get out since the PC is alone, I see no loopback'd frames
of myself, so I need not repeating my 'catch frame' again.
If I receive my loopback'd 'catch frame', I know I must repeat it within
a specified time interval.

Kind regards,

-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
