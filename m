From: Kristian Borgen <kb@xpress.dk>
Subject: Re: socketcan and perl module ?
Date: Sat, 12 Jan 2013 15:03:57 +0000 (UTC)
Message-ID: <loom.20130112T155323-635@post.gmane.org>
References: <eb163bb46a69fe58c0d3f9676172ed9a@localhost> <50C76361.7000605@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42342 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753387Ab3ALPex (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sat, 12 Jan 2013 10:34:53 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Tu36v-0007Y2-0P
	for linux-can@vger.kernel.org; Sat, 12 Jan 2013 16:35:05 +0100
Received: from xpress.dk ([87.73.131.105])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Sat, 12 Jan 2013 16:35:05 +0100
Received: from kb by xpress.dk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Sat, 12 Jan 2013 16:35:05 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi

If anyone is interested i made a Socket::Can perl module, i only used it for 
dumping can/canopen and as a quick way to configure canopen nodes, my actual 
daemon i written using canfestival so it is not stress tested, and i only used 
it on debian.

Source can found at http://kb.xpress.dk/src/canbus


Regards

Kristian Borgen

