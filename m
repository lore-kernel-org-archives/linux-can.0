From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RFC/PATCH] c_can: add driver for the PCH CAN controller
Date: Wed, 07 Mar 2012 08:31:40 +0100
Message-ID: <2646233.lgKcZ8lAQj@ws-stein>
References: <4F44E640.8010708@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:39332 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753167Ab2CGHbq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Mar 2012 02:31:46 -0500
In-Reply-To: <4F44E640.8010708@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, "bhupesh.sharma" <bhupesh.sharma@st.com>, Tomoya MORINAGA <tomoya.rohm@gmail.com>

Hello Wolfgang,

Am Mittwoch, 22. Februar 2012, 13:57:36 schrieb Wolfgang Grandegger:
> For maintenance reasons, this diver should replace the "pch_can" driver
> sooner than later as it uses the same CAN controller core. I named it
> "pch_pci". Maybe "pch_can" would be more appropriate (common). This
> patch is for 2.6.39, but likely it applies fine also to more recent
> versions of the Linux kernel.
> 
> Alexander, Tomoya, or anybody else, it would be nice if you could test
> this patch and give some feedback. Thanks.

Unfortunately this doesn't work, yet. I do get a can0 interface but I don't 
receive/send messages actually to the bus. I disabled pch_can in the kernel 
config and enabled CONFIG_CAN_C_CAN and CONFIG_CAN_C_CAN_PCH_PCI
All messages containging "can" (related to CAN) I get in dmesg are:
[    0.338083] CAN device driver interface                                                                                                                                                                           
[    0.339059] pch_pci 0000:02:0c.3: can0: Features changed: 0x00004804 -> 
0x00004004                                                                                                                                
[    0.827528] can: controller area network core (rev 20090105 abi 8)                                                                                                                                                
[    0.827646] can: raw protocol (rev 20090105)                                                                                                                                                                      
[    9.773280] pch_pci 0000:02:0c.3: can0: setting BTR=2504 BRPE=0000

I also noted that my system does noot reboot when using "reboot". This works 
fine when using pch_can.
Unfortunately I can't spend more time on testing this at the moment.

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
August-Bebel-Str. 29
D-07973 Greiz

Tel: +49-3661-6279-0, Fax: +49-3661-6279-99
eMail:    Alexander.Stein@systec-electronic.com
Internet: http://www.systec-electronic.com

Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Jena, HRB 205563
