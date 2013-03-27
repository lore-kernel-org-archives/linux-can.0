From: du <duzhenhuan@gmail.com>
Subject: socketcan receive queue too many frames
Date: Wed, 27 Mar 2013 11:38:29 +0000 (UTC)
Message-ID: <loom.20130327T122706-603@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48296 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253Ab3C0Lop (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 27 Mar 2013 07:44:45 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1UKomu-0004mg-Bv
	for linux-can@vger.kernel.org; Wed, 27 Mar 2013 12:45:04 +0100
Received: from 113.227.62.246 ([113.227.62.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 27 Mar 2013 12:45:04 +0100
Received: from duzhenhuan by 113.227.62.246 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 27 Mar 2013 12:45:04 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello, I'm using socketcan buffer , 
but i'm getting frames for tens of seconds even after I have open the CAN wire
from the bus, In my application ,frame lost is not a problem since I'm using
cyclic process data. I just want to make sure the frame is stopped just when I
disconnect the cable. 

What should I do ? How can I make receive buffer smaller?

