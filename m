From: swapnil <patilswa@gmail.com>
Subject: J1939 Interpacket Delay
Date: Wed, 9 Apr 2014 14:17:11 +0000 (UTC)
Message-ID: <loom.20140409T155830-71@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44901 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933330AbaDIOR0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 9 Apr 2014 10:17:26 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1WXtJd-0000wb-F1
	for linux-can@vger.kernel.org; Wed, 09 Apr 2014 16:17:25 +0200
Received: from 192.158.48.18 ([192.158.48.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 09 Apr 2014 16:17:25 +0200
Received: from patilswa by 192.158.48.18 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 09 Apr 2014 16:17:25 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi All,

        Hey Kurt I am using the J1939 stack on begalbone 
I am halfway through. I am getting some issue while testing with different 
engine control modules

1. Is it possible to add inter packet delay in 2 frames. Now the gap between 
two frame is 540 to 555 uSec which is very fast. My other engine control 
module is not that fast ..
    please check the Log 
1387762862.278774) can0 18EC00F9#104906E6E600EF00
(1387762862.279388) can0 18ECF900#11E601FFFF00EF00
(1387762862.280160) can0 18EB00F9#014D000010800000
(1387762862.280705) can0 18EB00F9#020640FB05FFFFFF
(1387762862.281284) can0 18EB00F9#03FFFFFF00000000
                        .
                        .
                        .  
(1387762862.566022) can0 18EB00F9#E45F4D0000000841
(1387762862.566574) can0 18EB00F9#E55850325F4E0000
(1387762862.567091) can0 18EB00F9#E6000841585431
(1387762863.822072) can0 18EC00F9#FF03FFFFFF00EF00

The other End is not sending message if i use adapter It receive EOM
   i want to make difference between to packet is 600uSec


2.if There is only one device connected on the bus like Begalbone(address -
f9) and Engine control module(address -00) 
     if i send a message to address 01 or 02 on can bus i see message for 01 
is converted to address 00 
like i amsending 18EF01F9#FF000000000002FF
but in candump i got
(1387762810.854139) can0 18EF00F9#FA000000000002FF
(1387762810.854762) can0 18EFF900#FB0000024733FFFF

Thank You 


