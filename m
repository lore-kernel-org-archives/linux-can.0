From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: can: flexcan: problems with bus error reporting om i.MX53
Date: Fri, 25 Jul 2014 21:04:25 +0200
Message-ID: <20140725190425.GC24839@linutronix.de>
References: <53D29F02.8010708@optimeas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59271 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932659AbaGYTE2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 15:04:28 -0400
Content-Disposition: inline
In-Reply-To: <53D29F02.8010708@optimeas.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Matthias Klein <matthias.klein@optimeas.de>
Cc: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, support@karo-electronics.de

* Matthias Klein | 2014-07-25 20:16:34 [+0200]:

>Hi all,
>
>we had the following problems when we enabled bus error reporting on
>an i.MX537 (Ka-Ro TX53-8130):
>- interrupt flooding when sending a packet on an open bus

This happens because
#1 the ISR always returns that it handled the interrupt even if it did
   nothing
#2 on error the interrupt source remains asserted on an open CAN bus as
   long as the CAN bus is open. This was verified on iMX53 (which has
   FLEXCAN_HAS_BROKEN_ERR_STATE) and imx6q

>- bus state change notifications did not work properly
The error-passive -> error warning transition was not reported to
userland, #3

>- second bus state change after bus recovery was not properly notified
The second transition from error-passive to error-warning does not work
properly. By second is meant a transition while the error counter >0
(in test scenarion  120 < x < 128). After the BUS was closed, the CAN
controller was able to send packages (they were received) but the
internal state said passive mode and the error counter was >128 and
decrementing with each can message sent.
New #4.

>Best regards,
>Matthias Klein

Sebastian
