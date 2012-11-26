From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: at91_can.c: Data transmission stops
Date: Mon, 26 Nov 2012 16:25:10 +0100
Message-ID: <50B389D6.4050308@grandegger.com>
References: <50B37C90.3040904@rosetechnology.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:33167 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249Ab2KZPZU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 10:25:20 -0500
In-Reply-To: <50B37C90.3040904@rosetechnology.dk>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Henrik Bork Steffensen <hbs@rosetechnology.dk>
Cc: linux-can@vger.kernel.org

On 11/26/2012 03:28 PM, Henrik Bork Steffensen wrote:
> Hi All,
> 
> We use the canopen on an at91sam9263, and experience a can problem.
> Sometimes data transmission simply stops. Data reception continues
> normally.
> 
> Reloading the at91_can module seems to be the only action to bring our
> system back on can.
> When we experience this problem, the TXF counter in /proc/net/can/stats
> is frozen.
> 
> I have followed the thread on a similar issue "pch_can", and I was
> wondering
> if this is the same problem, and if the real problem might be in a
> higher level.
> 
> In our case the lockup occurs approximately 1 time in 50 days.

:(

> I tried reducing the number of mailboxes used for TX, from 4 to 1.
> That seem to increase the frequency of this lockup by a factor 2-5.
> These numbers are very uncertain due to the randomness and rarity of
> this bug.
> 
> Some numbers to give an impression of our system:
> 125 kbit bus speed
> can bus load <1%
> max tx burst 1-6 telegrams, rx is a little bit higher.
> 240MHz ARM 9 (at91sam9263B)
> 2.6.32 kernel, with at91_can (and related files) patched with a few
> important fixes.
> I would like to move to a recent kernel, but that is not possible right
> now.
> 
> 
> I am considering protecting tx objects as Wolfgang suggests in the
> pch_can thread.

This problem is with SMP in the first place. Can you show your .config.
The c_can driver uses similar code than the at91_can and they have
therefore the same issues if the kernel is preemptable, IIUC. Should not
be a big deal to adapt the following patch:

  http://marc.info/?l=linux-can&m=135391821814519&w=2

Wolfgang.

