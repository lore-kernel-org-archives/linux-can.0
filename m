From: John Whitmore <arigead@gmail.com>
Subject: vcan multithreaded problem testing
Date: Sun, 16 Feb 2014 10:04:31 +0000
Message-ID: <20140216100428.GC5440@griso.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:41641 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbaBPKDt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 16 Feb 2014 05:03:49 -0500
Received: by mail-wi0-f181.google.com with SMTP id hi5so1570754wib.14
        for <linux-can@vger.kernel.org>; Sun, 16 Feb 2014 02:03:47 -0800 (PST)
Received: from griso.site ([109.255.92.126])
        by mx.google.com with ESMTPSA id jd2sm21355403wic.9.2014.02.16.02.03.47
        for <linux-can@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Feb 2014 02:03:47 -0800 (PST)
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello all, I'll try keep this short. I'm using vcan to test code I'm porting
from my embedded hardware. My embedded code has a simple dispatcher which
process all messages received from the Network. Higher layers of the
Application register an interest in certain CAN ids or ranges.

I don't need this dispatcher as Socket CAN filters already so in porting my
application the higher layers now simply create a new linux thread and socket
to listen for CAN Frames that they have an interest in.

My problem is that in testing with vcan if my core process thead sends a CAN
id which a child thread is filtering on then the child thread receives the
message. I've looked at vcan code and it simply consumes the sent frames back
into the linux networking stack.

At present a single process will not receive a CAN Frame which is sends but
it's child threads will recive the frame. Is there a way to restrict this? I
might have to wait until I get back to Hardware and test there but it would be
very handy to be able to use vcan.

John
