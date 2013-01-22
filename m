From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: exclusive access to can interface
Date: Tue, 22 Jan 2013 10:41:03 +0100
Message-ID: <3261122.aWhS3clJQh@ws-stein>
References: <2412937.XVpYjfC7zz@ws-stein> <50EB10F4.6070308@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:53685 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752373Ab3AVJlG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Jan 2013 04:41:06 -0500
In-Reply-To: <50EB10F4.6070308@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hello again,

On Monday 07 January 2013 19:16:20, Marc Kleine-Budde wrote:
> On 01/07/2013 05:52 PM, Alexander Stein wrote:
> > is there a way to get exclusive (write) access to a CAN interface, so
> > that only one bound socket can write CAN frames on the bus?
> 
> No, what's the use case?

I have now a more detailed view about the customers request and background: The problem runs some (time consuming) tests using CAN and they want to prohibit CAN write access meanwhile in order to prevent e.g. some (mis-)configuration of CAN devices or firmware updates. In such a case the test might shutdown and needs to be restarted. During the test nobody alse should be allowed to write to the CAN bus. I think this is justified.
It seems this is unrelated to CANopen or user application started twice, like I've expected and written before.

Best regards,
Alexander

