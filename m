From: Ssagarr Patil <hugarsagar@outlook.com>
Subject: RE: C_CAN: can frame drops
Date: Fri, 25 Jul 2014 13:50:40 +0530
Message-ID: <BAY176-W3963100D46A519A34EBE75D3FC0@phx.gbl>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl>,<53CFDD24.3070004@hartkopp.net>,<BAY176-W16B4D19E7BD30B2503C3AFD3FE0@phx.gbl>
 <BAY176-W506BABD46D0A520B9C1C52D3FF0@phx.gbl>,<53D14BE7.6030007@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bay004-omc3s15.hotmail.com ([65.54.190.153]:51197 "EHLO
	BAY004-OMC3S15.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753086AbaGYIUl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 25 Jul 2014 04:20:41 -0400
In-Reply-To: <53D14BE7.6030007@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

>
> unfortunately I'm not really a C_CAN expert.
>
> I know from a Beaglebone Black which run's at 99% busload without any issues
> on the two integrated D_CAN controllers.
>
Ok.

> Do you have these problems with a stock 2.6.37.x on your hardware too?
>
Yes

> Can you send the dmesg output of the c_can related content?
>
Unfortunately in c_can driver there are no lot of debug prints but
I am only concerned about function c_can_handle_lost_msg_obj() 
being called frequently in which can frame is overwritten.

Rest of the driver works fine.

Regards,
--Sagar

 		 	   		  