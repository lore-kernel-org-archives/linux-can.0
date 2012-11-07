From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH] can: ti_hecc: WIP: fix out-of-order problem - CANMIN
 Version
Date: Wed, 7 Nov 2012 13:56:55 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA665AB@DBDE01.ent.ti.com>
References: <a> <1352145232-16403-1-git-send-email-mkl@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA664B7@DBDE01.ent.ti.com>
 <509A53A2.8020902@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59632 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab2KGN5D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Nov 2012 08:57:03 -0500
In-Reply-To: <509A53A2.8020902@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>

On Wed, Nov 07, 2012 at 17:57:14, Marc Kleine-Budde wrote:
> On 11/07/2012 01:10 PM, AnilKumar, Chimata wrote:
> > On Tue, Nov 06, 2012 at 01:23:52, Marc Kleine-Budde wrote:
> >> This is Work-In-Process patch which fixes several problem:
> >> - ti_hecc_xmit: modify CANMIM under spin_lock
> >> - ti_hecc_rx_pkt: don't re-enable current mailbox,
> >>   next CAN frame might do into same mailbox
> >> - ti_hecc_interrupt: modify CANMIM under spin_lock
> >> - ti_hecc_rx_poll: rework polling loop, wrap-around-handling and
> >>   reactivation of mailboxes.
> >>
> >> Before acknowledging the received CAN frames in CANRMP wait for CAN core to
> >> finish current rx, otherwise next CAN frame goes into undefined mailbox. Idea
> >> lifted shamelessly from AnilKumar Ch's patch.
> >>
> >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >> ---
> >> Hello AnilKumar,
> >>
> >> here's the CANMIN version. With this patch the rx-path doesn't change the CANME
> >> register, the wait-for-end-of-reception is done before writing to the CANRMP
> >> register. So there isn't any spin_lock after the busy wait loop.
> >>
> >> please test,
> > 
> > +Anant
> > 
> > Hi Marc,
> > 
> > Note: I am not using the standard utilities, I have the utilities
> > from http://git.pengutronix.de/?p=tools/canutils.git
> 
> I use them as well.
> 
> > 1. I am seeing the issue with this patch as well.
> > 
> > @500KBPS
> > <0x002> [1] 13
> > <0x002> [1] 16
> > <0x002> [1] 18
> > <0x002> [1] 1d
> > <0x002> [1] 20
> > <0x002> [1] 23
> > <0x002> [1] 26
> > <0x002> [1] 29
> > 
> > @1MBPS
> > <0x002> [1] 22
> > <0x002> [1] 37
> > <0x002> [1] 44
> > <0x002> [1] 54
> > <0x002> [1] 6a
> > <0x002> [1] 80
> > <0x002> [1] 94
> > <0x002> [1] a6
> > 
> > Steps I have followed:-
> >     One side AM335x sending packets through D_CAN ip
> >       $ cansequence can0 -p
> >     AM3517 receiving the packets through HECC ip
> >       $ candump can0
> > 
> > 2. But if I use this command in the reception side @500KBPS I am not
> > seeing any out of seq message "received wrong sequence count....".
> > This might be due to load on the system is less because no
> > UART/console prints
> > 
> > $ cansequence -r -v | grep wrong 
> 
> I'm using $(cansequence -rvv | grep wrong) and it works for me even
> under heavy ping -f load  at 500Kbit/s. I think without the grep the
> receiving process spends too much time printing and the receive buffer
> in the socket will overflow.
> 
> > 3. @1MBPS I have seen the wrong sequence message.
> 
> Can you give the the exact error messages. There is a difference between
> "lost" messages and out-of-order messages. Lost messages simply print a
> single wrong sequence number detected message. An out-of-order reception
> prints a characteristic 3 line error message.

These are the message I am seeing at 1MBPS

[root@arago /]# cansequence -r -v | grep wron
received wrong sequence count. expected: 191, got: 192
received wrong sequence count. expected: 193, got: 194
received wrong sequence count. expected: 195, got: 196
received wrong sequence count. expected: 197, got: 198
received wrong sequence count. expected: 200, got: 201
received wrong sequence count. expected: 202, got: 203
received wrong sequence count. expected: 204, got: 209
received wrong sequence count. expected: 210, got: 211
received wrong sequence count. expected: 212, got: 215
received wrong sequence count. expected: 217, got: 219
received wrong sequence count. expected: 221, got: 223
received wrong sequence count. expected: 225, got: 227
received wrong sequence count. expected: 229, got: 230
received wrong sequence count. expected: 232, got: 233
received wrong sequence count. expected: 234, got: 235
received wrong sequence count. expected: 236, got: 237
received wrong sequence count. expected: 238, got: 239
received wrong sequence count. expected: 240, got: 241
received wrong sequence count. expected: 242, got: 245
received wrong sequence count. expected: 251, got: 254
received wrong sequence count. expected: 0, got: 2
received wrong sequence count. expected: 5, got: 6
received wrong sequence count. expected: 8, got: 11


> 
> BTW: We should check if a lost message on the CAN core level leads to a
> receive buffer overflow CAN error frame.
> 
> My hardware is not working properly at 1Mbit/s. Can you check if the
> patch I sent first makes a difference?

I will check this tomorrow.

> 
> > With the standard utilities can we test the can-sequence? I have not
> > used those.
> 
> As Wolfgang pointed out, you might use canfdtest [1]. But I haven't used
> it, yet. Maybe I should as cansequence doesn't trigger the problem at
> 500 kbit/s any more.

Sure I will use that

Thanks
AnilKumar

> 
> Marc
> 
> [1] https://gitorious.org/linux-can/can-utils/blobs/master/canfdtest.c
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
> 

