From: John Whitmore <arigead@gmail.com>
Subject: mcp251x can't drop the can0 Interface
Date: Fri, 7 Feb 2014 20:12:37 +0000
Message-ID: <20140207201236.GB28637@griso.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:44674 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbaBGUMG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Feb 2014 15:12:06 -0500
Received: by mail-we0-f176.google.com with SMTP id q58so2665508wes.35
        for <linux-can@vger.kernel.org>; Fri, 07 Feb 2014 12:12:04 -0800 (PST)
Received: from griso.site (host86-131-29-51.range86-131.btcentralplus.com. [86.131.29.51])
        by mx.google.com with ESMTPSA id jd2sm9327479wic.9.2014.02.07.12.12.03
        for <linux-can@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2014 12:12:04 -0800 (PST)
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I guess you might say that I'm playing with an MCP2515 connected to a
RaspberryPi. I've got a problem which I've asked about on the RaspberryPi
forum but have never received an answer, so as a last resort I thought I'd try
here.

Basically I bring up the MCP2515 in listen mode at a certain baud rate. I
wanted to work on auto detetection of baud rate. So after listening for a
period of time at a certain baud rate I try to change the baud rate but I
can't do that with the linux mcp251x driver (I don't think it's the driver's
fault but have no idea whose it is). I've put in some debug statements
to see what happens when I execute "ifconfig can0 down" and basically the
interface goes down momentarily and then gets brough straight back up
again. So when I try to use the "ip" command to set the new baud rate I get an
error that the device is busy. 

Now I'm not sure if the issue is in the linux kernel or in the system
utilities "ifconfig" and "ip", but just wondered if anybody has seen this
behaviour. (I saw that there was a book published in January on linux
networking and must see if it deals with internals or just socket
programming.) If somebody could point me in the correct direction to look I'd
be very grateful. Or if somebody can confirm or deny this behaviour. 
