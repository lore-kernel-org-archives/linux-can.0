From: "Mylene Josserand" <Mylene.Josserand@navocap.com>
Subject: [mcp251x - spi] Blocked to "wait_for_completion"
Date: Thu, 6 Dec 2012 12:22:52 +0100
Message-ID: <CA78C307B8F06747967D122FC656B1537FEDF3@SERVEUR0.nvp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from poutre.nerim.net ([178.132.16.124]:49522 "EHLO poutre.nerim.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423283Ab2LFLcH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 06:32:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by poutre.nerim.net (Postfix) with ESMTP id F181D39E1A8
	for <linux-can@vger.kernel.org>; Thu,  6 Dec 2012 12:22:50 +0100 (CET)
Received: from poutre.nerim.net ([127.0.0.1])
	by localhost (poutre.nerim.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d2QN9AgjKmIL for <linux-can@vger.kernel.org>;
	Thu,  6 Dec 2012 12:22:49 +0100 (CET)
Received: from SERVEUR0.nvp.local (navocap-sdsl-19-50.cnt.nerim.net [213.215.19.50])
	by poutre.nerim.net (Postfix) with ESMTP id C8C7239DFC1
	for <linux-can@vger.kernel.org>; Thu,  6 Dec 2012 12:22:49 +0100 (CET)
Content-class: urn:content-classes:message
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi everyone,


I am new to this mailing list so I hope I am writing to the good section. 
It is the first time I use CAN protocol so I am a newbie !
I am currently working on CAN with the driver MCP251x for my company.

For some reasons, my company have the kernel 2.6.32.59 version. The MCP251x driver have been backported from the Linux version 2.6.34.
I am testing it but only for reading purpose. So I have a set-up to send CAN frame (in another computer) and received them with candump (this is what I want).


When I send CAN frames every 20 ms, the CAN interface seems to be blocked after 1-2 minutes (sometimes 5 minutes) of reading. In fact, the candump stop showing CAN messages and I can not act anymore on it. 
If I increase the interval time between frames (100 msec), the time before being blocked is around 30-40 minutes. And if it is every 1 sec, it is after 13 hours !

I have made some debugging traces on the driver and I saw that the problem is in the call of "spi_sync" function (in the "mcp251x_spi_trans" function).
I have done the same on the "spi.c" and I saw that the spi is blocked by the "wait_for_completion" function. What is it waiting for ?
With some readings, I saw that this function is not stoppable so it is normal that the function is blocked. But I did not understand why it is blocking in this function only after some times.

Can you have some explanation of this problem ? Have you already seen that before ?
How solve it ? Update the kernel to new version ? (If you have new version, could you test it please ?)
I have seen that some new kernel version (3.0.53 and upper) have some update on this spi_sync function. Is this going to fix this problem or not ?


Thank you in advance for any help !


PS : I had an Undelivered response. I did not know if my email has been sent so I send it a 2nd time. Sorry for potential spam !


Best regards,


Mylene JOSSERAND
