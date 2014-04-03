From: Daniel =?utf-8?b?Qm9zdHLDtm0=?= <daniel.bostrom@maximatecc.com>
Subject: SocketCAN over Ethernet
Date: Thu, 3 Apr 2014 11:52:49 +0000 (UTC)
Message-ID: <loom.20140403T134741-892@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60886 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382AbaDCNtx (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 3 Apr 2014 09:49:53 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1WVhYp-0003Ho-Lp
	for linux-can@vger.kernel.org; Thu, 03 Apr 2014 15:20:03 +0200
Received: from 193.15.169.28 ([193.15.169.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 03 Apr 2014 15:20:03 +0200
Received: from daniel.bostrom by 193.15.169.28 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 03 Apr 2014 15:20:03 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

I am going to try to explain our scenario briefly.

We want to setup a simulation environment for our system running on Ubuntu 
so that we can use it together with our Windows based simulation tool 
suite. Currently we are running Ubuntu in a virtual machine using 
VirtualBox on a Windows host. In Ubuntu we use SocketCAN and we would like 
to continue to do so but instead of using real CAN hardware somehow setup 
CAN communication over Ethernet to the Windows host.

I am new to CAN on Linux but I have been reading about SocketCAN and was 
wondering if we could use virtual can (vcan) somehow?

I appreciate any help clarifying if, and if so, how SocketCAN over 
Ethernet could be achieved. If you need additional information about our 
scenario please let me know.

Best regards
Daniel
 

