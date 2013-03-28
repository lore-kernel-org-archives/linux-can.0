From: Oliver Stefan <os252@gmx.de>
Subject: Transmitted Data is not to be received by other Application
Date: Thu, 28 Mar 2013 13:12:31 +0100
Message-ID: <515433AF.7000203@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:58713 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753095Ab3C1MMh (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 28 Mar 2013 08:12:37 -0400
Received: from mailout-de.gmx.net ([10.1.76.33]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0M9LrE-1UVc560VuY-00CjPx for
 <linux-can@vger.kernel.org>; Thu, 28 Mar 2013 13:12:34 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I'm developing Software for the Raspberry Pi with MCP2515 extension.

I have two applications running the same time.
One is in the receiving mode, and the other can transmit and receive.
Unfortunately the application that is permanently receiving, receives 
the data of the second application too.

How can I turn off this function?

I read the helpfile
http://svn.berlios.de/wsvn/socketcan/trunk/kernel/2.6/Documentation/networking/can.txt 

but I don't see there any possibility to eleminate this function.

Thank you very much!


