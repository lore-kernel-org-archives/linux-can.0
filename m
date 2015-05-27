From: Ssagarr Patil <hugarsagar@outlook.com>
Subject: ip -details link fails
Date: Wed, 27 May 2015 22:08:35 +0530
Message-ID: <BAY176-W131B8CC6A9756B64828C77D3CB0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bay004-omc2s22.hotmail.com ([65.54.190.97]:64198 "EHLO
	BAY004-OMC2S22.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753259AbbE0Qqf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 27 May 2015 12:46:35 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi,

I am currently using the following version of can driver 
# cat /proc/net/can/version
rev 20120528 abi 9

But when I do the following it fails,

# ip -details link show can0
RTNETLINK answers: Invalid argument
Cannot send link get request: Invalid argument

Transmitting and reciving of can frames works.

I want to get the current bitrate of the CAN interface using the above command,
can anyone point me to what exactly is missing ? Or is there any alternative to get
the current bitrate of the CAN interface (ioctl/ sysfs entry..)

Thanks,
Sagar
 		 	   		  