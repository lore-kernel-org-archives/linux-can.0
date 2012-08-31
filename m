From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Truncate DLC to 8 instead of dropping?
Date: Fri, 31 Aug 2012 14:50:21 +0200
Message-ID: <20120831125021.GB1191@vandijck-laurijssen.be>
References: <20120831115904.GB2624@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx01.eia.be ([195.130.156.18]:51819 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752703Ab2HaMuY (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 31 Aug 2012 08:50:24 -0400
Content-Disposition: inline
In-Reply-To: <20120831115904.GB2624@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-can@vger.kernel.org

On Fri, Aug 31, 2012 at 01:59:04PM +0200, Wolfram Sang wrote:
> Hi,
> 
> I just noticed today that commit c7cd606f60e7679c7f9eee7010f02a6f000209c1
> ("can: Fix data length code handling in rx path") says regarding
> overlong packets:
> 
> ===
> 
> The ISO 11898-1 Chapter 8.4.2.3 (DLC field) says that register values > 8
> should be reduced to 8 without any error reporting or frame drop.
> 
> ===
> 
> and this is why get_can_dlc() came into existance.
> 
> However, functions like can_dropped_invalid_skb() from dev.h or can_rcv() from
> af_can.c do check for a correct length, but drop the packet in the error case.
> Don't those need to be fixed?
> 
> Regards,
> 
>    Wolfram

Interesting point. My first idea is to acknowledge your thinking, BUT:
* ISO 11898-1 is about the wire format, whereas your issues address
  higher level interfaces. Higher level interfaces may IMHO use a stricter
  format that the wire format.
* I find it very likely that DLC is normalized in user space.
  This could prevent a lot of confusion in userspace apps.
  We could now argue on the best place to do normalization, but device drivers
  seem the best place.
* With CAN-FD in mind, the handling of DLC is stricter anyway. DLC > 8 is allowed,
  but is a real coding (probably), so we decided to communicate a 'len' field
  to userspace.

Does this address your concerns?

Kind regards,
Kurt
