From: Giox79 <giovanniparodi79@gmail.com>
Subject: Parsing j1939 from raw candump
Date: Mon, 25 Mar 2013 21:02:43 +0000 (UTC)
Message-ID: <loom.20130325T214842-307@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48471 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754455Ab3CYVDE (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 25 Mar 2013 17:03:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1UKEY9-0001nB-C2
	for linux-can@vger.kernel.org; Mon, 25 Mar 2013 22:03:25 +0100
Received: from host70-127-dynamic.45-79-r.retail.telecomitalia.it ([79.45.127.70])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 25 Mar 2013 22:03:25 +0100
Received: from giovanniparodi79 by host70-127-dynamic.45-79-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 25 Mar 2013 22:03:25 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello everybody, I would like to ask some suggestion.
As said in a previous post, I rebuilt candump utils on a 
custom board with a can interface.
I've been able to capture data using the 
canlogserver  util and everything worked fine. 
Now I would like to build a SW application, 
running in a PC and receiving the data from canlogserver. 
This application should parse raw candump packet and 
extract j1939 packet.
Is there anyone that can suggest me how to approach 
this topic? I tried using the j1939-71 standard, 
but as far as I understand, it explains differences between 
different packages, but I didn't find an 
explanation about header and trailer of J1939 packet.
Please note that I have the whole j1939 standard and that 
at present time I can't integrate the j1939 canutils in linux 
kernel because I should use for other kind of constraints 
a 2.6 linux kernel.
Any help, reference to specific sections of j1939 standard
 and so on will be appreciated.
Giovanni

