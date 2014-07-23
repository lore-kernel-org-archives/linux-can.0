From: Ssagarr Patil <hugarsagar@outlook.com>
Subject: C_CAN: can frame drops
Date: Wed, 23 Jul 2014 20:18:44 +0530
Message-ID: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bay004-omc2s4.hotmail.com ([65.54.190.79]:54609 "EHLO
	BAY004-OMC2S4.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940AbaGWOxu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Jul 2014 10:53:50 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi,

I am using the c_can driver for latest kernel and using the latest canutils to dump to a file.
My can bus is set at a rate of 1Mb (receiving 7000fps bus load of 80%).

When I use the candump tool to dump can frames I get following message,

'DROPCOUNT: dropped 2223 CAN frames on 'any' socket (total drops 1629092)'

SO to solve this problem if I use the -r option of candump and tried 
candump any -d -e -r 999999999 -l

If I do this the can frames are dropped in the driver ie I see 
this c_can_handle_lost_msg_obj() function being called frequently in which can frame
is overwritten.

How to solve this issue any pointers would be helpful.

Thanks,
--Sagar
 		 	   		  