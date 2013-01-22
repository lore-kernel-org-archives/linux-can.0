From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: exclusive access to can interface
Date: Tue, 22 Jan 2013 14:36:24 +0100
Message-ID: <1432460.mUnU8pZCtu@ws-stein>
References: <2412937.XVpYjfC7zz@ws-stein> <3261122.aWhS3clJQh@ws-stein> <A2134122-6A5B-47CA-AB32-827CECA201B0@eia.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:48965 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752078Ab3AVNg0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Jan 2013 08:36:26 -0500
In-Reply-To: <A2134122-6A5B-47CA-AB32-827CECA201B0@eia.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Tuesday 22 January 2013 13:53:22, Kurt Van Dijck wrote:
> On 22 Jan 2013, at 10:41, Alexander Stein <alexander.stein@systec-electronic.com> wrote:
> 
> > Hello again,
> > 
> > On Monday 07 January 2013 19:16:20, Marc Kleine-Budde wrote:
> >> On 01/07/2013 05:52 PM, Alexander Stein wrote:
> >>> is there a way to get exclusive (write) access to a CAN interface, so
> >>> that only one bound socket can write CAN frames on the bus?
> >> 
> >> No, what's the use case?
> > 
> > I have now a more detailed view about the customers request and background: The problem runs some (time consuming) tests using CAN and they want to prohibit CAN write access meanwhile in order to prevent e.g. some (mis-)configuration of CAN devices or firmware updates. In such a case the test might shutdown and needs to be
> exclusive access could be used to prevent possible race conditions, not to solve configuration of the local software.
>  
> > restarted. During the test nobody alse should be allowed to write to the CAN bus. I think this is justified.
> "Nobody should write to the CAN bus" != "Nobody should be allowed to write to the CAN bus"
> 
> The exclusive access is only enforce on the local system. Other participants on the CAN bus
> still are able to write to the CAN bus.
> Your problem won't be solved.

As this specific CAN interface is the only access to this CAN network it is enough. It is obvious that you can't lock this bus completly, the same is for file locking on networking file systems, they either don't work at all or just locally.

Best regards,
Alexander

