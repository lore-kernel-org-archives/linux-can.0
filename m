From: Felix Seitz <felix.seitz@thm-motorsport.de>
Subject: cansniffer loop time
Date: Tue, 24 Jun 2014 17:21:40 +0200
Message-ID: <53A99784.5020609@thm-motorsport.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:63792 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887AbaFXPVm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Jun 2014 11:21:42 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi there,

we from THM Motorsport are using the cansniffer running on a Raspberry 
Pi to read out sensor data traffic on the CANbus in our car.
I would like to set the cansniffer's loop time lower than 100ms. I tried 
to changing the source code but apparently I don't fully understand 
where the loop delay comes from.
Could you give me some tips on how to set a lower delay for the 
cansniffer? 20ms delay would be perfect.

Regards,
Felix Seitz
