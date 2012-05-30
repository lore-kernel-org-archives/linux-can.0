From: Martin Kozusky <mkozusky@kkmicro.cz>
Subject: can4linux compilation for i.mx25 under 2.6.39
Date: Wed, 30 May 2012 13:39:26 +0200
Message-ID: <jq50tg$55u$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33139 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039Ab2E3Ljq (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 30 May 2012 07:39:46 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1SZhFg-0001Xk-Ku
	for linux-can@vger.kernel.org; Wed, 30 May 2012 13:39:44 +0200
Received: from 213.191.105.242 ([213.191.105.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 30 May 2012 13:39:44 +0200
Received: from mkozusky by 213.191.105.242 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 30 May 2012 13:39:44 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,
I downloaded latest sources of can4linux from svn and I'm trying to 
compile it for 2.6.39 kernel (i.mx25 driver).
I edit cross-imx25 with proper compiler settings etc then ". 
cross-imx25" and "make"

There are some errors like
core.c:441:12: error: 'CAN1_BASE_ADDR' undeclared
core.c:452:11: error: 'MXC_INT_CAN1' undeclared

I can change CAN1_BASE_ADDR to MX25_CAN1_BASE_ADDR and MXC_INT_CAN1 to 
MX25_INT_CAN1, but there is error

imx35.c:18:26: fatal error: mach/mxc_can.h: No such file or directory

Does anybody have idea where do I get this file? When I comment this 
line, compilation continues and stops at

imx35.c:113:18: error: dereferencing pointer to incomplete type

Does it have anything to do with Karo tx25 board? (which I'm not using)
I already have CAN running using SocketCAN, but I also wanted to try 
can4linux.

Thanks for any help,
Martin

