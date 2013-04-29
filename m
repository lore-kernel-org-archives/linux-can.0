From: "Sven Schuchmann" <schuchmann@schleissheimer.de>
Subject: flexcan: use hardware timestamp
Date: Mon, 29 Apr 2013 19:33:39 +0200
Message-ID: <517ECB130200000100098502@mail.schleissheimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schleissheimer.de ([62.153.209.162]:51577 "EHLO
	mail.schleissheimer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757275Ab3D2RmB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Apr 2013 13:42:01 -0400
Received: from berlix.schleissheimer.de ([192.168.1.187]:51799 helo=mail.schleissheimer.de)
	by mail.schleissheimer.de with esmtp (Exim 4.76)
	(envelope-from <schuchmann@schleissheimer.de>)
	id 1UWrxO-0001Sf-1Z
	for linux-can@vger.kernel.org; Mon, 29 Apr 2013 19:33:42 +0200
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,
I was wondering if the flexcan driver uses the hardware timestamp
and by looking at the code under drivers/net/can/flexcan.c and did
not find any access to those registers.
 
is there a special reason for this?
 
If not, I would try implementing to use skb_shared_hwtstamps...
 
Best Regards,
 
   Sven

