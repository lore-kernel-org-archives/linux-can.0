From: Giox79 <giovanniparodi79@gmail.com>
Subject: CAN j1939 library doubts
Date: Tue, 12 Mar 2013 21:52:41 +0000 (UTC)
Message-ID: <loom.20130312T213038-40@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:45412 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103Ab3CLVyn (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 12 Mar 2013 17:54:43 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1UFXA0-00088o-9Z
	for linux-can@vger.kernel.org; Tue, 12 Mar 2013 22:55:04 +0100
Received: from host9-41-dynamic.20-79-r.retail.telecomitalia.it ([79.20.41.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 12 Mar 2013 22:55:04 +0100
Received: from giovanniparodi79 by host9-41-dynamic.20-79-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 12 Mar 2013 22:55:04 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello everybody.
I'm working on an embedded system, and I would like to dump data 
from CAN bus and parse j1939 data. 
I built canutils, last version, on ARM device, however, I'm a bit 
 about how to use the j1939 version of canutils.
Is there any tutorial about what should I do in order to use 
Utilities  like jspy?
If I'm right, I have to build both the kernel and the user app section.
I'm a Linux beginner, and I didn't find guides to these steps.
Any help, link to website or similar resources will be really appreciated.

Finally is there anyone that compiled the j1939 can libraries on 
ARM systems?


