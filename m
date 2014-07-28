From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH V2 5/5] net: can: flexcan: fix for wrong TX error count
 behaviour on i.MX53
Date: Mon, 28 Jul 2014 09:08:24 +0200
Message-ID: <53D5F6E8.8070808@linutronix.de>
References: <1406529268-20126-1-git-send-email-matthias.klein@optimeas.de> <1406529268-20126-5-git-send-email-matthias.klein@optimeas.de> <53D5F654.6050203@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38225 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbaG1HI0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Jul 2014 03:08:26 -0400
In-Reply-To: <53D5F654.6050203@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Matthias Klein <matthias.klein@optimeas.de>, wg@grandegger.com, linux-can@vger.kernel.org, support@karo-electronics.de

On 07/28/2014 09:05 AM, Marc Kleine-Budde wrote:
> On 07/28/2014 08:34 AM, Matthias Klein wrote:
>> Once the CAN-bus is open and a packet is sent, the controller switches
>> into the PASSIVE state and the TX error count goes to 0x80. When the
>> bus is closed and the packet gets acknowledged the controller switches
>> to ERROR-WARNING state and the TX error counter is decremented to 0x7f.
>> Everything OK so far.
>>
>> When now the bus is open again and a packet is sent, the controller
>> switches into PASSIVE state and sets the TX error count to 0x86.
>> When now the bus is closed the TX error is decremented to 0x85, but
>> the state does not change to ERROR-WARNING. Now with each successfully
>> transfered packet (in PASSIVE state!) the TX error counter is
>> decremented, and when the TX error counter reaches 0x7f the controller
>> switched back into ERROR-WARNING state.
> 
> My original comment still applies, I don't see a problem with sending
> CAN frames in error passive mode.
> 
> The only thing that violates the specs is IMHO, that the TX error
> counter is incremented > 127 when the bus is open, although is does not
> reach 255.

According to the spec it is frozen and never will be incremented.

>> This fix sets the TX error count back to zero when entering the
>> ERROR-WARNING state (after the first retransfered packet is acknowledged).
> 
> Why do you this? The expected behaviour is that each successfully
> transmitted CAN frame decreases the TX error counter. So it will take a
> few frames until you reach a TX error counter of 0 when coming from
> error passive.

How does the user learn that he is able to send a can frame?

> 
> Marc

Sebastian
