From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: Flooding AT91_CAN peripheral with messages causes it to stop receiving any more messages
Date: Mon, 02 May 2016 08:23:58 +0200
Message-ID: <1834894.mYn6oCiL2x@ws-stein>
References: <CAOLz05quWjxFaxdPcLvybc4YdTmE+qUGhbKUCjji6DGNAUwZ3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:48582 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752981AbcEBGaD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 May 2016 02:30:03 -0400
In-Reply-To: <CAOLz05quWjxFaxdPcLvybc4YdTmE+qUGhbKUCjji6DGNAUwZ3g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Amr Bekhit <amrbekhit@gmail.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org

On Tuesday 05 April 2016 14:10:48, Amr Bekhit wrote:
> I working on a board based on the AT91SAM9X25 SoC and I'm using
> integrated CAN peripheral. I seem to have run into an issue whereby
> sending lots of messages very rapidly in quick succession causes the
> CAN peripheral to then stop receiving any messages at all. The only
> way to bring it back to a functional state is to bring the network
> interface down and then back up again.
> [...]
> I then start sending CAN messages to the unit using a PCAN-USB adapter
> that is plugged into a test Linux PC. After bringing up the CAN
> interface on the test PC, messages can be continuously sent using the
> following bash script:
> [...]
> I then leave the system running for some time (1.5 hours typically,
> may vary), periodically running ifconfig can0 to check to see if new
> packets are being received. After a while, the can interface will stop
> receiving new packets, even though the test PC is still transmitting
> them. Stopping and restarting the CAN transmissions on the test PC
> does not solve the problem. The interface does not appear to be in the
> bus off state, as shown by running the following:

That sounds a bit like my getting stuck problem in http://linux-can.vger.kernel.narkive.com/bBQqK84G/resend-patch-net-can-at91-can-c-decrease-likelyhood-of-rx-overruns#post2

The patch post1 at least keeps the driver working. Although I don't know what 
has changed in at91_can meanwhile.

Best regards,
Alexander

