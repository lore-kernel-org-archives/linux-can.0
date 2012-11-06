From: Pascal <Pascalkrauth@gmail.com>
Subject: cansend uses wrong ID and gives wrong Payload, candump works fine
Date: Tue, 6 Nov 2012 12:23:34 +0000 (UTC)
Message-ID: <loom.20121106T132252-54@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53941 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997Ab2KFMXt (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 6 Nov 2012 07:23:49 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TViCB-0006HL-9d
	for linux-can@vger.kernel.org; Tue, 06 Nov 2012 13:23:55 +0100
Received: from 106.51.64.154 ([106.51.64.154])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 06 Nov 2012 13:23:55 +0100
Received: from Pascalkrauth by 106.51.64.154 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 06 Nov 2012 13:23:55 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello, 

I test the canutils. I can use candump and read CAN Messages correctly which I 
send throug a PEAK CAN from another machine. 
If I try to send a message back using: "cansend can0 500#1E.10.10" which from my 
understanding should give my a Message on ID 500 with Paylod 1E 10 and 10 I 
receive on ID 1 with DLC 1 Payload F4. 

Is this a common issue? 
I use a craneboard with Angstrom. 

Best regards from India, 
Pascal

