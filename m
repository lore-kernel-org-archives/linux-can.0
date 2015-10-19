From: s-amarce <s-amarce@haw-landshut.de>
Subject: Canplayer play to can0 - problem
Date: Mon, 19 Oct 2015 11:14:14 +0200
Message-ID: <447a130eb0e223d5336a160a19d91648@haw-landshut.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx02.haw-landshut.de ([193.175.141.22]:34485 "EHLO
	mx02.haw-landshut.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbbJSJXx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2015 05:23:53 -0400
Received: from mx01.haw-landshut.de (mx01.haw-landshut.de [193.175.141.21])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx02.haw-landshut.de (Postfix) with ESMTPS id 9F4E8601B9
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2015 11:14:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mx01.haw-landshut.de (Postfix) with ESMTP id 8EDCB602F2
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2015 11:14:14 +0200 (CEST)
Received: from mail.fh-landshut.de ([IPv6:::ffff:193.175.141.61])
	by localhost (mx01.haw-landshut.de [::ffff:193.175.141.21]) (amavisd-new, port 10024)
	with ESMTP id 5Q9LPhqP8FOM for <linux-can@vger.kernel.org>;
	Mon, 19 Oct 2015 11:14:14 +0200 (CEST)
Received: from webmail.haw-landshut.de (webmail.haw-landshut.de [193.175.141.233])
	by mail.fh-landshut.de (Postfix) with ESMTPSA id 2D4F36038D
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2015 11:14:14 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

To whom it may concern,

I am currently trying to play a recorded log-file to my installed device 
can0. There are no problems when the  data is streamed to the device 
using a cable.
I managed to stream the log file to a virtual device executing the 
command canplayer can0=3Dvcan0 < file.log.
Using this command I can see all the data using candump vcan0 without 
any problems.
However when I try to run: canplayer can0=3Dcan0 < file.log, I receive 
the error: "sendto: No buffer space available."
Is it possible to replay logfiles to real devices like can0 or do I have 
to use virtual devices?

My ifconfig after reboot:
           can0      Link encap:UNSPEC  HWaddr 
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
           UP RUNNING NOARP  MTU:16  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:10
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
           Interrupt:68

// The error
          canplayer can0=3Dcan0 < data.log
          sendto: No buffer space available

// After
          ifconfig can0
           can0      Link encap:UNSPEC  HWaddr 
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
           UP RUNNING NOARP  MTU:16  Metric:1
           RX packets:2 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:10
           RX bytes:16 (16.0 B)  TX bytes:0 (0.0 B)
           Interrupt:68

I hope you can help me with this. I look forward to hearing from you.

Andreas Marcec
