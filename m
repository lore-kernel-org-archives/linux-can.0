From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Tue, 08 Jan 2013 11:09 +0100
Message-ID: <1838723.N2loBrR0E2@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:59751 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755138Ab3AHKJH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Jan 2013 05:09:07 -0500
Received: from comm.systec-electronic.de (95-91-81-39-dynip.superkabel.de [95.91.81.39])
	by webbox1416.server-home.net (Postfix) with ESMTPA id 261D427A606
	for <linux-can@vger.kernel.org>; Tue,  8 Jan 2013 11:05:27 +0100 (CET)
Received: from ws-stein.localnet (unknown [192.168.10.63])
	by comm.systec-electronic.de (Postfix) with ESMTP id CAFEE97C275
	for <linux-can@vger.kernel.org>; Tue,  8 Jan 2013 11:09:05 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Sorry for "new" thread, I don't have the old messages for reply

Jason White wrote:
> Kurt Van Dijck <kurt.van.dijck <at> eia.be> writes:
> > > Officially the TX-timeout has been removed as the controller just sends
> > > out
> > > the CAN frames, when it comes back to life ...
> > > 
> > > The question is, if the controller gets into the BUS_OFF state and if
> > > the
> > > restart-ms option (see ip tool) would help here.
> > 
> > FYI:
> > A CAN chip that sits alone on a proper bus, trying to transmit a frame,
> > will never go into BUS_OFF. It can only go in BUS_OFF when a bad network
> > is encountered, i.e. the chip does not see it's TX activity on its RX.
> > 
> > I think this scenario (chip alone, going in BUS_OFF) is no different
> > than regular BUS_OFF, and should be treated likewise.
> 
> This sounds like something I would be interested in.  Just a couple of
> questions.  What do you mean TX-timeout has been removed?  Also does
> it work in error passive state (scenario where the ECU is alone on
> the bus - no ack from another ECU).  Does it just reset the CAN
> hardware or does the queues get flushed as well?

Is there any progress on this topic? I would be particilar interested in clearing the socket queue, especially in case a BUS-OFF happens or when no device is on the bus (no ACK).

Best regards,
Alexander

