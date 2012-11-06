From: Pascal <Pascalkrauth@gmail.com>
Subject: Re: cansend uses wrong ID and gives wrong Payload, candump works fine
Date: Tue, 6 Nov 2012 12:35:38 +0000 (UTC)
Message-ID: <loom.20121106T133317-792@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37416 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017Ab2KFMfz (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 6 Nov 2012 07:35:55 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TViNt-0005Hu-7s
	for linux-can@vger.kernel.org; Tue, 06 Nov 2012 13:36:01 +0100
Received: from 106.51.64.154 ([106.51.64.154])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 06 Nov 2012 13:36:01 +0100
Received: from Pascalkrauth by 106.51.64.154 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 06 Nov 2012 13:36:01 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Nevermind. 

I used as second side a PCAN-View. 

I got confused because of a old tutorial which used the code in another way. 
cansend works fine if you are using it properly like. 

cansend can0 10 20 10 20 -i 10 which sends a 10,20,10,20 on ID 10. 

Sorry for the disturbance ;-) 

Thanks anyway, best regards from India,
Pascal

