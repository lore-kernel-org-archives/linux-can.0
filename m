From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH RFC] can: add Virtual CAN Tunnel driver (vxcan)
Date: Tue, 25 Apr 2017 10:14:17 +0200
Message-ID: <2991941.MzkBZeoEfP@ws-stein>
References: <20170424201238.3587-1-socketcan@hartkopp.net> <1817567.PFpAbEA6ZR@ws-stein> <73a30dda-c0c6-a1f8-62d0-2cf4a193a7cc@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:43621 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1428466AbdDYIOX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Apr 2017 04:14:23 -0400
In-Reply-To: <73a30dda-c0c6-a1f8-62d0-2cf4a193a7cc@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

On Tuesday 25 April 2017 08:28:11, Oliver Hartkopp wrote:
> On 04/25/2017 07:35 AM, Alexander Stein wrote:
> > On Monday 24 April 2017 22:12:37, Oliver Hartkopp wrote:
> >> +
> >> +	netif_rx_ni(skb);
> >> 
> >      ^^^^^^^^^^
> > 
> > Wouldn't this result in the known out-of-order problem on SMP systems?
> 
> I don't think so.
> We're not dealing with irqs here that could reach different CPUs.
> This is all in softirq/userspace context.
> It's the same thing we have with the virtual CAN vcan.

That would be great. I don't know the complete code path but is it possible 
that this xmit function is executed on different CPUs at the same time? e.g. 
multiple sockets/threads writing a CAN frame.

Best regards,
Alexander

