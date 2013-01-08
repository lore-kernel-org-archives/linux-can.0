From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: exclusive access to can interface
Date: Tue, 08 Jan 2013 10:48:58 +0100
Message-ID: <1943558.lxo8ZHFGuj@ws-stein>
References: <2412937.XVpYjfC7zz@ws-stein> <2293513.Wi876mfY7y@ws-stein> <50EBE7A9.3050809@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:50234 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754532Ab3AHJtA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Jan 2013 04:49:00 -0500
In-Reply-To: <50EBE7A9.3050809@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hello,

On Tuesday 08 January 2013 10:32:25, Marc Kleine-Budde wrote:
> On 01/08/2013 10:23 AM, Alexander Stein wrote:
> > Hello Marc,
> > 
> > On Monday 07 January 2013 19:16:20, Marc Kleine-Budde wrote:
> >> On 01/07/2013 05:52 PM, Alexander Stein wrote:
> >>> is there a way to get exclusive (write) access to a CAN interface, so
> >>> that only one bound socket can write CAN frames on the bus?
> >>
> >> No, what's the use case?
> > 
> > This was a customers request in order to prevent multiple applications (or 
> > instances) to send CAN frames on a specific CAN interface at the same time 
> > with the very same CAN-IDs. Concurrent reads shall still be allowed!
> 
> Sending CAN frames is proper serialized by the networking subsystem :)
> If back to back CAN frames are a problem it seems the design of the
> application is fishy.

I don't think serializaton or back to back frames are the problem. Think of CANopen there would be the same Node-ID twice on the bus.

Alexander

