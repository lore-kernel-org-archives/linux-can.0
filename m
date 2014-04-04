From: Daniel =?utf-8?b?Qm9zdHLDtm0=?= <daniel.bostrom@maximatecc.com>
Subject: Re: SocketCAN over Ethernet
Date: Fri, 4 Apr 2014 11:59:12 +0000 (UTC)
Message-ID: <loom.20140404T134940-234@post.gmane.org>
References: <loom.20140403T134741-892@post.gmane.org> <533DB9A6.6030605@hartkopp.net> <loom.20140404T084336-169@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34924 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687AbaDDL70 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 4 Apr 2014 07:59:26 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1WW2mL-0002uH-8e
	for linux-can@vger.kernel.org; Fri, 04 Apr 2014 13:59:25 +0200
Received: from 193.15.169.28 ([193.15.169.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 04 Apr 2014 13:59:25 +0200
Received: from daniel.bostrom by 193.15.169.28 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 04 Apr 2014 13:59:25 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I created a vcan interface, built and started the socketcand daemon on the 
Ubuntu vm and finally installed Kayak on Windows. I had to edit 
socketcand.conf a bit but now CAN messages sent using cansend from Ubuntu 
show up in Kayak. I think this is a great start, thanks again for the help.

