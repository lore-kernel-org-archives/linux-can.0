From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Usb to can driver
Date: Fri, 26 Apr 2013 10:55:57 +0200
Message-ID: <20130426085557.GB432@vandijck-laurijssen.be>
References: <1366737302.3325.36.camel@blackbox>
 <51770161.2030005@pengutronix.de>
 <1366818490.5965.35.camel@blackbox>
 <51780336.5060800@pengutronix.de>
 <51781907.3030306@hartkopp.net>
 <51784D96.8000309@pengutronix.de>
 <1366932904.3307.23.camel@blackbox>
 <517A0FE6.8010308@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay012.isp.belgacom.be ([195.238.6.179]:37215 "EHLO
	mailrelay012.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758706Ab3DZI4D (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 26 Apr 2013 04:56:03 -0400
Content-Disposition: inline
In-Reply-To: <517A0FE6.8010308@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "Max S." <max@schneidersoft.net>, linux-can <linux-can@vger.kernel.org>

On Fri, Apr 26, 2013 at 07:25:58AM +0200, Oliver Hartkopp wrote:
> On 26.04.2013 01:35, Max S. wrote:
> 
> > On Wed, 2013-04-24 at 23:24 +0200, Marc Kleine-Budde wrote:
> >> On 04/24/2013 07:40 PM, Oliver Hartkopp wrote:
> >>>>> assumptions that are made:
> >>>>> * The sizes of the struct can_frame members are id:u32 dlc:u8 data:u64 .
> >>>>> * It is also assumed that existing defines like CAN_EFF_FLAG in can.h
> >>>>> and can/error.h don't change, as they are used by the device to
> >>>>> construct the can_id field.
> 
[...]
> IMHO using the struct can(fd)_frame can considered to be stable.
> The 'stable API nonsense' mainly focuses kernel internal function definitions
> and structures that may change in names and variables - or be removed at all.
> 
> Struct can(fd)_frame is a CAN specific data structure. And CAN is an
> ISO standard that even Linux hackers are not able to change :-)

modifying struct can(fd)_frame serves not purpose.
If you drop something, it's insufficient to deal with the ISO standards.
If you add something, it's add overhead.
If you modify the order of the members, you'll still be very close to the standard,
but what's the use?

So I agree with Oliver that these structs are very likely to stay stable.

Kurt

-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
