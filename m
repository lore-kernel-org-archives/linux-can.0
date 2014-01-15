From: swapnil <patilswa@gmail.com>
Subject: Re: AW: Need support J1939 protocol support to my kernel (v3.8 on BeagleBone Black)
Date: Wed, 15 Jan 2014 16:14:41 +0000 (UTC)
Message-ID: <loom.20140115T171400-435@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51533 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbaAOQPJ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 15 Jan 2014 11:15:09 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1W3T7R-0007lC-V5
	for linux-can@vger.kernel.org; Wed, 15 Jan 2014 17:15:05 +0100
Received: from 192.158.48.16 ([192.158.48.16])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 15 Jan 2014 17:15:05 +0100
Received: from patilswa by 192.158.48.16 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 15 Jan 2014 17:15:05 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Kurt,
   
       Using the test code given by you I have developed an app but I am 
facing some issues i don't know its j1939 limitation or the stack.

1.I want to transmit and single frame message RACM message 
   canId--18EAFEFF data 00EE00FFFFFFFFFFFF it asks to bind address with 0xFE

   note -can i transmit single frame message like raw can from any source 
address       
to  any dest address.
    I think address claim is needed for only TP message

2. In case of multiple address claims like 0x80 and 0x90 if i want to  
transmit the data from both address parallel y do i need to create different 
socket for each address?

3.It don't reply for RACM message if i send from different  adapter
  example: 18EAFEFF#00EE00FFFFFFFFFFFF j1939 stack should reply with claimed 
address Like 80 and 90 
 
        I was busy in creating the app  to test the linux j1939 stack on 
begalbone Black. thank you very much for the test programs those helped me 
a lot 

Thank 
Swapnil

