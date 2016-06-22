From: ajneu <ajneu1@gmail.com>
Subject: Clear transmit buffer (of pending queued tx-messages)
Date: Wed, 22 Jun 2016 12:11:46 +0000 (UTC)
Message-ID: <loom.20160622T135857-352@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52816 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbcFVNAI (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 22 Jun 2016 09:00:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bFh0a-0008Di-DZ
	for linux-can@vger.kernel.org; Wed, 22 Jun 2016 14:11:52 +0200
Received: from 195.50.142.51 ([195.50.142.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 22 Jun 2016 14:11:52 +0200
Received: from ajneu1 by 195.50.142.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 22 Jun 2016 14:11:52 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

how do you guys handle clearing of the transmit buffer?
(Usage-case example:
Imaging: buffer is filled with tx-messages, but no other participant on the
bus. After 1 minute, those queued tx-messages are outdated. We definitely
want to clear the queue, to prevent those messages from getting sent out, if
a participant connects to the bus again.)


I think... 
that one has to distinguish between 
a) non-blocking or blocking mode of write... on the userspace side;
and 
b) the buffering in qdisc
c) the buffering of tx-messages queued inside the CAN controller itself.

Whew!

Concerning 
a)
Is it correct that I need non-blocking, if I want to prevent userspace
sticking in blocking write calls? 
(Or is it possible to get a blocking write call to return immediately?
Perhaps sending a signal?)

Concerning 
b) and c)
How does one clear the qdisc and messages still queued inside the CAN
controller?
One method is probably using libsocketcan and issuing can_do_stop() followed
by can_do_start()... Would that work?
Any other possibilities?
Anybody willing to share some best practices?

Thanks.
ajneu

