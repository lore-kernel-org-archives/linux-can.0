From: laurent vaudoit <laurent.vaudoit@gmail.com>
Subject: Raw can socket close and disabling filters
Date: Fri, 22 Apr 2016 11:39:20 +0000 (UTC)
Message-ID: <loom.20160422T133332-34@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36009 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbcDVLja (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 22 Apr 2016 07:39:30 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1atZQl-0003SR-Le
	for linux-can@vger.kernel.org; Fri, 22 Apr 2016 13:39:28 +0200
Received: from 212.194.216.83 ([212.194.216.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 22 Apr 2016 13:39:27 +0200
Received: from laurent.vaudoit by 212.194.216.83 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 22 Apr 2016 13:39:27 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,
i'm using a 3.10 kernel with rtpatch applied, with raw can features.
Running some debug in the release function, i've seen something weird (for 
me).

In the function, we get the socket informations
and then we unregister the notifier.

After this, we test if the socket is bound and which is the ifindex.

But when the unregister function is called, there is a call to the notifier 
with the event NETDEV_UNREGISTER, who leads to clear the socket inforamtions 
like bound and ifindex.

So in the release function we can never enter in the code specific to a 
device.

Is there something i've missed?

Thanks in advance for your answer.
Regards
Laurent

