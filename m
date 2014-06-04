From: laurent vaudoit <laurent.vaudoit@gmail.com>
Subject: linux-can ISOTP module
Date: Wed, 4 Jun 2014 12:55:56 +0000 (UTC)
Message-ID: <loom.20140604T144601-350@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48191 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828AbaFDNAK (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 4 Jun 2014 09:00:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1WsAnU-0000LQ-VQ
	for linux-can@vger.kernel.org; Wed, 04 Jun 2014 15:00:07 +0200
Received: from rng31-2-88-169-200-32.fbx.proxad.net ([88.169.200.32])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 04 Jun 2014 15:00:04 +0200
Received: from laurent.vaudoit by rng31-2-88-169-200-32.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 04 Jun 2014 15:00:04 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all, 
i'm using isotp module for some work purpose,
on a imx25 board, with kernel 3.10.

I have integrated the module isotp and the correct header file in my
kernel.

I'm able to use isotpsend adn isotprecv functions but i have some questions:

Comming from automotiv diagnostic, we are used to configure a lots of 
parameters in our baremetal Iso15765 protocol firmware (stmin, 
bs,n_cs,n_bs...)
I have not seen anything to parameter timings such as n_cs, n_bs.
Is their something i missed?

For extended adressing method, it seems that both rx and tx frame must have 
the same first byte in can frame (the one set by ext_address field of the 
structure). This is correct for mixed addressing method (see Iso15765-2), 
but for extended adressing method, we should be able to specify different 
Target and source adress. I have not seen anything like this.

Last point, if i want to send a 255 bytes frame, with bs=0 and stmin=0 
(requested by the receiver), transfer start well SN 0x01 to SN 0x0B) but 
after i have a frame with SN 0x03 instead of SN = 0x0C and everything stop.

Does anyone encountered this kind of problem?

I will search for this problem as it is a big problem if we want to make 
some download through isotp.

Thanks in advance for your answer

Best regards

Laurent



