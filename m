From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v6] can: sja1000: fix =?UTF-8?Q?=7Bpre=2Cpost=7D=5Firq?=  =?UTF-8?Q?=28=29=20handling=20and=20IRQ=20handler=20return=20value?=
Date: Fri, 06 Dec 2013 10:56:38 +0100
Message-ID: <ac6a947c7ec842f67e9d23abd877b884@grandegger.com>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de>
 <loom.20131205T164221-222@post.gmane.org> <52A0BCD9.4090309@grandegger.com>
 <loom.20131205T202627-307@post.gmane.org> <52A0E185.1080402@grandegger.com>
 <loom.20131206T100036-664@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:50053 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757772Ab3LFJ4k (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 6 Dec 2013 04:56:40 -0500
In-Reply-To: <loom.20131206T100036-664@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Richard Andrysek <richard.andrysek@rg-mechatronics.com>
Cc: linux-can@vger.kernel.org

On Fri, 6 Dec 2013 09:27:27 +0000 (UTC), Richard Andrysek

<richard.andrysek@rg-mechatronics.com> wrote:

> Wolfgang Grandegger <wg <at> grandegger.com> writes:

> 

>> 

>> What do you mean? CAN belongs to the network world. What does the

>> following command report:

>> 

>>  # ip -d -s link show can0

> 

> I have now already modified driver, but before it shown the overrun &

> arbitration lost errors. Perfect command:)

>> 

>> > Then each event "arbitration lost" generates an IRQ.

>> 

>> From a CAN device?

> 

> Yes you can see it in a code of driver/net/can/sja1000/sja1000.c,

> function:

> 

> static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t

> status)

> { 

>    ...

>    if (isrc & IRQ_ALI) {

>       /* arbitration lost interrupt */

>       netdev_dbg(dev, "arbitration lost interrupt\n");

>       alc = priv->read_reg(priv, SJA1000_ALC);

>       priv->can.can_stats.arbitration_lost++;

>       stats->tx_errors++;

>       cf->can_id |= CAN_ERR_LOSTARB;

>       cf->data[0] = alc & 0x1f;

>    }

>    ...

> }

> 

> 

> I've just studied sja1000.c I do not know yet, if it is healthy.



This is normally due to hardware/electrical problems. It has nothing to do

with software. Well, is there *any* relation to the patch mentioned in the

subject? I mean, does the problem *not* show up without that patch.



> May be something in upper levels will be not anymore well handled. 

> I've changed a code in a function (see IRQ_ALI part):

> 

> static void set_normal_mode(struct net_device *dev)

> {

>   ...

>                if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)

>                     priv->write_reg(priv, SJA1000_IER, IRQ_ALL &

~IRQ_ALI);

>                else

>                     priv->write_reg(priv, SJA1000_IER,

>                                     IRQ_ALL & ~(IRQ_BEI | IRQ_ALI));

>   ...

> }

> 

> But I prefare to make some kind of "ioctl" support for that. There are

> applications, where it shall not happend. Concurrently I've played with

> taskset and priorities. 

> 

> $ ps -e -o pid,rtprio,comm | grep "irq/19"

>    56     89 irq/19-uhci_hcd

>  1877     88 irq/19-can0

>  1922     88 irq/19-can1

> 

> I do not still understand, what does it mean "irq/19-uhci_hcd". Which is

> also active, even I do not have any USB device. Mouse and keyboard are

> connected through PS2.



Seem that the interrupts are shared. "$ cat /pric/interrupts" provide

further

information.



Wolfgang.
