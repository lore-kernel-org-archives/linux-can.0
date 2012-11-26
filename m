From: Henrik Bork Steffensen <hbs@rosetechnology.dk>
Subject: at91_can.c: Data transmission stops
Date: Mon, 26 Nov 2012 15:28:32 +0100
Message-ID: <50B37C90.3040904@rosetechnology.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from dmz4.rosetechnology.dk ([95.154.61.7]:46908 "EHLO
	dmz4.rosetechnology.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861Ab2KZOhO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 09:37:14 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by dmz4.rosetechnology.dk (Postfix) with ESMTP id 3E17EA3028
	for <linux-can@vger.kernel.org>; Mon, 26 Nov 2012 15:28:32 +0100 (CET)
Received: from dmz4.rosetechnology.dk ([127.0.0.1])
	by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IkY3rNYop5TR for <linux-can@vger.kernel.org>;
	Mon, 26 Nov 2012 15:28:32 +0100 (CET)
Received: from [192.168.36.250] (unknown [95.154.61.6])
	by dmz4.rosetechnology.dk (Postfix) with ESMTPA id 18C60A300E
	for <linux-can@vger.kernel.org>; Mon, 26 Nov 2012 15:28:32 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi All,

We use the canopen on an at91sam9263, and experience a can problem.
Sometimes data transmission simply stops. Data reception continues normally.

Reloading the at91_can module seems to be the only action to bring our 
system back on can.
When we experience this problem, the TXF counter in /proc/net/can/stats 
is frozen.

I have followed the thread on a similar issue "pch_can", and I was wondering
if this is the same problem, and if the real problem might be in a 
higher level.

In our case the lockup occurs approximately 1 time in 50 days.
I tried reducing the number of mailboxes used for TX, from 4 to 1.
That seem to increase the frequency of this lockup by a factor 2-5.
These numbers are very uncertain due to the randomness and rarity of 
this bug.

Some numbers to give an impression of our system:
125 kbit bus speed
can bus load <1%
max tx burst 1-6 telegrams, rx is a little bit higher.
240MHz ARM 9 (at91sam9263B)
2.6.32 kernel, with at91_can (and related files) patched with a few 
important fixes.
I would like to move to a recent kernel, but that is not possible right now.


I am considering protecting tx objects as Wolfgang suggests in the 
pch_can thread.

Any ideas?

best regards,
Henrik Bork Steffensen



