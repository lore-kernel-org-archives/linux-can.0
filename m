From: "Mahesh Maharjan" <mahesh.maharjan@web.de>
Subject: ISOTP-implementation
Date: Tue, 2 Oct 2012 10:33:49 +0200 (CEST)
Message-ID: <trinity-e227a661-0fd3-43e4-80ac-b4854f33afba-1349166829591@3capp-webde-bs17>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:57793 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754368Ab2JBIdv (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 2 Oct 2012 04:33:51 -0400
Received: from 3capp-webde-bs17.server.lan ([172.19.170.17]) by
 mriweb.server.lan (mriweb001) with ESMTPA (Nemesis) id
 0MbLZq-1T2Wy12uMW-00JIQr for <linux-can@vger.kernel.org>; Tue, 02 Oct 2012
 10:33:49 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org


Thank you Oliver providing me some guideline to use  ISO-TP socketCan for multiple socket. 
In my previous queries- I think, I could not able to describe my problem properly.
While working with RAW socket in Imx6, I was having problem with frame lost during the Tx. So, I was thinking to use multiple socket to minimise the lost of can frame in ISOTP also. 

Another important things about Point to Point(ISOTP), as you wrote me;
One write() syscall -> one ISO-TP PDU is sent

One ISO-TP PDU is received -> one read() syscall get's the PDU

Would you please provide some further guide line on it, whether I can use some acknowledge between read Or writing frames. So I would prefer to know get inform with complete  tranmsmission Complete or  Received Complete...


~Mahesh
