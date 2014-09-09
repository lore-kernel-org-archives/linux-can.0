From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Inconsistent error state transition error frames
Date: Tue, 09 Sep 2014 12:48:53 +0200
Message-ID: <a62de8d447dda55b1aa30711f0dc4605@grandegger.com>
References: <7EAA3DE6DC6BA14D830C95541CC66EBC9F72FED6@GRBSR0004.marel.net>
 <540DDB16.8010304@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:54956 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752992AbaIIK6j (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 9 Sep 2014 06:58:39 -0400
In-Reply-To: <540DDB16.8010304@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Andri Yngvason <Andri.Yngvason@marel.com>, linux-can@vger.kernel.org

On Mon, 08 Sep 2014 18:36:38 +0200, Marc Kleine-Budde <mkl@pengutronix.de>
wrote:
> On 09/08/2014 06:26 PM, Andri Yngvason wrote:
>> I've been working on a userspace program to monitor the CAN bus and I
>> found that it only works as expected on one platform (flexcan). The
>> problem is that on most other platforms, no error frame is emitted
>> when the controller transitions back to error-active state. I see

Also the Flexcan implementation does not correctly change the error
states backwards, IIRC.

>> that you've already discussed this on this list here:
>> http://thread.gmane.org/gmane.linux.can/201
>>
>> Why hasn't this been resolved?
> 
> I assume no one needed this feature so far, I assume. And/or cared not
> enough to upstream these patches.

Yep, little time left for free software development, lack of hardware,
etc. Somebody needs to care and post patches. Anyway, that's a good
occasion to start a migration path, maybe first for the Flexcan and
SJA1000 and MSCAN.

>> I already patched the mscan and sja1000 drivers myself, and I was
>> considering submitting them, but since you've already done some work
>> on this (which I believe is superior to mine), my work is unlikely to
> 
> Wolfgang mentioned in this mail, that he had some patches back than. Do
> you still have them, Wolfgang?

The patches to consolidate bus-off and error-state handling are still
at:

https://gitorious.org/linux-can/wg-linux-can-next/commits/eec921ac28fde243456078a557768808d93d94a3
https://gitorious.org/linux-can/wg-linux-can-next/commit/825f9bcb961aa193bacb9af6fb0d8491ee8fd02e

They introduce the can_id flag CAN_ERR_STATE_CHANGE and the data[1] flag
CAN_ERR_CRTL_ACTIVE, which I think would simplify migration. Also
there is now a common function can_change_state() which should make
the driver code more readable.

>> be of any consequence to this community, except to show that this
>> inconsistency does indeed result in wasted effort and frustration.
> 
> Feel free to post your patches.
> 
>> Of course, I'll help out if I can, e.g. by testing on the platforms
>> that I have available.

That would be very useful. Currently I do not have any CAN hardware at
hand.

Wolfgang.
