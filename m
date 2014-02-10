From: Luc Richer <lricher@symboticware.com>
Subject: trouble bringing up can0 interface on intel eg20t chipset
Date: Mon, 10 Feb 2014 11:52:59 -0500
Message-ID: <52F903EB.8030107@symboticware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:56407 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbaBJQxF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Feb 2014 11:53:05 -0500
Received: by mail-ie0-f182.google.com with SMTP id lx4so3723399iec.13
        for <linux-can@vger.kernel.org>; Mon, 10 Feb 2014 08:53:05 -0800 (PST)
Received: from localhost.localdomain (noble-trade-kingst.vianet.ca. [209.91.163.71])
        by mx.google.com with ESMTPSA id kb10sm43978332igb.6.2014.02.10.08.53.00
        for <linux-can@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Feb 2014 08:53:04 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I am trying to interface with vehicle engine using Intel EG20T chipset.

This board does have a pinout for CANbus interface, and I believe I have 
determined the correct module for the interface is pch_can
http://cateee.net/lkddb/web-lkddb/PCH_CAN.html
Someone told me I may need the i2c module for this chipset as well, so I 
have loaded it also (i2c_eg20t)

I have loaded the modules for the can interface (can, can-dev, can-raw, 
can-bcm) along with i2c_eg20t and pch_can.

dmesg | grep can reveals
can: controller area network core (rev 20120528 abi 9)
can: raw protocol (rev 20120528)
can: broadcast manager protocol (rev 20120528 t)

but nothing is listed regarding pch_can and the interface can0 is never 
listed.

dmesg | grep can0 gives no result and cat /proc/net/dev lists p2p1 and 
lo but no can.

can-utils have been built and installed and appear to be working 
correctly (although I cannot test without a can interface really)

What am I missing?
