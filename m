From: Krzysztof Witkowski <Krzysztof.Witkowski@mobile.put.edu.pl>
Subject: CPU load inhibits CAN interrupts
Date: Tue, 10 Apr 2012 16:40:14 +0200
Message-ID: <4F84464E.7030403@mobile.put.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from seawolf.cs.put.poznan.pl ([150.254.23.147]:49130 "EHLO
	seawolf.cs.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab2DJQrY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Apr 2012 12:47:24 -0400
Received: from [150.254.24.100] (kwitkowski.secpl [150.254.24.100])
	by seawolf.cs.put.poznan.pl (Postfix) with ESMTPSA id 6C1CE121834
	for <linux-can@vger.kernel.org>; Tue, 10 Apr 2012 18:40:15 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I have an Ubuntu box with 3.2 kernel, CPU with 2 cores and PEAK-PCI card 
(SJA1000 controller attached via PCI bus)

I'm testing receive capabilities of the card on 1Mbit network using 
peak_pci module. It can handle about ~4000 packets per second, the 
corresponding interrupt is also raised ~4000 times per second (as 
/proc/interrupts shows) and it does not cause high CPU load on the system.

However, if I generate artificial CPU load with stress command:

    chrt --idle 0 stress -c 2

the Receive Interrupts from SJA1000 are no longer raised at all and 
therefore no messages are received. At the same time network card (e100) 
on the same IRQ is working properly.

Why CPU load inhibits hardware interrupts and what can be done about it? 
Or should I suspect hardware malfunction?
