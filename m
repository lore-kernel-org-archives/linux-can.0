From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH] can: ti_hecc: fix rx wrong sequence issue
Date: Mon, 5 Nov 2012 13:47:28 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA647DC@DBDE01.ent.ti.com>
References: <1349678436-747-1-git-send-email-anilkumar@ti.com>
 <5097A45F.3000606@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42342 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217Ab2KENrn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 5 Nov 2012 08:47:43 -0500
In-Reply-To: <5097A45F.3000606@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

On Mon, Nov 05, 2012 at 17:04:55, Marc Kleine-Budde wrote:
> Hello,

Hi Marc,

Thanks for looking into this issue, I had spent some considerable
time for debugging this issue, I have seen better sequence with
below changes at 500KBPS but issue still there. Because of some
other higher priority task I left there.

Some of my observations in the driver:-
1. One is buffer mailbox (12th mailbox we are missing)

@@ -627,18 +617,34 @@ static int ti_hecc_rx_poll(struct napi_struct *napi, int quota)
 			if (ti_hecc_rx_pkt(priv, priv->rx_next) < 0)
 				return num_pkts;
 			++num_pkts;
-		} else if (priv->rx_next > HECC_RX_BUFFER_MBOX) {
+		} else if (priv->rx_next >= HECC_RX_BUFFER_MBOX) {
 			break; /* pkt not received yet */
 		}
 		--priv->rx_next;
-		if (priv->rx_next == HECC_RX_BUFFER_MBOX) {
-			/* enable high bank mailboxes */
-			spin_lock_irqsave(&priv->mbx_lock, flags);
+		if (priv->rx_next == (HECC_RX_BUFFER_MBOX - 1)) {

2. Lower mail box configuration is not happening properly. I have
changed this.
3. Removed spinlocks (Just for testing)

> 
> On 10/08/2012 08:40 AM, AnilKumar Ch wrote:
> > Fix "received wrong sequence count. expected: x, got: y" errors
> > reported by cansequence in a stress test (--verbose).
> > 
> > While processing the receive packets in mailboxes, upper mailboxes
> > need to enable while processing 12th (RX_BUFFER mailbox) mailbox.
> > This requires a status check to identify whether the receiving of
> > packets in progress or not. If the mailboxes are enabled before the
> > receive packet status is cleared then there is a possibility of
> > receiving out of order packets.
> > 
> > With this patch mailboxes are enabled once the receive status is
> > cleared.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> 
> AnilKumar Ch, can you add some TI people with access to the vhdl CAN
> core design to Cc?

I am contacting the person internally, I will add immediately once I
got the right person. 

> 
> I'm debugging this issue for a week, fixed several other problems with
> the driver and now and it seems there is a race condition in the hardware.
> 
> The algorithm in the driver relies on the ability to re-enable a bunch
> of mailboxes with a single write command. In the ti_hecc hardware the
> driver uses the CANME (mailbox enable) register to do so. Under certain
> circumstances I've noticed that the CAN core receives the next message
> into an undefined mailbox. According to the data sheet CAN messages are
> always received into the highest free mailbox (with a matching filter).
> But after enabling the mailboxes the next CAN frame doesn't go into the
> highest mailbox.
> 
> This is a log from my test application. The ti_hecc receives 1 byte long
> frames at 500 kbit/s. In the first data byte a number is increased with
> every CAN frame (the "d=" column). The enabled mailboxes are in the "me"
> column and the pending messages in "rmp".
> 
> > [   57.390747] ti_hecc ti_hecc: can0: i=39502 m=14 n=14 rmp=00004000 me=00007ff0 d= 78
> > [   57.390777] ti_hecc ti_hecc: can0: i=39503 m=13 n=13 rmp=00002000 me=00003ff0 d= 79
> > [   57.390777] ti_hecc ti_hecc: can0: i=39504 m=12 n=12 rmp=00001000 me=00001ff0 d= 80
> > [   57.390808] ti_hecc ti_hecc: can0: i=39505 m=11 n=11 rmp=00000800 me=00000ff0 d= 81
> > [   57.390838] ti_hecc ti_hecc: can0: i=39506 m=10 n=10 rmp=00000400 me=000007f0 d= 82
> > [   57.390838] ti_hecc ti_hecc: can0: i=39507 m= 9 n= 9 rmp=00000200 me=000003f0 d= 83
> > [   57.390869] ti_hecc ti_hecc: can0: i=39508 m= 8 n= 8 rmp=00000100 me=000001f0 d= 84
> 
> Here the driver enables the high priority mailboxes (0xfffff000) with a
> single write. Actually the driver writes 0xfffff0f0, as there a still
> four free low priority mailboxes.
> 
> > [   57.390899] ti_hecc ti_hecc: can0: i=39509 m= 0 n= 7 rmp=00010000 me=fffff0f0 d=  0
>                                                                  ^
> The next CAN frame should be received, either into 0x00000800 (if the
> reception happens before the driver enables the high prio mailboxes) or
> into 0x80000000 (if the reception takes place after the driver has
> written the canme register).
> 
> > [   57.390930] ti_hecc ti_hecc: can0: i=39510 m= 0 n= 7 rmp=00010000 me=fffff0f0 d=  0
> > [   57.390930] ti_hecc ti_hecc: can0: i=39511 m= 0 n= 7 rmp=00010000 me=fffff0f0 d=  0
> > [   57.390960] ti_hecc ti_hecc: can0: i=39512 m= 0 n= 7 rmp=00010000 me=fffff0f0 d=  0
> > [   57.390991] ti_hecc ti_hecc: can0: i=39513 m= 0 n= 7 rmp=00010000 me=fffff0f0 d=  0
> > [   57.391021] ti_hecc ti_hecc: can0: i=39514 m= 0 n= 7 rmp=00010000 me=fffff0f0 d=  0
> > [   57.391021] ti_hecc ti_hecc: can0: i=39515 m= 0 n= 7 rmp=00010000 me=fffff0f0 d=  0
> > [   57.391052] ti_hecc ti_hecc: can0: i=39516 m= 0 n= 7 rmp=00010000 me=fffff0f0 d=  0
> > [   57.391082] ti_hecc ti_hecc: can0: i=39517 m=31 n=31 rmp=80010000 me=fffff0f0 d= 86
>                                                               ^
> We see the next frame goes into 0x80000000 as expected. (There are so
> many d=0 lines, because the driver is confused, as the next frame is not
> expected in the 0x00010000 mailbox.)
> 
> There isn't any tx going on at the moment, the rx-path is the only
> modifier of the canme register.
> 
> I thought maybe there is a problem in the hardware with the canme
> register, so I've reworked the algorithm not to change the canme
> register at all. canme stays 0xfffffff0 all the time (all rx mailboxes
> active), but received frames are not acknowledged (I don't write 1s into
> canrmp after message reception). The pending rx interrupts are masked
> with canmim. To "enable" the mailboxes again, the driver clears bits in
> the canrmp register with a single write and then unmasks the interrupt
> again. This however results in _the_same_ buggy behaviour.
> 
> Then I had a closer look at AnilKumar Ch's patch, the canme register is
> not changed if a the CAN core currently receives a CAN frame. I added
> AnilKumar Ch's busy loop before modifying the canme register, and it
> works now. So I conclude that the "pick next free mailbox" algorithm in
> the CAN core is racy. You are not allowed to do something that changes a
> mailbox's status from disabled/full to enabled/free when a CAN frame is
> received. As you cannot control CAN frame reception, this is a nice
> hardware race condition. Please add this to the manual and errata sheets.
> 
> I'll post a series which fixes the problems I've found soon.

I can test the series if your patches are ready.

Thanks
AnilKumar
